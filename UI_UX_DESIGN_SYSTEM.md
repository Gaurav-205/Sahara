# Sahara Pet Care - UI/UX Design System

## Design Principles

### 1. Consistency
- Uniform spacing, typography, and component styling across all screens
- Predictable navigation patterns
- Consistent color usage

### 2. Hierarchy
- Clear visual hierarchy with proper heading sizes
- Important actions prominently displayed
- Secondary actions visually de-emphasized

### 3. Accessibility
- Minimum touch target size: 44x44 dp
- WCAG AA contrast ratios
- Clear focus states

### 4. Responsiveness
- Adaptive layouts for different screen sizes
- Proper handling of small screens (<700px height)

---

## Spacing System

### Standard Spacing Scale
- **4px** - Micro spacing (between related elements)
- **8px** - Small spacing (within components)
- **12px** - Medium spacing (between components)
- **16px** - Default spacing (section padding)
- **20px** - Large spacing (screen padding)
- **24px** - XL spacing (major sections)
- **32px** - XXL spacing (screen sections)
- **48px** - XXXL spacing (major breaks)

### Screen Padding
- **Horizontal**: 20px (consistent across all screens)
- **Vertical**: 16-24px (depending on content density)

### Component Spacing
- **Between sections**: 24px
- **Between cards**: 12px
- **Within cards**: 16px
- **Button padding**: Horizontal 24px, Vertical 16px

---

## Typography System

### Font Family
- Primary: **Montserrat** (all screens)

### Font Sizes
- **Display Large**: 32px (splash, major headings)
- **Display Medium**: 28px (page titles)
- **Headline Large**: 24px (section headers)
- **Headline Medium**: 20px (card titles)
- **Headline Small**: 18px (subsection headers)
- **Body Large**: 16px (primary content)
- **Body Medium**: 15px (secondary content)
- **Body Small**: 14px (tertiary content)
- **Caption**: 13px (labels)
- **Micro**: 12px (timestamps, metadata)
- **Tiny**: 11px (badges, tags)
- **Mini**: 10px (bottom nav labels)

### Font Weights
- **Bold**: 700 (headings, important text)
- **SemiBold**: 600 (subheadings, buttons)
- **Medium**: 500 (labels)
- **Regular**: 400 (body text)

### Line Heights
- **Tight**: 1.1-1.2 (headings)
- **Normal**: 1.4-1.5 (body text)
- **Relaxed**: 1.6 (long-form content)

### Letter Spacing
- **Tight**: -0.5 to -0.3 (large headings)
- **Normal**: 0 (body text)
- **Wide**: 0.2-0.5 (buttons, labels)

---

## Color Usage

### Primary (Navy #16056B)
- Primary buttons
- Active navigation items
- Important icons
- Links

### Secondary (Orange #FD9519)
- Secondary buttons
- Highlights
- Call-to-action elements
- Active indicators
- Rating stars

### Accent (Sky Blue #5696FA)
- Info messages
- Tertiary buttons
- Decorative elements
- Progress indicators

### Text Colors
- **Primary**: #0F172A (headings, important text)
- **Secondary**: #475569 (body text)
- **Tertiary**: #94A3B8 (captions, hints)
- **Disabled**: #CBD5E1 (disabled states)

### Background Colors
- **Background**: #F8FAFC (screen background)
- **Surface**: #FFFFFF (cards, sheets)
- **Surface Variant**: #F1F5F9 (subtle backgrounds)

---

## Component Standards

### Buttons

#### Primary Button
- Background: `primaryGradient` or `secondary`
- Text: White, 16px, SemiBold (600)
- Padding: 16px vertical, 24px horizontal
- Border Radius: 16px
- Min Height: 52px
- Shadow: Elevation 2-4

#### Secondary Button
- Background: White
- Border: 2px solid primary/secondary
- Text: Primary color, 16px, SemiBold (600)
- Padding: 16px vertical, 24px horizontal
- Border Radius: 16px
- Min Height: 52px

#### Text Button
- No background
- Text: Primary color, 15px, SemiBold (600)
- Padding: 8px horizontal, 4px vertical
- Min touch target: 44x44

### Cards

#### Standard Card
- Background: White
- Border: 1px solid #E2E8F0
- Border Radius: 16px
- Padding: 16px
- Shadow: Subtle (0 2px 8px rgba(0,0,0,0.04))

