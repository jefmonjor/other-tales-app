# Other Tales App

Native mobile/web application for **Other Tales**, built with **Flutter** and **Riverpod**.

## Tech Stack
- **Framework:** Flutter (Latest Stable)
- **Language:** Dart 3.x
- **State Management:** Riverpod 2.x (Generator Syntax)
- **Navigation:** GoRouter
- **Networking:** Dio + Retrofit
- **Local DB:** Isar (planned for offline support)
- **Code Generation:** Freezed, build_runner

## Project Structure (Feature-First)

```
lib/
├── core/                # Shared utilities, theme, router, network
├── features/            # Feature modules
│   ├── auth/            # Authentication (Sign In, Sign Up, Profile)
│   ├── projects/        # Project Management (CRUD)
│   └── writing/         # Editor & Content Management
│       ├── data/        # Repositories, DTOs, Data Sources
│       ├── domain/      # Entities, Failures, Abstract Repositories
│       └── presentation/# Widgets, Providers/Controllers, Screens
└── l10n/                # Localization (arb files)
```

## Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Android Studio / Xcode (for mobile simulation)

### Setup
1. **Dependencies:**
   ```bash
   flutter pub get
   ```

2. **Code Generation:**
   Runs build_runner to generate Riverpod providers and Freezed models.
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Environment:**
   Create a `.env` file in the root if required, or configure compile-time variables.

### Running
```bash
flutter run
```

## Key Features
- **Authentication:** Supabase Auth (Email/Password, Social)
- **Projects:** Create, list, Edit, Delete novels.
- **Editor:** Chapter-based writing with autosave (in progress).
