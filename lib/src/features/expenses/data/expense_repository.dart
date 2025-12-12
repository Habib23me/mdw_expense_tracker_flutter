import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'expense_model.dart';

class ExpenseRepository {
  late final SharedPreferences _sharedPreferences;

  ExpenseRepository(this._sharedPreferences);

  static const _expensesKey = 'expenses';

  Future<List<Expense>> load() async {
    final expensesString = _sharedPreferences.getString(_expensesKey);
    if (expensesString == null) {
      return [];
    }
    try {
      final expensesJson = jsonDecode(expensesString) as List;
      return expensesJson.map((json) => Expense.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> save(List<Expense> expenses) async {
    final expensesJson = expenses.map((e) => e.toJson()).toList();
    await _sharedPreferences.setString(_expensesKey, jsonEncode(expensesJson));
  }
}
