# Defect Tracking Document

## Meeting Room Management System - Defect Log

**Project Name:** N4Booking - Meeting Room Management System  
**Version:** 1.0.0  
**Document Version:** 1.0  
**Last Updated:** January 20, 2026  
**Prepared By:** QA Team

---

## Summary Statistics

| Status | Count |
|--------|-------|
| **Total Defects** | 12 |
| **Open** | 0 |
| **Closed** | 12 |
| **Critical** | 2 |
| **High** | 4 |
| **Medium** | 4 |
| **Low** | 2 |

---

## Defect Details

### D001 - Language Switcher Missing on Key Pages

| Field | Details |
|-------|---------|
| **Defect ID** | D001 |
| **Defect Title** | Language switcher dropdown not present on My Bookings, Manage Bookings, and Profile pages |
| **Defect Level** | High |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | Iteration SDV |
| **Test Status** | CLOSED |

**Description:**  
The language mode dropdown (English/Chinese switcher) was only available on the Dashboard and Home pages. Users navigating to My Bookings, Profile, or Admin pages could not switch languages, leading to inconsistent user experience.

**Reproduction Steps:**
1. Log in to the application
2. Navigate to Dashboard - Language switcher is visible
3. Navigate to My Bookings page - Language switcher is missing
4. Navigate to Profile page - Language switcher is missing

**Resolution:**  
Added LanguageSwitcher component to MyBookingsView.vue, ProfileView.vue, and AdminBookingsView.vue navigation bars.

---

### D002 - Dashboard Page Overscrolling Issue

| Field | Details |
|-------|---------|
| **Defect ID** | D002 |
| **Defect Title** | Empty space appears at bottom of Dashboard after scrolling past rooms section |
| **Defect Level** | Medium |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | Iteration SDV |
| **Test Status** | CLOSED |

**Description:**  
When scrolling past the conference rooms section on the Dashboard, excessive empty space appeared at the bottom of the page, causing poor user experience.

**Reproduction Steps:**
1. Navigate to Dashboard page
2. Scroll down past all room cards
3. Observe large empty space at bottom

**Root Cause:**  
The `fill-height` class combined with `position: absolute` on the animated background element caused layout calculation issues.

**Resolution:**  
- Removed `fill-height` class from wrapper div
- Changed animated background to `position: fixed`
- Added `min-height: 100vh` and `overflow: hidden` to wrapper

---

### D003 - Profile Page Overscrolling Issue

| Field | Details |
|-------|---------|
| **Defect ID** | D003 |
| **Defect Title** | Too much empty space after content on Profile page |
| **Defect Level** | Medium |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | Iteration SDV |
| **Test Status** | CLOSED |

**Description:**  
Similar to the Dashboard issue, the Profile page displayed excessive empty space after the form content, causing unnecessary scrolling.

**Resolution:**  
Applied same fix as D002 - removed `fill-height`, used `position: fixed` for animated background, added proper `min-height: 100vh`.

---

### D004 - Navbar UI Appears Cluttered

| Field | Details |
|-------|---------|
| **Defect ID** | D004 |
| **Defect Title** | Navigation bar looks clumsy with improper spacing between elements |
| **Defect Level** | Low |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | UI Review |
| **Test Status** | CLOSED |

**Description:**  
The navigation bar on the Dashboard had inadequate spacing between nav buttons, the language switcher, and user avatar, making it look cluttered.

**Resolution:**  
- Changed nav buttons container from `<template>` to `<div>` with `ml-6` margin
- Fixed navbar height to 64px
- Added `rounded="lg"` to nav buttons
- Increased spacing between language switcher and avatar

---

### D005 - Filter Section UI Not User-Friendly

| Field | Details |
|-------|---------|
| **Defect ID** | D005 |
| **Defect Title** | Calendar and time input blocks on Dashboard filter section look ugly |
| **Defect Level** | Medium |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | UI Review |
| **Test Status** | CLOSED |

**Description:**  
The filter section for searching conference rooms had basic styling that didn't match the premium look of the rest of the application.

**Resolution:**  
Completely redesigned filter section with:
- Gradient accent bar at top
- Section header with icon and subtitle
- CSS Grid layout for responsive fields
- Solo-filled input variant with dark backgrounds
- Custom labels above each field with icons
- Enhanced hover/focus states

---

### D006 - Search and Refresh Buttons Spacing Issue

| Field | Details |
|-------|---------|
| **Defect ID** | D006 |
| **Defect Title** | Search and Refresh buttons are too close together in filter section |
| **Defect Level** | Low |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | UI Review |
| **Test Status** | CLOSED |

**Description:**  
The Search and Refresh buttons in the filter section had minimal gap between them, making accidental clicks likely.

**Resolution:**  
Increased gap to 12px between buttons and styled them distinctly (primary search button with glow, outlined refresh button with icon only).

---

### D007 - Forgot Password Link Non-Functional

| Field | Details |
|-------|---------|
| **Defect ID** | D007 |
| **Defect Title** | Forgot password link on Sign In page has no backend implementation |
| **Defect Level** | High |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Full Stack Team |
| **Tester** | QA Team |
| **Phase** | Iteration SDV |
| **Test Status** | CLOSED |

