# ✅ `app_rules.md` — PARKMATE ENGINEERING RULES

> Every rule in this file is strict and non-negotiable.
> This project is a **Flutter Parking & Location Tracking App** using Supabase + Google Maps only.

---

# 1. Project Architecture (STRICT CLEAN ARCHITECTURE)

No exceptions.

```
lib/
├── core/
│   ├── constants/        → app_constants.dart
│   ├── di/               → injection_container.dart (GetIt)
│   ├── network/         → supabase_client.dart ONLY (NO Dio APIs)
│   ├── routes/          → app_router.dart (GoRouter single source)
│   ├── theme/           → colors, text styles, theme
│   ├── utils/           → helpers (location, distance calc)
│   ├── services/
│   │   ├── location_service.dart
│   │   ├── maps_service.dart
│   │   ├── parking_service.dart
│   ├── widgets/        → shared reusable UI only
│   └── errors/         → failure handling + exceptions
│
└── features/
    ├── auth/
    ├── parking/
    ├── map/
    ├── profile/
```

---

# 🚨 IMPORTANT CHANGE FROM ORIGINAL PROJECT

## ❌ FORBIDDEN

- No REST APIs
- No Dio API Client
- No external backend services
- No Firebase

## ✅ ALLOWED BACKEND ONLY

- Supabase Auth
- Supabase Database
- Supabase Storage (optional images)
- php

---

# 2. Core Feature: PARKING SYSTEM (MOST IMPORTANT)

## Parking Logic Rules

Each parking session MUST include:

```
parking_session
- id
- user_id
- latitude
- longitude
- address (optional via reverse geocoding)
- created_at
```

---

## Parking Flow

### 1. Save Parking

User presses:
👉 "Save My Parking"

System:

- Get current GPS location
- Save to Supabase
- Show success toast

---

### 2. Locate My Car

User presses:
👉 "Find My Car"

System:

- Open Google Maps
- Draw route from current location → saved parking location

---

### 3. Update Parking

If user parks again:

- Old parking replaced OR history saved

---

# 3. Mapbox Rules (MANDATORY)

## Allowed:

- Mapbox Maps SDK (mapbox_maps_flutter)
- Mapbox Geocoding API or Search API (optional)

## Features:

### A. Parking Pin

- Show saved car location on map

### B. Navigation Button

- Open Mapbox navigation or external maps app

### C. Nearby Parking Search

If user clicks:
👉 "I can't find parking"

System:

- Search nearby:
  - parking lots
  - garages

- Show markers on map

---

# 4. AUTH SYSTEM

Using Supabase only:

- Email/Password Login
- Google Sign-In (optional)
- Session persistence

---

# 5. FEATURE MODULES

## 🅿️ Parking Feature (CORE)

- Save parking location
- Get current parking
- Parking history

## 🗺️ Map Feature

- Show user location
- Show parking pin
- Show nearby parking

## 👤 Profile Feature

- User info
- Parking stats

---

# 6. UI / DESIGN RULES (STRICT)

Same as original but with additions:

## REQUIRED:

- App must feel like a **real product**
- Minimal UI
- Big action buttons (Parking apps style)

## CARD DECORATION RULE:

All card widgets MUST use `CardDecoration.card` from `core/utils/card_decoration.dart`:

```dart
decoration: CardDecoration.card,
```

This produces:

```dart
BoxDecoration(
  color: AppColors.background,
  borderRadius: BorderRadius.circular(AppRadius.md),
  border: Border.all(color: AppColors.divider),
  boxShadow: [
    BoxShadow(
      color: AppColors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
)
```

No inline BoxDecoration for card containers — always reuse the utility.

---

## HOME SCREEN RULE:

Must contain ONLY:

- Current parking card
- "Save Parking" button
- "Find My Car" button
- "Search Nearby Parking" button

---

# 7. LOCATION RULES (CRITICAL)

Use ONLY:

- Geolocator
- Mapbox Maps SDK

### Permissions:

- Location Always (optional future)
- Location While Using App (minimum)

---

# 8. GOOGLE MAPS REPLACED WITH MAPBOX (ARCHITECTURAL DECISION)

This project uses **Mapbox Maps SDK** instead of Google Maps.

## Rationale:

- Mapbox access token already configured in `.env`
- No Google Maps API key required
- Mapbox provides superior customization for parking use cases

---

# 8. DISTANCE TRACKING LOGIC

System must calculate:

```
distance(current_location, parking_location)
```

If:

- distance > 300 meters → show warning

---

# 9. STATE MANAGEMENT

- Cubit only (NO Bloc unless necessary)
- Equatable required
- Feature-based Cubits

---

# 10. ERROR HANDLING

All errors MUST use:

- Supabase error wrapper
- Custom Failure classes

NO raw exceptions in UI.

---

# 11. FILE RULES

| File           | Limit     |
| -------------- | --------- |
| page.dart      | 100 lines  |
| page_body.dart | 300 lines |
| cubit          | 300 lines |

page.dart template:
dartimport 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'splash_page_body.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const SplashPageBody(),
        ),
      ),
    );
  }
}

page_body.dart template:
dartimport 'package:flutter/material.dart';

class SplashPageBody extends StatelessWidget {
  const SplashPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}

---

# 12. CORE APP BEHAVIOR (VERY IMPORTANT)

This app is NOT:

- GPS tracker
- Car tracking system
- Real-time surveillance app

This app IS:

> “Smart Parking Assistant”

Meaning:

- Save parking
- Find parking
- Navigate back
- Suggest nearby parking spots

---

# 13. PERFORMANCE RULES

- No continuous GPS tracking
- Location only when needed
- Cache last parking locally + Supabase sync

---

# 14. Localization & RTL Support (STRICT)

This application MUST support:

- Arabic (ar)
- English (en)

from the first release.

---

## Localization Rules

All user-facing text MUST be localized.

Forbidden:

Text('Save Parking')
Text('Find My Car')

Required:

Text(LocaleKeys.saveParking.tr())

---

## Translation Files

Maintain:

assets/translations/ar.json
assets/translations/en.json

Every key added to one language MUST exist in the other.

Missing translation keys are forbidden.

---

## RTL / LTR Rules

The application MUST automatically switch between:

- RTL for Arabic
- LTR for English

using EasyLocalization locale state.

No manual text direction handling inside widgets unless explicitly required.

Use:

Directionality(
textDirection: context.locale.languageCode == 'ar'
? TextDirection.rtl
: TextDirection.ltr,
)

only when needed.

---

## Layout Rules

All layouts must work correctly in:

- Arabic RTL
- English LTR

Avoid fixed left/right positioning.

Prefer:

EdgeInsetsDirectional
AlignmentDirectional

instead of:

EdgeInsets.only(left: ...)
Alignment.centerLeft

---

## Future Language Expansion

Architecture must allow adding new languages without modifying feature code.

Translations must remain isolated inside assets/translations.

---

# 🔥 FINAL RULE

If any feature conflicts with:
- Supabase
- Mapbox Maps SDK
- Clean Architecture
- Parking flow

👉 It MUST be rejected.
