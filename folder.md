# Go Jatra — Rider (Captain) App Folder Structure

This document defines the standardized GetX modular folder structure for the **Go Jatra Rider (Captain) App**, matching the architecture of the Go Jatra User App (`gojtrauser`).

---

## 1. Root Directory Structure

```text
gojatra_rider/
├── android/
├── ios/
├── assets/
│   ├── images/                  # Brand logos, onboarding illustrations, vehicle icons
│   └── lottie/                  # Radar/searching animations, no_internet.json, success.json
├── lib/
│   ├── main.dart                # App entry, permanent services, ScreenUtilInit, ThemeData
│   └── app/
│       ├── data/                # Shared config, global services, common models & widgets
│       ├── modules/             # Feature-based GetX modules
│       └── routes/              # Centralized route constants & GetPage definitions
├── test/                        # Widget & visual verification tests
├── pubspec.yaml
├── theme.md                     # Design system, colors, typography & component specs
└── folder.md                    # This folder structure guide
```

---

## 2. `lib/app/data/` — Shared Core Layer

```text
lib/app/data/
├── config/
│   ├── app_config.dart          # Base URLs, API endpoints, GetStorage keys, custom snackbars
│   ├── app_typography.dart      # Manrope TextStyles with ScreenUtil (.sp)
│   ├── appcolor.dart            # AppColors palette, semantic tokens & gradients
│   └── appimages.dart           # Asset path constants
├── models/                      # Shared domain models (e.g., CaptainModel, VehicleModel)
├── services/
│   ├── connectivity_service.dart # Global network listener (connectivity_plus)
│   ├── location_service.dart     # Live GPS tracking & background duty location
│   └── socket_service.dart       # Real-time ride request & trip status stream
└── widgets/                     # Cross-module reusable widgets (must extend GetView)
```

---

## 3. `lib/app/routes/` — Centralized Routing

```text
lib/app/routes/
├── app_pages.dart               # AppPages.INITIAL & List<GetPage> with Bindings & Transitions
└── app_routes.dart              # part of 'app_pages.dart'; Routes & _Paths constants
```

---

## 4. `lib/app/modules/` — Feature Modules

Every module strictly follows the GetX pattern:

```text
<module_name>/
├── bindings/
│   └── <module_name>_binding.dart
├── controllers/
│   └── <module_name>_controller.dart
├── models/
│   └── <module_name>_model.dart
└── views/
    ├── <module_name>_view.dart
    └── widgets/
        ├── <sub_component>_widget.dart
        └── painters/            # CustomPainter classes (if needed)
```

### Rider App Modules Breakdown

| Module             | Responsibility                                                                                          |
| :----------------- | :------------------------------------------------------------------------------------------------------ |
| `splash/`          | Brand intro, location permission check, auto-routing to Onboarding / Login / Home                       |
| `onboarding/`      | 3-step Captain value proposition slides                                                                 |
| `login/`           | Captain phone number entry & OTP dispatch loading modal                                                 |
| `otp/`             | 4-digit OTP verification & resend timer                                                                 |
| `kyc_documents/`   | Driver license, RC, insurance, Aadhaar/PAN upload & verification status                                 |
| `bottom_nav/`      | Persistent bottom navigation wrapper (Duty/Home, Earnings, Trips, Profile)                              |
| `home/`            | Online/Offline duty toggle, live OpenStreetMap/GPS, demand zones, incoming ride request sheet           |
| `active_ride/`     | Navigating to pickup, Arrived state, Start OTP verification, Live trip to dropoff, Fare/Cash collection |
| `earnings/`        | Today's earnings, weekly summary, incentives/bonuses, payout & bank/UPI withdrawal                      |
| `trip_history/`    | Completed & cancelled ride logs with filters                                                            |
| `trip_details/`    | Individual trip breakdown (route, fare, commission, net payout, passenger rating)                       |
| `vehicle_details/` | Assigned vehicle info, plate number, service category (`Go Bike`, `Go Auto`, `Go Cab`)                  |
| `edit_profile/`    | Captain profile photo, name, phone, emergency contact                                                   |
| `notifications/`   | Ride alerts, payout confirmations, incentive announcements                                              |
| `sos_safety/`      | 24/7 emergency SOS trigger & safety toolkit                                                             |

---

## 5. Module Organization & File Rules

1. **100% `GetView<T>`**: Every file in `views/` and `views/widgets/` must extend `GetView<ControllerName>`. Never use `StatefulWidget` or `StatelessWidget`.
2. **Under 500 Lines Per File**: Keep every `.dart` file in `lib/` strictly under `500` lines. Break large views into focused files under `views/widgets/` (e.g., `incoming_ride_sheet.dart`, `otp_verify_sheet.dart`, `duty_status_header.dart`).
3. **Painters Isolation**: Place `CustomPainter` classes inside `views/widgets/painters/`.
4. **Bindings Always Wired**: Every `GetPage` in `app_pages.dart` must bind its controller via `<Module>Binding` using `Get.lazyPut<T>()`.
5. **Naming Conventions**:
   - Directories & files: `snake_case` (e.g., `active_ride_controller.dart`)
   - Classes: `PascalCase` matching the file (`ActiveRideController`, `ActiveRideView`, `ActiveRideBinding`)
   - Route constants: `UPPER_SNAKE_CASE` (`Routes.ACTIVE_RIDE`, `_Paths.ACTIVE_RIDE = '/active-ride'`)
