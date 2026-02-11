# Data Models (Dart)

> **⚠️ SOURCE OF TRUTH:** Must match Backend DTOs & Entities.

## Auth (Feature: `auth`)
**Profile**
- `id` (String UUID)
- `email` (String)
- `fullName` (String)
- `planType` (Enum: FREE, PRO)
- `termsAccepted` (bool)
- `marketingAccepted` (bool)

## Projects (Feature: `projects`)
**Project**
- `id` (String UUID)
- `userId` (String UUID)
- `title` (String)
- `synopsis` (String?)
- `genre` (String?)
- `currentWordCount` (int)
- `targetWordCount` (int)
- `coverUrl` (String?)
- `status` (Enum: DRAFT, PUBLISHED)
- `createdAt` (DateTime)
- `updatedAt` (DateTime)

## Writing (Feature: `writing`)
**Chapter**
- `id` (String UUID)
- `projectId` (String UUID)
- `title` (String)
- `content` (String)
- `orderIndex` (int)
- `status` (Enum: DRAFT, PUBLISHED)
- `updatedAt` (DateTime)

---

## Local Storage (Isar) - *Planned*
Local models will mirror the above but with `@collection` annotations.
