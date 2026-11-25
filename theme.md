# Go Jatra — Rider (Captain) App Theme & Design System

This document defines the complete visual design system, color tokens, typography, component specifications, and architectural standards for the **Go Jatra Rider (Captain) App**, ensuring 100% visual and structural consistency with the Go Jatra User App.

---

## 1. Design Philosophy & Brand Identity

- **Aesthetic**: Warm, approachable, high-trust urban mobility with an editorial luxury feel.
- **Core Surface**: Warm Ivory (`#F8F6F0`) instead of stark clinical white/grey, paired with crisp Soft White (`#FFFFFB`) elevated cards and Stone (`#F0EDE5`) secondary surfaces.
- **Primary Brand Accent**: Deep Forest Green (`#075B30`) for primary CTAs, active states, online duty toggles, and live route highlights.
- **Luxury Accent**: Champagne Gold (`#C9A55A`) for ratings, incentives, tier badges, and notification dots.
- **Iconography**: `iconsax` (`^0.0.8`) / `iconsax_flutter` (`^1.0.1`) for rounded modern line/bold icons, paired with Material rounded icons where appropriate.

---

## 2. Color Palette & Semantic Tokens

Use an `AppColors` class (`appcolor.dart`) with private constructor `AppColors._();`.

### 2.1 Core Brand & Surface Colors

| Token             | Hex       | Usage                                                        |
| :---------------- | :-------- | :----------------------------------------------------------- |
| `warmIvory`       | `#F8F6F0` | Primary scaffold background (`background`)                   |
| `deepForestGreen` | `#075B30` | Primary brand color, CTAs, active toggles (`primary`)        |
| `primaryDark`     | `#054424` | Pressed states, gradient end, dark green headers             |
| `primaryLight`    | `#EBF3EE` | Soft mint tint for badges, OTP box, active pills             |
| `primaryMuted`    | `#265939` | Muted green accents                                          |
| `forestCharcoal`  | `#10251A` | Dark hero cards, dark map/search headers                     |
| `nearBlack`       | `#171A18` | Primary headings & body text (`textPrimary`)                 |
| `softSlate`       | `#656B66` | Secondary text, subtitles, labels (`textSecondary`)          |
| `textMuted`       | `#888F8A` | Captions, timestamps, placeholders                           |
| `softWhite`       | `#FFFFFB` | Elevated card backgrounds (`surface`, `cardBackground`)      |
| `stone`           | `#F0EDE5` | Neutral cards, inactive pills, input fills (`surfaceMuted`)  |
| `surfaceWarm`     | `#F2ECE1` | Warm highlight containers                                    |
| `warmBeige`       | `#DED7C9` | Dividers, card borders, input outlines (`border`, `divider`) |
| `borderLight`     | `#EBE5DB` | Subtle hairline borders                                      |

### 2.2 Accent & Functional Status Colors

| Token           | Hex         | Usage                                                           |
| :-------------- | :---------- | :-------------------------------------------------------------- |
| `champagneGold` | `#C9A55A`   | Star ratings, incentives, recommended badges, notification dots |
| `freshGreen`    | `#159447`   | Online status dot, pickup pin, success indicators (`success`)   |
| `mistBlue`      | `#DCEAF0`   | Map water / subtle cool accent                                  |
| `error`         | `#D32F2F`   | Cancel actions, offline/error alerts, destructive outlines      |
| `info`          | `#0284C7`   | Navigation/direction info, message action accent                |
| `accentOrange`  | `#FE7002`   | **Reserved strictly for the GO JATRA emblem**                   |
| `shadow`        | `#10000000` | Soft elevation shadow (6–10% black opacity)                     |

### 2.3 Gradients

```dart
static const LinearGradient forestCharcoalGradient = LinearGradient(
  colors: [Color(0xFF132D20), Color(0xFF0D1E15)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

static const LinearGradient primaryGradient = LinearGradient(
  colors: [Color(0xFF075B30), Color(0xFF054424)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
```

### 2.4 Rider App Specific Semantic Mappings

