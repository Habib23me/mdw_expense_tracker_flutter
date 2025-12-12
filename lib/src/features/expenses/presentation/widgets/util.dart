import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:flutter/cupertino.dart';

/// Generic Cupertino action sheet picker that returns the selected value.
Future<T?> showActionSheetPicker<T>({
  required BuildContext context,
  required String title,
  required List<T> options,
  required T selected,
  required String Function(T) labelBuilder,
}) {
  return showCupertinoModalPopup<T>(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text(title),
      actions: [
        for (final option in options)
          CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(option),
            isDefaultAction: option == selected,
            child: Text(labelBuilder(option)),
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
    ),
  );
}

/// Shows a simple Cupertino error dialog.
Future<void> showCupertinoErrorDialog({
  required BuildContext context,
  required String message,
  String title = 'Invalid input',
}) {
  return showCupertinoDialog<void>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

String? numberValidator(String? value) =>
    value == null || double.tryParse(value.trim()) == null
    ? 'Enter a valid number'
    : null;

extension FlatMap<T> on T? {
  E? flatMap<E>(E? Function(T)? f) => this != null ? f?.call(this!) : null;
}

extension ExpenseExtension on List<Expense> {
  Expense? findByExpenseId(String expenseId) {
    return firstWhere((e) => e.id == expenseId);
  }
}
