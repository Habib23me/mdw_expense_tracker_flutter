
# IMPLEMENTATION.md

This document outlines the implementation plan for the "Daily Expense Tracker" app.

## Phases

### Phase 1: Project Setup

- [x] Create a Dart or Flutter package in the package directory.
- [x] Remove any boilerplate in the new package that will be replaced, including the test dir, if any.
- [x] Update the description of the package in the `pubspec.yaml` and set the version number to 0.1.0.
- [x] Update the README.md to include a short placeholder description of the package.
- [x] Create the CHANGELOG.md to have the initial version of 0.1.0.
- [x] Commit this empty version of the package to the `main` branch.
- [ ] After commiting the change, start running the app with the `launch_app` tool on the user's preferred device. (Skipped by user)
- [x] Create/modify unit tests for testing the code added or modified in this phase, if relevant. (No new tests needed for boilerplate)
- [x] Run the `dart_fix` tool to clean up the code.
- [x] Run the `analyze_files` tool one more time and fix any issues.
- [x] Run any tests to make sure they all pass. (No tests to run at this stage)
- [x] Run `dart_format` to make sure that the formatting is correct.
- [ ] Re-read the IMPLEMENTATION.md file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [ ] Update the IMPLEMENTATION.md file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After commiting the change, if the app is running, use the `hot_reload` tool to reload it.

### Phase 2: Core Models and Data Layer

- [x] Add the necessary dependencies to `pubspec.yaml`: `json_annotation`, `json_serializable`, `build_runner`.
- [x] Create the `Expense` model in `lib/src/features/expenses/data/expense_model.dart` with `json_serializable` annotations.
- [x] Run `build_runner` to generate the serialization code.
- [x] Create the `ExpenseRepository` in `lib/src/features/expenses/data/expense_repository.dart` to handle the logic for storing and retrieving expenses from `shared_preferences`.
- [x] Create the `Settings` model and `SettingsRepository`.
- [x] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [x] Run the `dart_fix` tool to clean up the code.
- [x] Run the `analyze_files` tool one more time and fix any issues.
- [x] Run any tests to make sure they all pass.
- [x] Run `dart_format` to make sure that the formatting is correct.
- [ ] Re-read the IMPLEMENTATION.md file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [ ] Update the IMPLEMENTATION.md file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After commiting the change, if the app is running, use the `hot_reload` tool to reload it.

### Phase 3: State Management and UI (Expense List)

- [x] Add the `flutter_riverpod` dependency.
- [x] Create the `expense_providers.dart` file and add a `StateNotifierProvider` for the expense list.
- [x] Create the `ExpenseListScreen` in `lib/src/features/expenses/presentation/expense_list_screen.dart`.
- [x] The `ExpenseListScreen` will use a `ConsumerWidget` to watch the `expenseProvider` and display the list of expenses.
- [x] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [x] Run the `dart_fix` tool to clean up the code.
- [x] Run the `analyze_files` tool one more time and fix any issues.
- [x] Run any tests to make sure they all pass.
- [x] Run `dart_format` to make sure that the formatting is correct.
- [ ] Re-read the IMPLEMENTATION.md file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [ ] Update the IMPLEMENTATION.md file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After commiting the change, if the app is running, use the `hot_reload` tool to reload it.

### Phase 4: Navigation and UI (Add/Edit Expense)

- [x] Add the `go_router` dependency.
- [x] Create the `app_router.dart` file and configure the routes for the app.
- [x] Create the `AddEditExpenseScreen` in `lib/src/features/expenses/presentation/add_edit_expense_screen.dart`.
- [x] The `AddEditExpenseScreen` will contain a form to add or edit an expense.
- [x] Implement the logic to add or edit an expense and update the state using the `expenseProvider`.
- [x] Create/modify unit tests for testing the code added or modified in this phase, if relevant.
- [x] Run the `dart_fix` tool to clean up the code.
- [x] Run the `analyze_files` tool one more time and fix any issues.
- [x] Run any tests to make sure they all pass.
- [x] Run `dart_format` to make sure that the formatting is correct.
- [ ] Re-read the IMPLEMENTATION.md file to see what, if anything, has changed in the implementation plan, and if it has changed, take care of anything the changes imply.
- [ ] Update the IMPLEMENTATION.md file with the current state, including any learnings, surprises, or deviations in the Journal section. Check off any checkboxes of items that have been completed.
- [ ] Use `git diff` to verify the changes that have been made, and create a suitable commit message for any changes, following any guidelines you have about commit messages. Be sure to properly escape dollar signs and backticks, and present the change message to the user for approval.
- [ ] Wait for approval. Don't commit the changes or move on to the next phase of implementation until the user approves the commit.
- [ ] After commiting the change, if the app is running, use the `hot_reload` tool to reload it.

### Phase 5: Finalization

- [x] Create a comprehensive README.md file for the package.
- [x] Create a GEMINI.md file in the project directory that describes the app, its purpose, and implementation details of the application and the layout of the files.
- [x] Ask the user to inspect the app and the code and say if they are satisfied with it, or if any modifications are needed.

## Journal

### Phase 1: Project Setup