| Rider State / Feature      | Recommended Styling                                                                                       |
| :------------------------- | :-------------------------------------------------------------------------------------------------------- |
| **Duty Status: Online**    | `freshGreen` (`#159447`) pulsing dot + `deepForestGreen` (`#075B30`) pill/toggle                          |
| **Duty Status: Offline**   | `softSlate` (`#656B66`) / `stone` (`#F0EDE5`) surface with `warmBeige` border                             |
| **Incoming Ride Request**  | High-contrast white/ivory bottom sheet, `primaryGradient` Accept CTA, `error` (`#DC2626`) Decline outline |
| **Pickup Pin / Marker**    | `freshGreen` (`#159447`)                                                                                  |
| **Dropoff Pin / Marker**   | `deepForestGreen` (`#075B30`) or `nearBlack` (`#171A18`) square marker                                    |
| **Earnings / Wallet Card** | `forestCharcoalGradient` (`#132D20` → `#0D1E15`) with white text & `champagneGold` (`#C9A55A`) highlights |
| **Ride Start OTP Input**   | `primaryLight` (`#EBF3EE`) container with `deepForestGreen` border at 35% opacity                         |

---

## 3. Typography System

- **Font Family**: `Manrope` (via `google_fonts: ^6.2.1`)
- **Responsive Scaling**: `flutter_screenutil: ^5.9.3` initialized with `designSize: const Size(360, 800)`. All font sizes use `.sp`, widths/heights use `.w`/`.h`, and radii/paddings use `.r`.

| Token                        | Size (`.sp`) | Weight | Line Height | Letter Spacing | Usage                          |
| :--------------------------- | :----------: | :----: | :---------: | :------------: | :----------------------------- |
| `brandTitle` / `splashTitle` |   `44.sp`    | `w800` |      —      |     `0.5`      | Splash wordmark                |
| `mainHeadline`               |   `36.sp`    | `w700` |  `44 / 36`  |     `-0.5`     | Auth / hero headlines          |
| `destinationQuestion`        |   `30.sp`    | `w700` |   `1.15`    |     `-0.5`     | Primary map/duty prompt        |
| `fare`                       |   `28.sp`    | `w800` |      —      |     `-0.6`     | Trip fare & daily earnings     |
| `sectionTitle`               |   `24.sp`    | `w700` |      —      |     `-0.4`     | Screen & section headers       |
| `headingLarge`               |   `22.sp`    | `w700` |   `1.25`    |       —        | Modal / sheet titles           |
| `logoWordmark`               |   `20.sp`    | `w700` |  `24 / 20`  |     `0.5`      | Top bar wordmark               |
| `primaryButton`              |   `18.sp`    | `w700` |  `24 / 18`  |       —        | Full-width primary CTAs        |
| `inputText`                  |   `18.sp`    | `w500` |  `24 / 18`  |       —        | Phone, OTP & search inputs     |
| `supportingCopy`             |   `17.sp`    | `w500` |  `25 / 17`  |       —        | Subtitles & descriptions       |
| `rideName`                   |   `17.sp`    | `w700` |      —      |     `-0.2`     | Vehicle / trip type label      |
| `secondaryAction`            |   `16.sp`    | `w600` |  `24 / 16`  |       —        | Text links & secondary CTAs    |
| `locationTitle`              |   `14.sp`    | `w700` |      —      |       —        | Pickup / dropoff address title |
| `welcomeLabel`               |   `13.sp`    | `w700` |  `18 / 13`  |     `1.2`      | Uppercase eyebrow labels       |
| `cardDetails`                |   `13.sp`    | `w500` |      —      |     `-0.1`     | Distance, ETA & trip metadata  |
| `legalCopy`                  |   `12.sp`    | `w500` |  `18 / 12`  |       —        | Terms, hints & footnotes       |
| `recommendedBadge`           |   `11.sp`    | `w700` |      —      |     `0.2`      | Pill tags & status badges      |

---

## 4. App Theme & System UI Configuration

Configure `GetMaterialApp` inside `ScreenUtilInit` (`designSize: const Size(360, 800)`, `minTextAdapt: true`, `splitScreenMode: true`):

```dart
SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ),
);

ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.manropeTextTheme(Theme.of(context).textTheme),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.accent,
    surface: AppColors.surface,
  ),
  scaffoldBackgroundColor: AppColors.background, // #F8F6F0
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
)
```

---

## 5. Spacing, Radii & Elevation Tokens

