import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:expense_tracker/src/features/expenses/data/expense_repository.dart';
import 'package:expense_tracker/src/features/expenses/services/currency_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final expenseRepositoryProvider = Provider<ExpenseRepository>(
  (ref) => ExpenseRepository(ref.watch(sharedPreferencesProvider)),
);

final currencyServiceProvider = Provider<CurrencyService>(
  (ref) => const CurrencyService(),
);

final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, AsyncValue<List<Expense>>>((ref) {
      return ExpensesNotifier(ref.watch(expenseRepositoryProvider));
    });

class ExpensesNotifier extends StateNotifier<AsyncValue<List<Expense>>> {
  final ExpenseRepository _repository;

  ExpensesNotifier(this._repository) : super(const AsyncValue.loading()) {
    _repository.getExpenses().then((value) => state = AsyncValue.data(value));
  }

  Future<void> addExpense(Expense expense) async {
    state = await AsyncValue.guard(() async {
      await _repository.saveExpenses(state.valueOrNull ?? []);
      return [...state.valueOrNull ?? [], expense];
    });
  }

  Future<void> updateExpense(Expense expense) async {
    state = await AsyncValue.guard(() async {
      await _repository.saveExpenses(state.valueOrNull ?? []);
      return [
        for (final e in state.valueOrNull ?? [])
          if (e.id == expense.id) expense else e,
      ];
    });
  }

  // TODO: Add deleteExpense(String id) that removes an item, persists the
  // change, and updates state so swipe-to-delete reflects immediately.
}
