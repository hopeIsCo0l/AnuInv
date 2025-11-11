import {
  Injectable,
  UnauthorizedException,
  BadRequestException,
  ConflictException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';
import { UsersService } from '../users/users.service';
import { OtpService } from './otp.service';
import { EmailService } from './email.service';
import { SignUpDto } from './dto/signup.dto';
import { SignInDto } from './dto/signin.dto';
import { VerifyOtpDto } from './dto/verify-otp.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private usersService: UsersService,
    private jwtService: JwtService,
    private otpService: OtpService,
    private emailService: EmailService,
  ) {}

  async signUp(signUpDto: SignUpDto) {
    const { email, phone, fullName, password } = signUpDto;

    // Check if user already exists
    const existingUser = await this.prisma.user.findFirst({
      where: {
        OR: [{ email }, { phone }],
      },
    });

    if (existingUser) {
      throw new ConflictException('User with this email or phone already exists');
    }

    // Generate Y-number
    const yNumber = await this.generateYNumber();

    // Hash password
    const passwordHash = await bcrypt.hash(password, 10);

    // Create user (not verified yet)
    const user = await this.prisma.user.create({
      data: {
        yNumber,
        fullName,
        email,
        phone,
        passwordHash,
        role: 'NonAdminYee', // Default role
      },
    });

    // Generate and send OTP
    const otp = await this.otpService.generateOtp(user.id);
    await this.emailService.sendOtpEmail(user.email, otp.otpCode);

    return {
      message: 'User created successfully. Please verify your email with OTP.',
      userId: user.id,
      yNumber: user.yNumber,
    };
  }

  async verifyOtp(verifyOtpDto: VerifyOtpDto) {
    const { userId, otpCode } = verifyOtpDto;

    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new BadRequestException('User not found');
    }

    const isValid = await this.otpService.verifyOtp(userId, otpCode);

    if (!isValid) {
      throw new UnauthorizedException('Invalid or expired OTP');
    }

    // OTP is valid, user is now verified
    // In a real app, you might want to add an `isVerified` field to the User model

    return {
      message: 'OTP verified successfully',
      userId: user.id,
    };
  }

  async signIn(signInDto: SignInDto) {
    const { emailOrPhone, password } = signInDto;

    // Find user by email or phone
    const user = await this.prisma.user.findFirst({
      where: {
        OR: [{ email: emailOrPhone }, { phone: emailOrPhone }],
      },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Verify password
    const isPasswordValid = await bcrypt.compare(password, user.passwordHash);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Generate JWT token
    const payload = {
      sub: user.id,
      email: user.email,
      role: user.role,
      yNumber: user.yNumber,
    };

    const accessToken = this.jwtService.sign(payload);

    return {
      accessToken,
      user: {
        id: user.id,
        yNumber: user.yNumber,
        fullName: user.fullName,
        email: user.email,
        phone: user.phone,
        role: user.role,
      },
    };
  }

  async generateYNumber(): Promise<string> {
    // Get the latest Y-number
    const lastUser = await this.prisma.user.findFirst({
      orderBy: { yNumber: 'desc' },
    });

    let nextNumber = 1;

    if (lastUser) {
      // Extract number from Y-number (e.g., Y00001 -> 1)
      const lastNumber = parseInt(lastUser.yNumber.substring(1));
      nextNumber = lastNumber + 1;
    }

    // Format as Y00001, Y00002, etc.
    const yNumber = `Y${nextNumber.toString().padStart(5, '0')}`;

    // Check if we've reached the limit (Y99999)
    if (nextNumber > 99999) {
      throw new BadRequestException('Maximum number of users reached');
    }

    return yNumber;
  }

  async validateUser(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        yNumber: true,
        fullName: true,
        email: true,
        phone: true,
        role: true,
      },
    });

    return user;
  }
}