| Element                       | Standard Value                                                                                     |
| :---------------------------- | :------------------------------------------------------------------------------------------------- |
| **Screen Horizontal Padding** | `20.w` (or `24.w` on auth/onboarding screens)                                                      |
| **Primary CTA Height**        | `48.h` – `56.h`                                                                                    |
| **Primary CTA Border Radius** | `16.r` – `18.r`                                                                                    |
| **Elevated Card Radius**      | `16.r` – `22.r`                                                                                    |
| **Bottom Sheet Top Radius**   | `28.r` – `32.r`                                                                                    |
| **Bottom Sheet Drag Handle**  | `44.w × 4.5.h`, color `AppColors.warmBeige`, radius `3.r`                                          |
| **Input Field Radius**        | `12.r` – `16.r`, border `AppColors.warmBeige` (`1.w`)                                              |
| **Pill / Badge Radius**       | `6.r` – `12.r` (or `999.r` for full pill)                                                          |
| **Card Shadow**               | `BoxShadow(color: Colors.black.withOpacity(0.04–0.08), blurRadius: 12–20.r, offset: Offset(0, 4))` |
| **Bottom Sheet Shadow**       | `BoxShadow(color: Colors.black.withOpacity(0.12–0.18), blurRadius: 28.r, offset: Offset(0, -8))`   |

---

## 6. Standardized UI Components

### 6.1 Primary & Destructive Buttons

- **Primary Button**: Full-width, height `50.h`–`56.h`, background `AppColors.deepForestGreen` (`#075B30`), radius `16.r`–`18.r`, white bold Manrope text, soft 10% green shadow.
- **Secondary / Cancel Outline Button**: Full-width, height `48.h`–`50.h`, white background, `1.2.w` border (`Color(0xFFEF4444).withOpacity(0.4)` for cancel/decline, `AppColors.warmBeige` for neutral), radius `16.r`.

### 6.2 Cards & Rider Profile / Trip Cards

- Background: `AppColors.softWhite` (`#FFFFFB`) or warm off-white (`#FAF9F6`).
- Border: `1.w` solid `AppColors.warmBeige` (`#DED7C9`).
- Padding: `14.r` – `16.r`.
- **Rating Pill**: Background `#FEF3C7`, border `#F59E0B` at 30% opacity, amber star icon (`#D97706`), text `#B45309`.
- **Vehicle Plate Badge**: White background, `1.w` border (`AppColors.nearBlack.withOpacity(0.3)`), radius `6.r`, `letterSpacing: 1.1`, `FontWeight.w800`.

### 6.3 Standardized Snackbars (`AppConfig`)

All toast/snackbar feedback (`showSuccess`, `showError`, `showWarning`, `showInfo`) must use:

- `SnackPosition.BOTTOM`
- Margin `EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h)`
- Padding `EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h)`
- White background, `borderRadius: 16.r`, `1.0` border `#EBE6DC`
- Circular tinted icon badge (`accentColor.withOpacity(0.12)`) on the left with `Iconsax` icon (`20.sp`).

### 6.4 Map Styling (`flutter_map` + `latlong2`)

- Full-width edge-to-edge map container (zero horizontal margin).
- Use `import 'package:latlong2/latlong.dart' hide Path;` whenever `dart:ui` / Flutter `Path` is in scope.
- Floating circular map action buttons (`40.r`–`44.r`, white background, subtle shadow, `AppColors.deepForestGreen` / `AppColors.nearBlack` icons).

---

## 7. Architecture & Code Quality Rules

To keep the Rider App codebase aligned with the User App:

1. **State Management**: GetX (`get: ^4.7.3`) with `Bindings` + `GetxController` per module.
2. **100% `GetView<T>`**: Every screen and reusable UI widget in `lib/` must extend `GetView<T>` (zero `StatefulWidget` or `StatelessWidget`). Use `GetSingleTickerProviderStateMixin` on controllers for animations.
3. **Strict File Size Limit**: Every `.dart` file in `lib/` must remain **under 500 lines**. Split large views into modular `views/widgets/` components.
4. **Haptic Feedback**: Use `HapticFeedback.lightImpact()`, `selectionClick()`, and `mediumImpact()` on primary CTAs, radio selections, and duty toggles.
