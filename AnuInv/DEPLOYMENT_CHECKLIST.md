# Railway Deployment Checklist

Use this checklist to ensure a smooth deployment on Railway.

## Pre-Deployment

- [ ] Code pushed to GitHub repository
- [ ] All environment variables documented
- [ ] Database schema finalized
- [ ] CORS configuration updated
- [ ] Health checks configured

## Railway Setup

### Backend Service

- [ ] Create new Railway project
- [ ] Add PostgreSQL database service
- [ ] Add backend service (root directory: `backend`)
- [ ] Configure environment variables:
  - [ ] `DATABASE_URL=${{Postgres.DATABASE_URL}}`
  - [ ] `JWT_SECRET` (min 32 characters)
  - [ ] `JWT_EXPIRES_IN=7d`
  - [ ] `PORT=3000`
  - [ ] `NODE_ENV=production`
  - [ ] `FRONTEND_URL` (set after frontend deployment)
  - [ ] `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS` (optional)
- [ ] Configure build settings:
  - [ ] Build Command: `npm install && npx prisma generate && npm run build`
  - [ ] Start Command: `sh -c 'npx prisma migrate deploy && npm run start:prod'`
- [ ] Generate domain for backend
- [ ] Verify backend is running and accessible

### Frontend Service

- [ ] Add frontend service (root directory: `frontend`)
- [ ] Configure environment variables:
  - [ ] `NEXT_PUBLIC_API_URL` (backend URL + `/api`)
  - [ ] `NODE_ENV=production`
- [ ] Configure build settings:
  - [ ] Build Command: `npm install && npm run build`
  - [ ] Start Command: `npm run start`
- [ ] Generate domain for frontend
- [ ] Update backend `FRONTEND_URL` with frontend domain
- [ ] Verify frontend is running and accessible

## Post-Deployment

- [ ] Test backend API endpoints
- [ ] Test frontend connection to backend
- [ ] Verify database migrations ran successfully
- [ ] Check application logs for errors
- [ ] Test authentication flow (signup, signin)
- [ ] Verify CORS is working correctly
- [ ] Test OTP email functionality (if configured)
- [ ] Monitor resource usage
- [ ] Set up custom domains (optional)
- [ ] Configure SSL certificates (automatic on Railway)

## Testing Checklist

### Backend API Tests

- [ ] `POST /api/auth/signup` - User registration
- [ ] `POST /api/auth/verify-otp` - OTP verification
- [ ] `POST /api/auth/signin` - User login
- [ ] `GET /api/auth/profile` - Get user profile (protected)
- [ ] `GET /api/users` - Get users (role-based)
- [ ] `GET /api/users/:id` - Get user by ID

### Frontend Tests

- [ ] Frontend loads successfully
- [ ] API calls to backend work
- [ ] Authentication flow works
- [ ] Error handling works
- [ ] Responsive design works

## Troubleshooting

### Common Issues

- [ ] **Database connection errors**: Check `DATABASE_URL` format
- [ ] **Migration failures**: Check database permissions
- [ ] **CORS errors**: Verify `FRONTEND_URL` in backend
- [ ] **Build failures**: Check Node.js version and dependencies
- [ ] **Port issues**: Railway handles ports automatically
- [ ] **Environment variables**: Restart services after changes

### Debugging Steps

1. Check Railway deployment logs
2. Verify environment variables
3. Test API endpoints with curl/Postman
4. Check database connection
5. Verify CORS configuration
6. Check Prisma migrations

## Monitoring

- [ ] Set up log monitoring
- [ ] Monitor resource usage (CPU, Memory)
- [ ] Set up alerts for errors
- [ ] Track API response times
- [ ] Monitor database performance

## Security

- [ ] Use strong `JWT_SECRET`
- [ ] Enable HTTPS (automatic on Railway)
- [ ] Verify CORS configuration
- [ ] Check environment variables are secure
- [ ] Review database access permissions
- [ ] Enable rate limiting (future enhancement)

## Documentation

- [ ] Update API documentation
- [ ] Document environment variables
- [ ] Create deployment runbook
- [ ] Document troubleshooting steps
- [ ] Update README with deployment info

## Rollback Plan

- [ ] Know how to rollback to previous deployment
- [ ] Keep database backup before major changes
- [ ] Test rollback procedure
- [ ] Document rollback steps

## Success Criteria

- [ ] Backend API is accessible
- [ ] Frontend is accessible
- [ ] Database migrations completed
- [ ] Authentication works
- [ ] No critical errors in logs
- [ ] Application is responsive
- [ ] CORS is configured correctly

---

**Last Updated**: $(date)
**Deployment Date**: ___________
**Deployed By**: ___________

