import { Injectable, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class OtpService {
  constructor(
    private prisma: PrismaService,
    private configService: ConfigService,
  ) {}

  async generateOtp(userId: string): Promise<{ otpCode: string; expiresAt: Date }> {
    // Generate 6-digit OTP
    const otpCode = Math.floor(100000 + Math.random() * 900000).toString();

    // Set expiration time (default 10 minutes)
    const expiresInMinutes = this.configService.get<number>('OTP_EXPIRES_IN_MINUTES') || 10;
    const expiresAt = new Date();
    expiresAt.setMinutes(expiresAt.getMinutes() + expiresInMinutes);

    // Delete old OTPs for this user
    await this.prisma.oTP.deleteMany({
      where: {
        userId,
        used: false,
      },
    });

    // Create new OTP
    await this.prisma.oTP.create({
      data: {
        userId,
        otpCode,
        expiresAt,
      },
    });

    return { otpCode, expiresAt };
  }

  async verifyOtp(userId: string, otpCode: string): Promise<boolean> {
    const otp = await this.prisma.oTP.findFirst({
      where: {
        userId,
        otpCode,
        used: false,
        expiresAt: {
          gte: new Date(),
        },
      },
    });

    if (!otp) {
      return false;
    }

    // Mark OTP as used
    await this.prisma.oTP.update({
      where: { id: otp.id },
      data: { used: true },
    });

    return true;
  }

  async resendOtp(userId: string): Promise<{ otpCode: string; expiresAt: Date }> {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new BadRequestException('User not found');
    }

    return this.generateOtp(userId);
  }
}

