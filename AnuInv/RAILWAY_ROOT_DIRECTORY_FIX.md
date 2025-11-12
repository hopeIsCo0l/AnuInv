# 🚨 Railway Root Directory Fix - URGENT

## The Problem
Railway is seeing `./AnuInv/` which means **Root Directory is NOT set** in Railway UI.

## ✅ SOLUTION: Set Root Directory in Railway UI

### Step-by-Step Instructions:

#### For Backend Service:

1. **Go to Railway Dashboard**
   - Open your Railway project
   - Click on your **Backend Service**

2. **Open Settings**
   - Click on **"Settings"** tab (top menu)
   - Scroll down to **"Root Directory"** section

3. **Set Root Directory**
   - In the **"Root Directory"** field, type: `backend`
   - Click **"Save"** or **"Update"**

4. **Redeploy**
   - Railway will automatically redeploy
   - Or click **"Redeploy"** button manually

#### For Frontend Service:

1. **Go to Railway Dashboard**
   - Click on your **Frontend Service**

2. **Open Settings**
   - Click on **"Settings"** tab
   - Find **"Root Directory"** section

3. **Set Root Directory**
   - In the **"Root Directory"** field, type: `frontend`
   - Click **"Save"**

4. **Redeploy**
   - Railway will automatically redeploy

## 📍 Where to Find Root Directory Setting

**Railway UI Path:**
```
Service → Settings Tab → Root Directory (scroll down)
```

**Visual Guide:**
```
┌─────────────────────────────────┐
│  Railway Service Dashboard      │
├─────────────────────────────────┤
│  [Deployments] [Variables]      │
│  [Settings] ← CLICK HERE        │
│  [Metrics] [Logs]               │
├─────────────────────────────────┤
│  Settings Page:                 │
│  ┌───────────────────────────┐ │
│  │ Root Directory:            │ │
│  │ [backend        ] [Save]  │ │ ← TYPE HERE
│  └───────────────────────────┘ │
└─────────────────────────────────┘
```

## 🔄 Alternative: Use Docker (If Root Directory Doesn't Work)

If you can't find Root Directory setting, use Docker instead:

1. **Go to Service Settings**
2. **Change Builder** from "Nixpacks" to **"Dockerfile"**
3. **Set Root Directory** to: `backend` or `frontend`
4. Railway will use the `Dockerfile` instead

**To switch to Docker:**
- Settings → Build → Builder → Select **"Dockerfile"**
- Root Directory → Set to `backend` or `frontend`

## ✅ Verification

After setting Root Directory, Railway should:
- ✅ Detect `package.json` in the correct directory
- ✅ Start building with Nixpacks
- ✅ Show build logs instead of "could not determine how to build"

## 🆘 Still Not Working?

If Root Directory setting is not visible:

1. **Delete the service** in Railway
2. **Create a new service** from GitHub repo
3. **BEFORE deploying**, go to Settings → Set Root Directory
4. **Then** add variables and deploy

## Quick Fix Checklist

- [ ] Backend Service → Settings → Root Directory = `backend`
- [ ] Frontend Service → Settings → Root Directory = `frontend`
- [ ] Both services redeployed
- [ ] Build logs show Node.js detection

---

**The Root Directory MUST be set BEFORE Railway tries to build, or it will fail!**

