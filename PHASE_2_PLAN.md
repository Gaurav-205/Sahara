# Phase 2 Plan - Main Navigation Screens

**Date:** February 27, 2026  
**Screens:** Home, My Pets, Bookings, Profile (4 screens)

---

## Industry Standards to Apply

### Typography (Material Design 3)
```
App Bar Title:    22px Title Large, w600
Section Titles:   20px Title Large, w600
Card Titles:      16px Title Medium, w600
Card Subtitles:   14px Body Medium, w400
Body Text:        14px Body Medium, w400
Captions:         12px Body Small, w400
Labels:           14px Label Large, w600
```

### Component Sizes
```
App Bar:          56px height
Search Bar:       48px height
Cards:            Auto height, 16px padding
List Items:       72px minimum height
Avatars:          40px (small), 56px (medium), 80px (large)
Icons:            20px (small), 24px (medium), 32px (large)
Buttons:          48px (small), 56px (large)
FAB:              56px standard, 64px extended
```

### Spacing (8pt Grid)
```
Card padding:     16px
Section spacing:  24px
List spacing:     12px
Grid spacing:     16px
Screen padding:   16-24px
```

### Colors
```
App Bar:          Primary (Navy)
Active Tab:       Secondary (Orange)
Cards:            Surface (White)
Dividers:         Border (Light Gray)
Icons:            Primary/Secondary/Accent
```

---

## Screen 1: Home Screen

### Current Structure
- Bottom navigation (4 tabs)
- Floating action button (quick actions)
- Home tab with:
  - Search bar
  - Service cards (4 types)
  - Top caregivers list
  - Tips section
  - Testimonials

### Enhancements Needed
✅ **App Bar**
- Height: 56px
- Title: 22px Title Large
- Search: 48px height
- Notification icon: 24px

✅ **Service Cards**
- Title: 16px Title Medium
- Description: 14px Body Medium
- Icon: 32px
- Padding: 16px
- Spacing: 16px grid

✅ **Caregiver Cards**
- Avatar: 56px
- Name: 16px Title Medium
- Rating: 14px Body Medium
- Specialty: 12px Body Small
- Height: 72px minimum

✅ **Bottom Navigation**
- Height: 64px
- Icons: 24px
- Labels: 12px Label Medium
- Active color: Orange
- Inactive: White 50%

✅ **FAB**
- Size: 64px
- Icon: 24px
- Elevation: Level 3

---

## Screen 2: My Pets Screen

### Current Structure
- App bar with title
- Pet list/grid
- Add pet button
- Empty state

### Enhancements Needed
✅ **App Bar**
- Height: 56px
- Title: 22px Title Large
- Add button: 48px

✅ **Pet Cards**
- Photo: 80px circle
- Name: 16px Title Medium
- Breed: 14px Body Medium
- Age/Weight: 12px Body Small
- Padding: 16px
- Spacing: 16px

✅ **Empty State**
- Icon: 80px
- Title: 20px Title Large
- Message: 14px Body Medium
- Button: 56px height

---

## Screen 3: Bookings Screen

### Current Structure
- App bar with title
- Filter chips
- Booking list
- Empty state

### Enhancements Needed
✅ **App Bar**
- Height: 56px
- Title: 22px Title Large
- Filter icon: 24px

✅ **Filter Chips**
- Height: 32px
- Text: 12px Label Medium
- Spacing: 8px
- Active: Orange
- Inactive: Border

✅ **Booking Cards**
- Service: 16px Title Medium
- Caregiver: 14px Body Medium
- Date/Time: 12px Body Small
- Status badge: 12px Label Small
- Padding: 16px
- Spacing: 12px

✅ **Empty State**
- Icon: 80px
- Title: 20px Title Large
- Message: 14px Body Medium
- Button: 56px height

---

## Screen 4: Profile Screen

### Current Structure
- User header
- Menu items
- Logout button

### Enhancements Needed
✅ **User Header**
- Avatar: 80px
- Name: 20px Title Large
- Email: 14px Body Medium
- Badge: 12px Label Small
- Padding: 24px

✅ **Menu Items**
- Height: 56px
- Icon: 24px
- Title: 16px Title Medium
- Subtitle: 12px Body Small
- Arrow: 20px
- Spacing: 8px

✅ **Logout Button**
- Height: 56px
- Text: 16px Body Large
- Icon: 20px
- Color: Error

---

## Implementation Order

### Priority 1: Home Screen (Most Complex)
- Time: 1-1.5 hours
- Components: 10+
- Complexity: High

### Priority 2: Profile Screen (Simplest)
- Time: 30 minutes
- Components: 5
- Complexity: Low

### Priority 3: My Pets Screen
- Time: 45 minutes
- Components: 6
- Complexity: Medium

### Priority 4: Bookings Screen
- Time: 45 minutes
- Components: 7
- Complexity: Medium

---

## Consistency Checklist

### Typography
- [ ] All titles: 22px Title Large
- [ ] All card titles: 16px Title Medium
- [ ] All body text: 14px Body Medium
- [ ] All captions: 12px Body Small

### Spacing
- [ ] All use 8pt grid
- [ ] Card padding: 16px
- [ ] Section spacing: 24px
- [ ] List spacing: 12px

### Colors
- [ ] App bars: Navy
- [ ] Active states: Orange
- [ ] Cards: White
- [ ] Text: Primary/Secondary/Tertiary

### Components
- [ ] App bars: 56px
- [ ] Buttons: 56px
- [ ] Cards: 16px padding
- [ ] Icons: 24px standard

---

**Total Estimated Time:** 3-4 hours  
**Complexity:** Medium-High  
**Priority:** High (main user interface)

Let's start with Home Screen! 🚀
