# AnuInv Sys Frontend

Next.js frontend application for AnuInv Sys - Candy Factory Management System.

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create `.env.local` file:
```env
NEXT_PUBLIC_API_URL=http://localhost:3000/api
```

3. Start development server:
```bash
npm run dev
```

The application will be available at `http://localhost:3001`

## Environment Variables

- `NEXT_PUBLIC_API_URL` - Backend API URL

## Features

- Role-based dashboards (Yer, Admin Yee, Non-Admin Yee)
- User authentication (Signup, Signin, OTP verification)
- Warehouse management
- Inventory tracking
- Payroll management
- Attendance monitoring
- Work reports

## Development

```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```
