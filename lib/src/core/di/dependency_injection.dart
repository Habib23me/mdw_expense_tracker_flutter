import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:expense_tracker/src/features/expenses/data/expense_repository.dart';
import 'package:expense_tracker/src/features/expenses/providers/expense_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final expenseRepositoryProvider = Provider<ExpenseRepository>(
  (ref) => ExpenseRepository(ref.watch(sharedPreferencesProvider)),
);

final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, AsyncValue<List<Expense>>>((ref) {
      return ExpensesNotifier(ref.watch(expenseRepositoryProvider));
    });
