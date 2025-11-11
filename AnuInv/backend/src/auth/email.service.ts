import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';

@Injectable()
export class EmailService {
  private transporter: nodemailer.Transporter;

  constructor(private configService: ConfigService) {
    this.transporter = nodemailer.createTransport({
      host: this.configService.get<string>('SMTP_HOST') || 'smtp.gmail.com',
      port: this.configService.get<number>('SMTP_PORT') || 587,
      secure: false,
      auth: {
        user: this.configService.get<string>('SMTP_USER'),
        pass: this.configService.get<string>('SMTP_PASS'),
      },
    });
  }

  async sendOtpEmail(email: string, otpCode: string): Promise<void> {
    const fromEmail = this.configService.get<string>('SMTP_FROM') || 'noreply@anuinv.com';

    const mailOptions = {
      from: fromEmail,
      to: email,
      subject: 'AnuInv Sys - OTP Verification',
      html: `
        <h2>OTP Verification</h2>
        <p>Your OTP code is: <strong>${otpCode}</strong></p>
        <p>This code will expire in 10 minutes.</p>
        <p>If you didn't request this code, please ignore this email.</p>
      `,
    };

    try {
      await this.transporter.sendMail(mailOptions);
    } catch (error) {
      console.error('Error sending email:', error);
      // In production, you might want to throw an error or use a queue
      // For now, we'll just log it
    }
  }
}

