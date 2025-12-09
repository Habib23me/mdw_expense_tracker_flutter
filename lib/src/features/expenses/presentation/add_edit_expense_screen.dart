import 'package:currency_converter/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:expense_tracker/src/features/expenses/providers/expense_providers.dart';
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
  String? _title;
  String? _amountText;
  String _category = 'Food';
  Currency _currency = Currency.aed;

  @override
  void initState() {
    super.initState();
    if (widget.expenseId != null) {
      final expense = ref
          .read(expensesProvider)
          .valueOrNull
          ?.findByExpenseId(widget.expenseId!);
      _title = expense?.title;
      _amountText = expense?.amount.toString();
      _category = expense?.category ?? 'Food';
      _currency = expense?.currency ?? Currency.aed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.expenseId == null ? 'Add Expense' : 'Edit Expense'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: CupertinoFormSection.insetGrouped(
                children: [
                  CupertinoTextFormFieldRow(
                    initialValue: _title,
                    placeholder: 'Title',
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    onChanged: (value) => _title = value,
                  ),
                  CupertinoTextFormFieldRow(
                    initialValue: _amountText,
                    placeholder: 'Amount',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    prefix: Text(
                      _currency.symbol,
                      style: TextStyle(
                        fontFamily: _currency == Currency.aed
                            ? 'CurrencySymbols'
                            : 'Cupertino',
                        fontSize: 20,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          r'^\d*\.?\d{0,2}$',
                        ), // allow only digits and decimal point
                      ),
                    ],
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Amount is required';
                      }
                      final parsed = double.tryParse(value.trim());
                      if (parsed == null) {
                        return 'Enter a valid number';
                      }
                      if (parsed <= 0) {
                        return 'Amount must be positive';
                      }
                      return null;
                    },
                    onChanged: (value) => _amountText = value,
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Currency'),
                    additionalInfo: Text(_currency.name.toUpperCase()),
                    trailing: const CupertinoListTileChevron(),
                    onTap: _showCurrencyPicker,
                  ),
                  CupertinoListTile.notched(
                    title: const Text('Category'),
                    additionalInfo: Text(_category),
                    trailing: const CupertinoListTileChevron(),
                    onTap: _showCategoryPicker,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    //TODO: pass your preferred currency to the convert method
    final amount = await ref
        .read(currencyServiceProvider)
        .convert(
          amount: double.parse(_amountText?.trim() ?? '0'),
          from: _currency,
        );
    final expense = Expense(
      id: widget.expenseId ?? const Uuid().v4(),
      title: _title?.trim() ?? '',
      amount: amount,
      date: DateTime.now(),
      //TODO: pass your preferred currency to the expense model
      currency: Currency.usd,
      category: _category,
    );
    if (mounted) {
      if (widget.expenseId == null) {
        ref.read(expensesProvider.notifier).addExpense(expense);
      } else {
        ref.read(expensesProvider.notifier).updateExpense(expense);
      }
      Navigator.of(context).pop();
    }
  }

  void _showCategoryPicker() async {
    const categories = ['Food', 'Transport', 'Entertainment', 'Other'];
    final picked = await showActionSheetPicker<String>(
      context: context,
      title: 'Category',
      options: categories,
      selected: _category,
      labelBuilder: (value) => value,
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
