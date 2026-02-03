# Modelos de Datos (Dart)

> **⚠️ SOURCE OF TRUTH:** Must match Backend DTOs.

## Auth
**User**
- `id` (String UUID)
- `email` (String)
- `fullName` (String)
- `planType` (Enum: Free, Pro)

## Writing
**Project**
- `id` (String UUID)
- `title` (String)
- `synopsis` (String?)
- `coverUrl` (String?)
- `status` (Enum: Draft, Published)
- `lastModified` (DateTime)
