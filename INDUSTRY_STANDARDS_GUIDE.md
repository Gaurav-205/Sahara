# Industry Standards Guide - Sahara Pet Care

**Date:** February 27, 2026  
**Goal:** Apply professional industry standards across all screens

---

## Design System Standards

### Typography Scale (Material Design 3)
```
Display Large:  57px / 64px line height - Hero text
Display Medium: 45px / 52px line height - Large headers
Display Small:  36px / 44px line height - Section headers

Headline Large:  32px / 40px line height - Page titles
Headline Medium: 28px / 36px line height - Card titles
Headline Small:  24px / 32px line height - Section titles

Title Large:  22px / 28px line height - List headers
Title Medium: 16px / 24px line height - Card subtitles
Title Small:  14px / 20px line height - Captions

Body Large:  16px / 24px line height - Primary text
Body Medium: 14px / 20px line height - Secondary text
Body Small:  12px / 16px line height - Helper text

Label Large:  14px / 20px line height - Buttons
Label Medium: 12px / 16px line height - Chips
Label Small:  11px / 16px line height - Overlines
```

### Spacing Scale (8pt Grid)
```
4px   - Micro spacing (icon padding)
8px   - Tight spacing (between related items)
12px  - Small spacing (form field gaps)
16px  - Base spacing (standard padding)
24px  - Medium spacing (section gaps)
32px  - Large spacing (major sections)
48px  - XLarge spacing (screen sections)
64px  - XXLarge spacing (hero sections)
```

### Component Sizes
```
Buttons:
- Small: 32px height, 12px padding
- Medium: 40px height, 16px padding
- Large: 48px height, 20px padding
- XLarge: 56px height, 24px padding

Icons:
- Small: 16px
- Medium: 20px
- Large: 24px
- XLarge: 32px
- Hero: 48px+

Touch Targets:
- Minimum: 48x48px (WCAG AAA)
- Recommended: 56x56px

Border Radius:
- Small: 8px (chips, tags)
- Medium: 12px (cards, inputs)
- Large: 16px (buttons, modals)
- XLarge: 20px (hero cards)
- Full: 999px (pills, avatars)
```

### Color Usage
```
Primary (Navy #1A2332):
- App bars, navigation
- Primary buttons
- Active states
- Important icons

Secondary (Orange #FF6B35):
- CTAs, FABs
- Highlights
- Active indicators
- Success states

Accent (Sky Blue #4ECDC4):
- Info messages
- Links
- Secondary actions
- Notifications

Text:
- Primary: #0F172A (87% opacity)
- Secondary: #475569 (60% opacity)
- Tertiary: #94A3B8 (38% opacity)
- Disabled: #CBD5E1 (12% opacity)
```

### Elevation & Shadows
```
Level 0: No shadow (flat surfaces)
Level 1: 0 1px 2px rgba(0,0,0,0.05) - Cards
Level 2: 0 2px 4px rgba(0,0,0,0.08) - Raised cards
Level 3: 0 4px 8px rgba(0,0,0,0.12) - Floating elements
Level 4: 0 8px 16px rgba(0,0,0,0.16) - Modals
Level 5: 0 16px 32px rgba(0,0,0,0.20) - Dialogs
```

---

## Screen-Specific Standards

### Splash Screen
- Logo: 120-160px (20-25% of screen width)
- App name: Headline Large (32px)
- Tagline: Body Medium (14px)
- Progress bar: 4px height, 200px width
- Version: Label Small (11px)
- Animation: 2-3 seconds total

### Onboarding
- Icon: 140-180px (30-35% of screen width)
- Title: Headline Large (32px)
- Description: Body Large (16px)
- Button: 56px height, full width
- Indicator dots: 8px, active 32px width
- Horizontal padding: 24px
- Vertical spacing: 48px between sections

### Authentication Screens
- Logo: 80-100px
- Title: Headline Large (32px)
- Subtitle: Body Medium (14px)
- Input fields: 56px height
- Buttons: 56px height
- Form spacing: 20px between fields
- Horizontal padding: 24px

### Home Screen
- App bar: 56px height
- Search bar: 48px height
- Section titles: Title Large (22px)
- Card titles: Title Medium (16px)
- Card text: Body Medium (14px)
- Grid spacing: 16px
- List spacing: 12px

### List Screens
- List item: 72px minimum height
- Avatar: 40px (small), 56px (medium)
- Title: Title Medium (16px)
- Subtitle: Body Medium (14px)
- Trailing icon: 24px
- Divider: 1px, 16px indent

### Detail Screens
- Hero image: 240-280px height
- Title: Headline Medium (28px)
- Subtitle: Title Medium (16px)
- Body text: Body Large (16px)
- Section spacing: 24px
- Content padding: 16px

---

## Implementation Checklist

### Per Screen
- [ ] Typography follows scale
- [ ] Spacing uses 8pt grid
- [ ] Touch targets ≥48px
- [ ] Colors from palette
- [ ] Shadows follow elevation
- [ ] Animations 200-400ms
- [ ] Responsive breakpoints
- [ ] Accessibility labels
- [ ] Loading states
- [ ] Empty states
- [ ] Error states

---

## Quality Metrics

### Performance
- First paint: <1s
- Interactive: <2s
- Smooth 60fps animations
- No jank or stuttering

### Accessibility
- WCAG AA contrast ratios
- Touch targets ≥48px
- Screen reader support
- Keyboard navigation
- Focus indicators

### Consistency
- Same components look identical
- Spacing consistent throughout
- Colors from defined palette
- Typography from scale
- Animations same duration/curve

---

**This guide ensures professional, industry-standard design across all screens.**
