import 'package:currency_converter/currency.dart';
import 'package:expense_tracker/src/core/di/dependency_injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:expense_tracker/src/features/expenses/data/category.dart';
import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:expense_tracker/src/features/expenses/presentation/widgets/util.dart';
import 'package:expense_tracker/src/features/expenses/services/currency_service.dart';

class AddEditExpenseScreen extends ConsumerStatefulWidget {
  final String? expenseId;

  const AddEditExpenseScreen({super.key, this.expenseId});

  @override
  ConsumerState<AddEditExpenseScreen> createState() =>
      _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends ConsumerState<AddEditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  AsyncValue<List<Expense>> get expenseStore => ref.read(expensesProvider);
  final CurrencyService _currencyService = CurrencyService();
  String _title = '';
  String _amountText = '';
  Category _category = .food;
  Currency _currency = .aed;

  @override
  void initState() {
    super.initState();
    _loadExistingExpense();
  }

  Expense? get expense {
    return widget.expenseId.flatMap(expenseStore.value?.findByExpenseId);
  }

  void _loadExistingExpense() {
    expense.flatMap((e) {
      _title = e.title;
      _amountText = e.amount.toString();
      _category = e.category;
      _currency = e.currency;
    });
  }

  bool get isEditing => expense != null;
  bool get isSaveDisabled =>
      _title.trim().isEmpty || double.tryParse(_amountText.trim()) == null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(isEditing ? 'Edit Expense' : 'Add Expense'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isSaveDisabled ? null : _save,
            child: const Text('Save'),
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              CupertinoFormSection.insetGrouped(
                children: [
                  CupertinoTextFormFieldRow(
                    initialValue: _title,
                    placeholder: 'Title',
                    onChanged: (value) => setState(() => _title = value),
                  ),
                  CupertinoTextFormFieldRow(
                    initialValue: _amountText,
                    placeholder: 'Amount',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: numberValidator,
                    onChanged: (value) => setState(() => _amountText = value),
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Currency'),
                    additionalInfo: Text(
                      _currency.symbol.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: _currency == .aed
                            ? 'CurrencySymbols'
                            : null,
                      ),
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: _showCurrencyPicker,
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Category'),
                    additionalInfo: Text(_category.displayName),
                    trailing: const CupertinoListTileChevron(),
                    onTap: _showCategoryPicker,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    //TODO: pass your preferred currency to the convert method
    final parsedAmount = double.tryParse(_amountText.trim());
    if (parsedAmount == null) {
      return;
    }
    final amount = await _currencyService.convert(
      amount: parsedAmount,
      from: _currency,
      to: .usd,
    );
    //TODO: pass your preferred currency to the expense model
    final expense = Expense(
      id: widget.expenseId ?? const Uuid().v4(),
      title: _title.trim(),
      amount: amount,
      date: DateTime.now(),
      category: _category,
      currency: .usd,
    );
    ref.read(expensesProvider.notifier).upsert(expense);
    Navigator.of(context).pop();
  }

  void _showCategoryPicker() async {
    final categories = Category.values;
    final picked = await showActionSheetPicker<Category>(
      context: context,
      title: 'Category',
      options: categories,
      selected: _category,
      labelBuilder: (category) => category.displayName,
    );
    if (picked != null && mounted) {
      setState(() => _category = picked);
    }
  }

  Future<void> _showCurrencyPicker() async {
    final picked = await showActionSheetPicker<Currency>(
      context: context,
      title: 'Currency',
      options: CurrencyService.supportedCurrencies,
      selected: _currency,
      labelBuilder: (currency) => currency.name.toUpperCase(),
    );
    if (picked != null) {
      setState(() => _currency = picked);
    }
  }
}
