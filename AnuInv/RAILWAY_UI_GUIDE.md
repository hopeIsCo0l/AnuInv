# Railway Root Directory - Visual Guide

## 🎯 CRITICAL: You MUST Set Root Directory

Railway cannot detect your project because it's looking at the wrong directory level.

## 📸 Step-by-Step with Railway UI

### Step 1: Open Your Service
1. Go to [railway.app](https://railway.app)
2. Open your project
3. Click on **Backend Service** (or Frontend)

### Step 2: Navigate to Settings
```
┌─────────────────────────────────────┐
│  Backend Service                    │
├─────────────────────────────────────┤
│  [Deployments] [Variables]          │
│  [Settings] ← CLICK THIS TAB        │
│  [Metrics] [Logs]                   │
└─────────────────────────────────────┘
```

### Step 3: Find Root Directory Field
Scroll down in Settings until you see:

```
┌─────────────────────────────────────┐
│  Service Settings                   │
├─────────────────────────────────────┤
│  ...                                │
│                                     │
│  Root Directory:                   │
│  ┌───────────────────────────────┐ │
│  │                               │ │ ← EMPTY FIELD
│  └───────────────────────────────┘ │
│                                     │
│  [Save Changes]                     │
└─────────────────────────────────────┘
```

### Step 4: Enter Root Directory
Type in the field:

**For Backend:**
```
┌─────────────────────────────────────┐
│  Root Directory:                   │
│  ┌───────────────────────────────┐ │
│  │ backend                       │ │ ← TYPE: backend
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
```

**For Frontend:**
```
┌─────────────────────────────────────┐
│  Root Directory:                   │
│  ┌───────────────────────────────┐ │
│  │ frontend                      │ │ ← TYPE: frontend
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
```

### Step 5: Save and Redeploy
1. Click **"Save Changes"** or **"Update"**
2. Railway will automatically redeploy
3. Watch the build logs - it should now detect Node.js!

## ✅ Success Indicators

After setting Root Directory, you should see in build logs:

```
✅ Detected Node.js project
✅ Found package.json
✅ Running npm ci
✅ Building...
```

Instead of:
```
❌ Railpack could not determine how to build
❌ Script start.sh not found
```

## 🔄 If Root Directory Field is Missing

Some Railway interfaces hide this setting. Try:

1. **Edit Service** → Look for "Root Directory" or "Working Directory"
2. **Service Configuration** → Advanced Settings
3. **Delete and Recreate** the service, set Root Directory during creation

## 🐳 Fallback: Use Docker

If Root Directory doesn't work:

1. Settings → **Builder** → Change to **"Dockerfile"**
2. Set Root Directory to `backend` or `frontend`
3. Railway will use `Dockerfile` instead of Nixpacks

---

**Remember: Root Directory = `backend` for backend, `frontend` for frontend!**