- **Action:** Created the Flutter project with `create_project`.
- **Action:** Removed the boilerplate `test` directory.
- **Action:** Updated `pubspec.yaml` with description and version 0.1.0.
- **Action:** Updated `README.md` with a placeholder description.
- **Action:** Created `CHANGELOG.md` with initial version.
- **Action:** Initialized git and committed the initial project setup.
- **Action:** User skipped running the app.
- **Action:** Ran `dart_fix`. No fixes applied.
- **Action:** Ran `analyze_files`. No errors found.
- **Action:** Ran `dart_format`. `lib/main.dart` was formatted.
- **Learnings:** The `create_project` tool generates a lot of boilerplate even with the `empty` flag, specifically the `test` directory. It also automatically adds the `flutter_test` and `flutter_lints` dev dependencies.

### Phase 2: Core Models and Data Layer

- **Action:** Added `json_annotation`, `json_serializable`, `build_runner`, and `shared_preferences` to `pubspec.yaml`.
- **Action:** Created `Expense` and `Settings` models with `json_serializable`.
- **Action:** Ran `build_runner` to generate serialization code.
- **Action:** Created `ExpenseRepository` and `SettingsRepository`.
- **Action:** Ran `dart_fix`, `analyze_files`, and `dart_format`.
- **Learnings:** The `pub` tool is idempotent and can be used to update constraints if a dependency already exists.

### Phase 3: State Management and UI (Expense List)

- **Action:** Added `flutter_riverpod` to `pubspec.yaml`.
- **Action:** Created `expense_providers.dart` with a `StateNotifierProvider` for the expense list.
- **Action:** Created `ExpenseListScreen` to display the expenses.
- **Action:** Updated `main.dart` to use `ProviderScope` and set `ExpenseListScreen` as the home screen.
- **Action:** Ran `dart_fix`, `analyze_files`, and `dart_format`.
- **Learnings:** Overriding the `sharedPreferencesProvider` in the `ProviderScope` is a clean way to provide the `SharedPreferences` instance to the repository.

### Phase 4: Navigation and UI (Add/Edit Expense)

- **Action:** Added `go_router` and `uuid` to `pubspec.yaml`.
- **Action:** Created `app_router.dart` and configured the routes.
- **Action:** Created `AddEditExpenseScreen` with a form for adding/editing expenses.
- **Action:** Updated `main.dart` to use the router.
- **Action:** Updated `ExpenseListScreen` to navigate to the add/edit screen.
- **Action:** Ran `dart_fix`, `analyze_files`, and `dart_format`.
- **Learnings:** Using absolute imports with the package name is more robust than relative imports, especially in a nested feature-based architecture. It's important to run the analyzer after making changes to catch import errors early.

### Phase 5: Finalization

- **Action:** Created a comprehensive `README.md` file.
- **Action:** Created a `GEMINI.md` file with app description and implementation details.
- **Action:** Asked user for feedback on the implementation.
- **Action:** Removed the empty `lib/src/models` directory for a cleaner project structure.
- **Action:** Committed all changes.


## Journal

### Phase 1: Project Setup

- **Action:** Created the Flutter project with `create_project`.
- **Action:** Removed the boilerplate `test` directory.
- **Action:** Updated `pubspec.yaml` with description and version 0.1.0.
- **Action:** Updated `README.md` with a placeholder description.
- **Action:** Created `CHANGELOG.md` with initial version.
- **Action:** Initialized git and committed the initial project setup.
- **Action:** User skipped running the app.
- **Action:** Ran `dart_fix`. No fixes applied.
- **Action:** Ran `analyze_files`. No errors found.
- **Action:** Ran `dart_format`. `lib/main.dart` was formatted.
- **Learnings:** The `create_project` tool generates a lot of boilerplate even with the `empty` flag, specifically the `test` directory. It also automatically adds the `flutter_test` and `flutter_lints` dev dependencies.

### Phase 2: Core Models and Data Layer

- **Action:** Added `json_annotation`, `json_serializable`, `build_runner`, and `shared_preferences` to `pubspec.yaml`.
- **Action:** Created `Expense` and `Settings` models with `json_serializable`.
- **Action:** Ran `build_runner` to generate serialization code.
- **Action:** Created `ExpenseRepository` and `SettingsRepository`.
- **Action:** Ran `dart_fix`, `analyze_files`, and `dart_format`.
- **Learnings:** The `pub` tool is idempotent and can be used to update constraints if a dependency already exists.

### Phase 3: State Management and UI (Expense List)

- **Action:** Added `flutter_riverpod` to `pubspec.yaml`.
- **Action:** Created `expense_providers.dart` with a `StateNotifierProvider` for the expense list.
- **Action:** Created `ExpenseListScreen` to display the expenses.
- **Action:** Updated `main.dart` to use `ProviderScope` and set `ExpenseListScreen` as the home screen.
- **Action:** Ran `dart_fix`, `analyze_files`, and `dart_format`.
- **Learnings:** Overriding the `sharedPreferencesProvider` in the `ProviderScope` is a clean way to provide the `SharedPreferences` instance to the repository.

### Phase 4: Navigation and UI (Add/Edit Expense)

- **Action:** Added `go_router` and `uuid` to `pubspec.yaml`.
- **Action:** Created `app_router.dart` and configured the routes.
- **Action:** Created `AddEditExpenseScreen` with a form for adding/editing expenses.
- **Action:** Updated `main.dart` to use the router.
- **Action:** Updated `ExpenseListScreen` to navigate to the add/edit screen.
- **Action:** Ran `dart_fix`, `analyze_files`, and `dart_format`.
- **Learnings:** Using absolute imports with the package name is more robust than relative imports, especially in a nested feature-based architecture. It's important to run the analyzer after making changes to catch import errors early.

