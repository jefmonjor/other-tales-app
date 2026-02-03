# GEMINI.md - Rules for Other Tales App (Flutter)

> **⚠️ ABSOLUTE PRIORITY:** THIS FILE OVERRIDES ALL OTHER INSTRUCTIONS.

## 1. Tech Stack (Strict)
- **Framework:** Flutter (Latest Stable).
- **Language:** Dart 3.x (Use Records, Patterns, Switch Expressions).
- **State Management:** Riverpod (Generator / Annotation syntax).
- **Navigation:** GoRouter.
- **Networking:** Dio (with Retrofit optional).
- **Local DB:** Isar (for Offline-First).
- **Code Gen:** build_runner with Freezed & Riverpod Generator.

## 2. Architecture Guidelines
- **Pattern:** Clean Architecture + Feature-First.
- **Layering within Features:**
  - `domain`: Pure Dart entities & abstract repositories. NO Flutter dependencies.
  - `data`: DTOs (`fromJson`), Repository Impl, API calls.
  - `presentation`: Widgets & Riverpod Providers (`@riverpod`).

## 3. UI & Design System Guidelines (STRICT)
- **Source of Truth:** The Figma Component Library (reflected in `core/theme` & `core/components`).
- **No Hardcoding:**
    - NEVER use `Color(0xFF...)` in screens. Use `AppColors.primary`.
    - NEVER use `TextStyle(fontSize:...)`. Use `AppTypography.h3`.
    - NEVER use `Padding(padding: EdgeInsets.all(15))`. Use `AppSpacing.m`.
- **Atomic Design:**
    - Build simple components in `core/components` (Buttons, Inputs).
    - Assemble complex widgets in `features/.../presentation/widgets`.

## 4. Backend Integration
- **Errors:** Must parse RFC 7807 `ProblemDetails` from Backend into App `Failures`.
- **Auth:** JWT stored in `flutter_secure_storage`. Auto-refresh via Dio Interceptor.
