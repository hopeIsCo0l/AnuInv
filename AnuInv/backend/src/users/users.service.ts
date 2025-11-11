import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { Role } from '@prisma/client';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async findAll(userRole: Role, userId: string) {
    // Non-admin Yees can only see themselves
    if (userRole === 'NonAdminYee') {
      return this.prisma.user.findUnique({
        where: { id: userId },
        select: {
          id: true,
          yNumber: true,
          fullName: true,
          email: true,
          phone: true,
          role: true,
          createdAt: true,
          updatedAt: true,
        },
      });
    }

    // Admin Yees and Yer can see all users
    return this.prisma.user.findMany({
      select: {
        id: true,
        yNumber: true,
        fullName: true,
        email: true,
        phone: true,
        role: true,
        createdAt: true,
        updatedAt: true,
      },
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  async findOne(id: string, userRole: Role, userId: string) {
    // Non-admin Yees can only see themselves
    if (userRole === 'NonAdminYee' && id !== userId) {
      throw new ForbiddenException('You can only view your own profile');
    }

    const user = await this.prisma.user.findUnique({
      where: { id },
      select: {
        id: true,
        yNumber: true,
        fullName: true,
        email: true,
        phone: true,
        role: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    if (!user) {
      throw new NotFoundException('User not found');
    }

    return user;
  }

  async update(id: string, updateUserDto: UpdateUserDto, userRole: Role, userId: string) {
    // Non-admin Yees can only update themselves
    if (userRole === 'NonAdminYee' && id !== userId) {
      throw new ForbiddenException('You can only update your own profile');
    }

    // Only Yer can change roles
    if (updateUserDto.role && userRole !== 'Yer') {
      throw new ForbiddenException('Only Yer can change user roles');
    }

    const user = await this.prisma.user.findUnique({
      where: { id },
    });

    if (!user) {
      throw new NotFoundException('User not found');
    }

    return this.prisma.user.update({
      where: { id },
      data: updateUserDto,
      select: {
        id: true,
        yNumber: true,
        fullName: true,
        email: true,
        phone: true,
        role: true,
        createdAt: true,
        updatedAt: true,
      },
    });
  }

  async remove(id: string, userRole: Role) {
    // Only Yer can delete users
    if (userRole !== 'Yer') {
      throw new ForbiddenException('Only Yer can delete users');
    }

    const user = await this.prisma.user.findUnique({
      where: { id },
    });

    if (!user) {
      throw new NotFoundException('User not found');
    }

    await this.prisma.user.delete({
      where: { id },
    });

    return { message: 'User deleted successfully' };
  }
}