**Description:**  
The Sign In page displayed a "Forgot password?" link that had no functionality, as password reset was not implemented in the backend.

**Reproduction Steps:**
1. Navigate to Login page
2. Click on "Forgot password?" link
3. Nothing happens - link is non-functional

**Resolution:**  
Removed the forgot password link from LoginView.vue until backend implementation is available.

---

### D008 - Reset Button Not Visible in Filter Section

| Field | Details |
|-------|---------|
| **Defect ID** | D008 |
| **Defect Title** | Reset/Refresh button not visible in Dashboard filter section |
| **Defect Level** | High |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | Iteration SDV |
| **Test Status** | CLOSED |

**Description:**  
The reset/refresh button in the filter section was not visible because the Search button had `block` attribute taking full width of the container.

**Reproduction Steps:**
1. Navigate to Dashboard
2. Look at filter section
3. Only Search button visible, no Refresh/Reset button

**Resolution:**  
- Removed `block` attribute from Search button
- Added `flex-grow-1` class instead
- Changed reset button to `outlined` variant with white color
- Added background and border styling for contrast

---

### D009 - Calendar Icon Not Positioned Inside Input Field

| Field | Details |
|-------|---------|
| **Defect ID** | D009 |
| **Defect Title** | Calendar icon is not properly positioned in date filter input |
| **Defect Level** | Medium |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | UI Review |
| **Test Status** | CLOSED |

**Description:**  
The date input field in the filter section only showed the calendar icon in the label above the field, not inside the input itself, making it less intuitive.

**Resolution:**  
Added `prepend-inner-icon` attribute to all filter input fields:
- Date field: `mdi-calendar`
- Start/End time: `mdi-clock-outline`
- Capacity: `mdi-account-multiple`

---

### D010 - Default App Favicon Not Related to Application

| Field | Details |
|-------|---------|
| **Defect ID** | D010 |
| **Defect Title** | Browser tab shows generic Vue favicon instead of N4Booking branding |
| **Defect Level** | Low |
| **Reporter** | Ayush Maheshwari |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | UI Review |
| **Test Status** | CLOSED |

**Description:**  
The application was using the default Vue.js favicon in the browser tab, which didn't represent the N4Booking brand.

**Resolution:**  
Created a custom favicon with a blue calendar/door icon with checkmark representing meeting room booking, and updated index.html to use the new favicon.png.

---

### D011 - i18n Translations Missing for New UI Elements

| Field | Details |
|-------|---------|
| **Defect ID** | D011 |
| **Defect Title** | Hardcoded English text on My Bookings and Profile pages instead of i18n translations |
| **Defect Level** | High |
| **Reporter** | QA Team |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | Localization Testing |
| **Test Status** | CLOSED |

**Description:**  
Several pages (My Bookings, Profile, Admin Bookings) had hardcoded English text that didn't switch to Chinese when language was changed.

**Affected Text:**
- "My Bookings", "Time", "Purpose", "Cancel Booking"
- "My Profile", "Edit Profile", "Change Password", form labels
- Admin page stats labels

**Resolution:**  
- Replaced all hardcoded text with `$t()` translation calls
- Added new translation keys to en.js and zh.js for `myBookings`, `profile`, and `admin` sections

---

### D012 - Booking Pages Overscrolling Inconsistency

| Field | Details |
|-------|---------|
| **Defect ID** | D012 |
| **Defect Title** | Multiple pages have inconsistent scroll behavior with animated backgrounds |
| **Defect Level** | Critical |
| **Reporter** | QA Team |
| **Responsible Person** | Frontend Team |
| **Tester** | QA Team |
| **Phase** | Regression Testing |
| **Test Status** | CLOSED |

**Description:**  
After fixing the Dashboard overscroll issue, similar problems were discovered on MyBookingsView, BookingView, and AdminBookingsView pages due to same root cause.

**Affected Pages:**
- MyBookingsView.vue
- BookingView.vue
- AdminBookingsView.vue
- ProfileView.vue

**Resolution:**  
Applied consistent fix across all affected pages:
1. Removed `fill-height` class from wrapper divs
2. Added `min-height: 100vh` CSS property
3. Changed animated background from `position: absolute` to `position: fixed`
4. Added `pointer-events: none` to prevent interaction issues

---

## Defect Trend Analysis

| Week | New | Resolved | Open |
|------|-----|----------|------|
| Week 1 | 5 | 3 | 2 |
| Week 2 | 4 | 4 | 2 |
| Week 3 | 3 | 5 | 0 |
| **Total** | **12** | **12** | **0** |

---

## Severity Distribution

```
Critical: ██ 2 (17%)
High:     ████ 4 (33%)
Medium:   ████ 4 (33%)
Low:      ██ 2 (17%)
```

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | Jan 20, 2026 | QA Team | Initial document with 12 defects |

---

## Sign-off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| QA Lead | | | |
| Dev Lead | | | |
| Project Manager | | | |
