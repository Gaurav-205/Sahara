# Firestore Rules Guide

## 🚨 IMPORTANT: Current Status

**Current Mode:** DEVELOPMENT (Open Access)  
**Security Level:** ⚠️ LOW - Anyone can read/write

The current `firestore.rules` file has **open access** to allow seeding the database. This is **TEMPORARY** for development only.

---

## 📁 Files Overview

### 1. `firestore.rules` (Current - DEV MODE)
- **Status:** Open access for seeding
- **Security:** ⚠️ LOW
- **Use:** Development and testing only
- **Allows:** All reads and writes without authentication

### 2. `firestore.rules.dev` (Template)
- **Status:** Development template
- **Security:** ⚠️ LOW
- **Use:** Copy to `firestore.rules` for seeding

### 3. `firestore.rules.prod` (Template)
- **Status:** Production template
- **Security:** ✅ HIGH
- **Use:** Copy to `firestore.rules` for production
- **Requires:** Authentication and authorization

---

## 🔧 How to Deploy Rules

### Step 1: Deploy Development Rules (For Seeding)

**Current state:** Already deployed in `firestore.rules`

**To deploy to Firebase:**

#### Option A: Firebase Console (Easiest)
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **sahara-a72**
3. Go to **Firestore Database** → **Rules**
4. Copy content from `firestore.rules`
5. Click **Publish**

#### Option B: Firebase CLI
```bash
cd sahara
firebase deploy --only firestore:rules
```

### Step 2: Seed Your Database

Once development rules are deployed:

1. Open your app
2. Go to Firebase Data Seeder screen
3. Click "Seed All Data"
4. Wait for completion

### Step 3: Switch to Production Rules

**⚠️ CRITICAL: Do this before going live!**

1. **Backup current rules:**
   ```bash
   cp firestore.rules firestore.rules.backup
   ```

2. **Copy production rules:**
   ```bash
   cp firestore.rules.prod firestore.rules
   ```

3. **Deploy to Firebase:**
   - **Console:** Copy `firestore.rules.prod` content → Publish
   - **CLI:** `firebase deploy --only firestore:rules`

4. **Verify:** Test that unauthorized access is blocked

---

## 🔒 Production Rules Features

### Security Levels

#### Public Read
- ✅ User profiles (for browsing caregivers)
- ✅ Service packages
- ✅ Reviews

#### Authenticated Read
- ✅ Own pets
- ✅ Own bookings
- ✅ Chats you're part of
- ✅ Own notifications
- ✅ Own favorites

#### Authenticated Write
- ✅ Create own profile
- ✅ Update own profile
- ✅ Create/update/delete own pets
- ✅ Create bookings
- ✅ Send messages in your chats
- ✅ Create reviews for your bookings

#### Admin Only
- ✅ Delete users
- ✅ Create/update/delete service packages

---

## 🧪 Testing Rules

### Test Development Rules (Current)
```dart
// Should work - no auth needed
await FirebaseFirestore.instance
  .collection('users')
  .add({'name': 'Test'});
```

### Test Production Rules
```dart
// Should fail - needs auth
await FirebaseFirestore.instance
  .collection('users')
  .add({'name': 'Test'});

// Should work - with auth
final user = FirebaseAuth.instance.currentUser;
await FirebaseFirestore.instance
  .collection('users')
  .doc(user!.uid)
  .set({'name': 'Test', 'userType': 'owner'});
```

---

## 📋 Deployment Checklist

### Before Seeding
- [ ] Deploy development rules (`firestore.rules`)
- [ ] Verify rules in Firebase Console
- [ ] Test write access works

### After Seeding
- [ ] Verify data is seeded correctly
- [ ] Check caregiver profiles appear
- [ ] Check service packages appear

### Before Production
- [ ] Copy `firestore.rules.prod` to `firestore.rules`
- [ ] Deploy production rules
- [ ] Test authentication works
- [ ] Test unauthorized access is blocked
- [ ] Verify app functionality with secure rules

---

## ⚠️ Common Issues

### Issue 1: Permission Denied During Seeding
**Cause:** Production rules are active  
**Fix:** Deploy development rules

```bash
cp firestore.rules.dev firestore.rules
firebase deploy --only firestore:rules
```

### Issue 2: Anyone Can Write in Production
**Cause:** Development rules still active  
**Fix:** Deploy production rules immediately!

```bash
cp firestore.rules.prod firestore.rules
firebase deploy --only firestore:rules
```

### Issue 3: Users Can't Create Profiles
**Cause:** Production rules require auth  
**Fix:** This is correct! Users must sign up first

---

## 🎯 Quick Commands

### Deploy Development Rules
```bash
cd sahara
cp firestore.rules.dev firestore.rules
firebase deploy --only firestore:rules
```

### Deploy Production Rules
```bash
cd sahara
cp firestore.rules.prod firestore.rules
firebase deploy --only firestore:rules
```

### View Current Rules
```bash
firebase firestore:rules:get
```

### Test Rules Locally
```bash
firebase emulators:start --only firestore
```

---

## 📊 Rules Comparison

| Feature | Development | Production |
|---------|-------------|------------|
| Read Access | ✅ Anyone | ⚠️ Restricted |
| Write Access | ✅ Anyone | ⚠️ Auth Required |
| User Creation | ✅ Anyone | ⚠️ Own Profile Only |
| Service Packages | ✅ Anyone | ⚠️ Admin Only |
| Security | ❌ None | ✅ Full |
| Use Case | Seeding/Testing | Live App |

---

## 🚀 Recommended Workflow

### Development Phase
1. Use development rules
2. Seed database
3. Test features
4. Iterate

### Pre-Production
1. Switch to production rules
2. Test authentication
3. Verify security
4. Test all features

### Production
1. Keep production rules active
2. Monitor security
3. Never switch back to dev rules
4. Use admin accounts for data management

---

## 💡 Best Practices

### DO ✅
- Use development rules for seeding
- Switch to production before launch
- Test rules thoroughly
- Keep production rules secure
- Use admin accounts for management

### DON'T ❌
- Deploy dev rules to production
- Leave open access in production
- Skip security testing
- Share admin credentials
- Modify production rules without testing

---

## 📞 Need Help?

### Firebase Console
https://console.firebase.google.com/project/sahara-a72/firestore/rules

### Firebase Documentation
https://firebase.google.com/docs/firestore/security/get-started

### Test Rules
https://firebase.google.com/docs/firestore/security/test-rules-emulator

---

**Current Status:** Development rules active for seeding  
**Next Step:** Deploy rules to Firebase Console and run seeder  
**Before Production:** Switch to production rules!