#### Elevated Card
- Background: White
- Border: None
- Border Radius: 20px
- Padding: 16-20px
- Shadow: Medium (0 4px 12px rgba(0,0,0,0.08))

### Input Fields

#### Text Field
- Background: White
- Border: 1px solid #E2E8F0
- Border Radius: 12px
- Padding: 16px horizontal, 16px vertical
- Font Size: 15px
- Height: 52px
- Focus Border: 2px solid primary

### AppBar

#### Standard AppBar
- Background: White
- Elevation: 0
- Title: 20px, Bold (700), textPrimary
- Icon Size: 24px
- Height: 56px
- Status Bar: Transparent

### Bottom Navigation

#### Standard Bottom Nav
- Background: Primary (#16056B)
- Height: 64px + SafeArea
- Icon Size: 24px
- Label: 10px, Medium (500)
- Active Color: Secondary (#FD9519)
- Inactive Color: White 50%

### Icons

#### Sizes
- **Micro**: 16px (inline icons)
- **Small**: 20px (buttons, inputs)
- **Medium**: 24px (navigation, actions)
- **Large**: 28px (feature icons)
- **XL**: 32px (hero icons)
- **XXL**: 48px+ (onboarding, empty states)

---

## Layout Patterns

### Screen Structure
```
SafeArea
  └─ Scaffold
      ├─ AppBar (optional)
      ├─ Body
      │   └─ SingleChildScrollView / ListView
      │       └─ Padding (20px horizontal)
      │           └─ Content
      └─ Bottom Navigation (optional)
```

### Content Padding
- Screen edges: 20px horizontal
- Top padding: 16-20px
- Bottom padding: 24px + bottom nav height

### Section Spacing
- Between major sections: 24-32px
- Between subsections: 16-20px
- Between items: 12px

---

## Animation Standards

### Durations
- **Micro**: 150-200ms (hover, focus)
- **Short**: 250-350ms (transitions, reveals)
- **Medium**: 400-600ms (page transitions)
- **Long**: 800-1200ms (splash, onboarding)

### Curves
- **EaseInOut**: General transitions
- **EaseOut**: Entrances
- **EaseIn**: Exits
- **EaseOutCubic**: Smooth movements

---

## Screen-Specific Guidelines

### Splash Screen
- Centered logo
- Gradient background
- Progress indicator at bottom
- Version info

### Onboarding
- Full-screen pages
- Large icons (140-180px)
- Centered content
- Page indicators
- Skip button (top right)
- Next/Get Started button (bottom)

### Auth Screens (Login/Signup)
- Logo at top (80-100px)
- Form in center
- Primary button at bottom
- Alternative actions below button
- Social login options

### Home Screen
- Header with greeting
- Search bar
- Service grid (2 columns)
- Featured sections
- Bottom navigation

### List Screens
- Search/filter at top
- List items with consistent height
- Empty states centered
- Loading states

### Detail Screens
- Hero image/avatar at top
- Sticky header
- Scrollable content
- Fixed action buttons at bottom

### Profile/Settings
- Avatar at top
- Grouped sections
- List items with icons
- Dividers between groups

---

## Accessibility

### Touch Targets
- Minimum: 44x44 dp
- Recommended: 48x48 dp
- Spacing between: 8px minimum

### Contrast Ratios
- Text on background: 4.5:1 minimum (AA)
- Large text: 3:1 minimum (AA)
- UI components: 3:1 minimum

### Focus States
- Visible focus indicators
- Keyboard navigation support
- Screen reader labels

---

## Implementation Checklist

For each screen:
- [ ] Consistent spacing (20px horizontal padding)
- [ ] Proper typography (Montserrat, correct sizes)
- [ ] Color scheme (Navy/Orange/Blue)
- [ ] Button styling (16px radius, proper padding)
- [ ] Card styling (16-20px radius, subtle shadows)
- [ ] Icon sizes (24px for navigation)
- [ ] Touch targets (44x44 minimum)
- [ ] Loading states
- [ ] Empty states
- [ ] Error states
- [ ] Responsive layout
- [ ] Animations (smooth, purposeful)
- [ ] Status bar (transparent, proper brightness)
