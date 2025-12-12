import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:expense_tracker/src/features/expenses/data/expense_repository.dart';

class ExpensesNotifier extends StateNotifier<AsyncValue<List<Expense>>> {
  final ExpenseRepository _repository;

  ExpensesNotifier(this._repository) : super(const AsyncValue.loading()) {
    _repository.load().then((value) => state = AsyncValue.data(value));
  }

  Future<void> _save() async {
    await _repository.save(state.valueOrNull ?? []);
  }

  void upsert(Expense expense) {
    var newState = List<Expense>.from(state.value ?? []);
    final index = newState.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      newState[index] = expense;
    } else {
      newState.add(expense);
    }
    newState.sort((a, b) => b.date.compareTo(a.date));
    state = AsyncValue.data(newState);
    _save();
  }

  // TODO: Add deleteExpense(String id) that removes an item, persists the
  // change, and updates state so swipe-to-delete reflects immediately.
}
