# Gemini Expense Tracker

This document provides an overview of the "Daily Expense Tracker" Flutter application for other Gemini agents.

## Purpose

The app is a simple tool for users to log and track their daily expenses. It's designed for simplicity and offline use, making it ideal for travelers or anyone who wants to keep a quick record of their spending.

## Implementation Details

### Stack

- **State Management:** `flutter_riverpod`
- **Navigation:** `go_router`
- **Local Storage:** `shared_preferences`
- **Data Modeling:** `json_serializable` and `uuid`

### Architecture

The app uses a feature-based architecture, separating code by feature (e.g., `expenses`, `settings`). This makes the codebase modular and easy to navigate.

- **`lib/src/features`**: Contains the different features of the application.
  - **`expenses`**: Handles everything related to logging and displaying expenses.
    - **`data`**: Contains the `Expense` model (`expense_model.dart`) and the `ExpenseRepository` for data persistence.
    - **`presentation`**: Contains the UI widgets, such as `ExpenseListScreen` and `AddEditExpenseScreen`.
    - **`providers`**: Contains the Riverpod providers for the expenses feature.
  - **`settings`**: Will contain everything related to user settings.
- **`lib/src/core`**: Contains shared code that is not specific to any feature.
  - **`routing`**: Contains the `GoRouter` configuration in `app_router.dart`.
- **`lib/main.dart`**: The entry point of the application. It initializes the app, sets up `ProviderScope` for Riverpod, and configures the router.

### Data Flow

1.  The UI (`ExpenseListScreen` or `AddEditExpenseScreen`) calls methods on the `ExpensesNotifier` (from `expense_providers.dart`).
2.  The `ExpensesNotifier` updates its state (the list of expenses) and calls methods on the `ExpenseRepository`.
3.  The `ExpenseRepository` uses `shared_preferences` to save or retrieve the list of expenses, serializing/deserializing the data using the `Expense` model's `toJson`/`fromJson` methods.

## File Layout

```
lib/
|-- src/
|   |-- features/
|   |   |-- expenses/
|   |   |   |-- data/
|   |   |   |   |-- expense_model.dart
|   |   |   |   |-- expense_model.g.dart
|   |   |   |   |-- expense_repository.dart
|   |   |   |-- presentation/
|   |   |   |   |-- add_edit_expense_screen.dart
|   |   |   |   |-- expense_list_screen.dart
|   |   |   |-- providers/
|   |   |       |-- expense_providers.dart
|   |   |-- settings/
|   |       |-- data/
|   |       |   |-- settings_model.dart
|   |       |   |-- settings_model.g.dart
|   |       |   |-- settings_repository.dart
|   |-- core/
|       |-- routing/
|       |   |-- app_router.dart
|-- main.dart
```
