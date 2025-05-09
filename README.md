# Site inspection checklist app

Site inspection checklist app for a construction supervisor to log daily inspection tasks

## Getting Started

State management: Riverpod
Local persisted storage: Sqflite
Used layer first architecture

## Checklist

- UI:
  - [x] Home screen: List of inspection items (e.g., "Scaffolding", "Electrical wiring", "Personal Protective Equipment")
  - [x] Each item shows:
    - [x] Name
    - [x] Status (initially Pending)
    - [x] Category Name
  - [x] Tap on item to:
    - [x] Change status to one of: ✅ Passed, ❌ Failed, 🚫 N/A
  - [x] Option to reset all statuses
  - [x] Display summary count (e.g., 3 passed / 5 total)

- Technical:
  - [x] Use MVVM or other clearly defined architecture
  - [x] Write at least 3 unit tests (business logic or view model layer)
  - [x] Include an API adapter class that returns hard-coded inspection data (simulate future backend)
  - [x] Code should be ready to drop into a CI/CD pipeline (e.g., avoid platform-specific hacks)

## Demo

https://github.com/user-attachments/assets/5b1c7b40-c7b2-4baa-a2c2-ceab1ed4e5c6

