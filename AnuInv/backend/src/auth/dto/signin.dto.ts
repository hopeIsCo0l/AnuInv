import { IsString, MinLength } from 'class-validator';

export class SignInDto {
  @IsString()
  emailOrPhone: string;

  @IsString()
  @MinLength(6)
  password: string;
}

