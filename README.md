# Expense Tracker

A simple Flutter application to track your daily expenses.

## Open assignments for learners

- Onboarding currency picker: Add a first-run page that suggests a currency using `getMyCurrency` from the currency library (uses device locale) and lets the user confirm. After confirmation, persist the choice and continue to the expenses list.
- Swipe-to-delete: Add swipe-to-delete support on the expenses list with a confirmation prompt before removal. Persist the deletion so the list reloads without the removed item.

## Features

- Log daily expenses with a title, amount, and category.
- View a list of today's expenses.
- Edit existing expenses.
- Data is persisted locally on the device.

## Getting Started

To run the app, first install the dependencies:

```
flutter pub get
```

Then, run the app:

```
flutter run
```

## Project Structure

The app follows a feature-based architecture.

```
lib/
|-- src/
|   |-- features/
|   |   |-- expenses/
|   |   |   |-- data/
|   |   |   |   |-- expense_model.dart
|   |   |   |   |-- expense_repository.dart
|   |   |   |-- presentation/
|   |   |   |   |-- add_edit_expense_screen.dart
|   |   |   |   |-- expense_list_screen.dart
|   |   |   |-- providers/
|   |   |       |-- expense_providers.dart
|   |   |-- settings/
|   |       |-- data/
|   |       |   |-- settings_model.dart
|   |       |   |-- settings_repository.dart
|   |-- core/
|       |-- routing/
|       |   |-- app_router.dart
|-- main.dart
```

## Dependencies

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) for state management.
- [go_router](https://pub.dev/packages/go_router) for navigation.
- [shared_preferences](https://pub.dev/packages/shared_preferences) for local storage.
- [json_serializable](https://pub.dev/packages/json_serializable) for data modeling.
- [uuid](https://pub.dev/packages/uuid) for generating unique IDs.
