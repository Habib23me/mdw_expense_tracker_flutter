import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'expense_model.dart';

class ExpenseRepository {
  final SharedPreferences sharedPreferences;

  ExpenseRepository(this.sharedPreferences);

  static const _expensesKey = 'expenses';

  Future<void> saveExpenses(List<Expense> expenses) async {
    final expensesJson = expenses.map((e) => e.toJson()).toList();
    await sharedPreferences.setString(_expensesKey, jsonEncode(expensesJson));
  }

  Future<List<Expense>> getExpenses() async {
    final expensesString = sharedPreferences.getString(_expensesKey);
    if (expensesString == null) {
      return [];
    }
    final expensesJson = jsonDecode(expensesString) as List;
    return expensesJson.map((json) => Expense.fromJson(json)).toList();
  }
}
