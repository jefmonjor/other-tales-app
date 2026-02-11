# Project State (Frontend)

## Current Status
- **Phase:** 1 (Implementation) - ACTIVE
- **Active Epic:** EPIC-2: Editor & Core Writing Features

---

## Completed Features

### Foundation
- [x] Project Structure (Clean Architecture + Feature-First)
- [x] Routing (GoRouter with Auth Redirects)
- [x] Theming (Figma colors, typography)
- [x] Localization (l10n arb files)
- [x] Dio Network Client (Supabase JWT Interceptor, RFC 7807 handling)

### Authentication (Feature: `auth`)
- [x] Sign In Screen (Email/Password, Social UI)
- [x] Sign Up Screen (Form validation, Terms)
- [x] Repository Implementation (Supabase Flutter SDK)
- [x] Auth State Management (Riverpod)

### Projects (Feature: `projects`)
- [x] Project List (Infinite scroll/Pagination pending, currently full list)
- [x] Create Project (Modal with validation)
- [x] Edit Project (Modal)
- [x] Delete Project (Soft delete via API)
- [x] Project Card UI (Cover placeholder, stats)

### Writing (Feature: `writing`)
- [x] Editor Screen Skeleton
- [x] Chapter Management (Drawer)
  - List chapters
  - Create new chapter
  - Switch between chapters
  - Delete chapter
- [x] Content Autosave (Debounced)

---

## In Progress / Next Steps

### Editor Enhancements
- [ ] Rich Text Editor (currently plain TextField)
- [ ] Chapter Reordering (Drag & Drop)
- [ ] Offline Support (Isar DB integration)
- [ ] Conflict Resolution (Version mismatches)

### Polish
- [ ] Skeleton Loaders (Clean up transitions)
- [ ] Error Handling (User-friendly toasts for all failures)

---

## Architecture Logic
- **State Management:** Riverpod (Generator)
- **Navigation:** GoRouter
- **API:** Dio with Retrofit (or direct Dio)
- **Local DB:** Isar (Planned for Phase 2)
