import 'package:currency_converter/currency.dart';
import 'package:expense_tracker/src/features/expenses/services/currency_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  @CurrencyJsonConverter()
  final Currency currency;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.currency,
  });

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}

extension ExpenseExtension on List<Expense> {
  Expense? findByExpenseId(String expenseId) {
    return firstWhere((e) => e.id == expenseId);
  }
}
