import 'package:expense_tracker/src/features/expenses/data/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:expense_tracker/src/features/expenses/providers/expense_providers.dart';
import 'package:expense_tracker/src/features/expenses/services/currency_service.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Expenses'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.go('/add'),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: expenses.when(
          data: (data) => _buildExpenseList(context, data),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const Text('Loading...'),
        ),
      ),
    );
  }

  Widget _buildExpenseList(BuildContext context, List<Expense> data) {
    if (data.isEmpty) {
      return const Center(child: Text('No expenses yet'));
    }
    final total = data.fold<double>(0, (sum, e) => sum + e.amount);
    return ListView(
      children: [
        CupertinoListSection.insetGrouped(
          children: [
            for (final expense in data)
              // TODO: Wrap each tile in a swipeable (e.g. Dismissible or
              // Cupertino-specific alternative) that asks for confirmation
              // before calling a deleteExpense(id) notifier action.
              CupertinoListTile.notched(
                title: Text(expense.title),
                subtitle: Text(
                  '${expense.currency.symbol} ${expense.amount.toStringAsFixed(2)}',
                ),
                additionalInfo: Text(
                  '${expense.currency.symbol} ${expense.amount.toStringAsFixed(2)}',
                ),
                trailing: const CupertinoListTileChevron(),
                onTap: () => context.go('/edit/${expense.id}'),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                // TODO: Replace hardcoded $ with preferred currency from the
                // onboarding screen; if currencies differ, convert using
                // CurrencyService before rendering the total.
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
