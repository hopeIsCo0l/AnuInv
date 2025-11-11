# AnuInv Sys - Candy Factory Management System

A comprehensive web-based application for managing candy factory operations, including warehouse management, inventory tracking, payroll, attendance, and work reporting.

## 🚀 Features

- **Role-Based Access Control**: Yer (Employer), Admin Yee, and Non-Admin Yee roles
- **User Authentication**: Signup, signin with OTP verification and JWT
- **Warehouse Management**: Create, assign, and manage warehouses
- **Inventory Tracking**: Track Raw Materials, WIP, Finished Goods, and Waste
- **Payroll Management**: Automate salary tracking and reporting
- **Attendance Monitoring**: Record and track employee attendance
- **Work Reports**: Submit and view attendance-linked and inventory-linked reports
- **Audit Logging**: Track all critical system actions

## 🛠️ Technology Stack

### Backend
- **Framework**: NestJS
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: JWT + OTP (Email)
- **Validation**: class-validator, class-transformer

### Frontend
- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **UI**: React

## 📁 Project Structure

```
AnuInv/
├── backend/          # NestJS backend application
│   ├── src/
│   │   ├── auth/     # Authentication module
│   │   ├── users/    # User management module
│   │   ├── prisma/   # Prisma service
│   │   └── main.ts   # Application entry point
│   ├── prisma/
│   │   └── schema.prisma  # Database schema
│   └── package.json
├── frontend/         # Next.js frontend application
│   ├── src/
│   │   ├── app/      # Next.js app directory
│   │   └── components/
│   └── package.json
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Node.js (v18 or higher)
- PostgreSQL (v14 or higher)
- npm or yarn

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file in the backend directory:
```env
DATABASE_URL="postgresql://user:password@localhost:5432/anuinv_db?schema=public"
JWT_SECRET="your-super-secret-jwt-key-change-this-in-production"
JWT_EXPIRES_IN="7d"
OTP_EXPIRES_IN_MINUTES=10
SMTP_HOST="smtp.gmail.com"
SMTP_PORT=587
SMTP_USER="your-email@gmail.com"
SMTP_PASS="your-app-password"
SMTP_FROM="noreply@anuinv.com"
PORT=3000
NODE_ENV=development
```

4. Generate Prisma client:
```bash
npm run prisma:generate
```

5. Run database migrations:
```bash
npm run prisma:migrate
```

6. Start the development server:
```bash
npm run start:dev
```

The backend will be running on `http://localhost:3000`

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env.local` file:
```env
NEXT_PUBLIC_API_URL=http://localhost:3000/api
```

4. Start the development server:
```bash
npm run dev
```

The frontend will be running on `http://localhost:3001`

## 📚 API Endpoints

### Authentication
- `POST /api/auth/signup` - Register a new user
- `POST /api/auth/verify-otp` - Verify OTP code
- `POST /api/auth/signin` - Sign in user
- `GET /api/auth/profile` - Get current user profile (Protected)

### Users
- `GET /api/users` - Get all users (Role-based)
- `GET /api/users/:id` - Get user by ID (Role-based)
- `PUT /api/users/:id` - Update user (Role-based)
- `DELETE /api/users/:id` - Delete user (Yer only)

## 🔐 User Roles

### Yer (Employer/Manager)
- Full control over warehouses, payroll, attendance, inventory, and work reports
- Can assign Admins and Yees
- Can disable warehouses
- Can view and manipulate all audit logs

### Admin Yee
- Can manage inventory, payroll, attendance, and work reports
- Can assign/reassign non-admin Yees within their warehouse
- Cannot assign other Admins or disable warehouses

### Non-Admin Yee (Worker)
- View-only access to assigned warehouse data
- Can view own work reports, attendance, and payroll information
- Cannot submit work reports, update inventory, or manipulate warehouse data

## 🗄️ Database Schema

The database includes the following main tables:
- `users` - User accounts with roles
- `warehouses` - Warehouse information
- `warehouse_assignments` - User-warehouse assignments
- `inventory` - Inventory items (Raw Materials, WIP, Finished Goods, Waste)
- `payroll` - Payroll records
- `attendance` - Attendance records
- `work_reports` - Work reports (attendance-linked and inventory-linked)
- `otps` - OTP tokens for verification
- `audit_logs` - Audit trail for all actions

## 🔧 Development

### Backend Commands
```bash
npm run start:dev    # Start development server
npm run build        # Build for production
npm run start:prod   # Start production server
npm run prisma:generate  # Generate Prisma client
npm run prisma:migrate   # Run database migrations
npm run prisma:studio    # Open Prisma Studio
```

### Frontend Commands
```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

## 📝 License

MIT

## 👥 Authors

AnuInv Sys Development Team

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

