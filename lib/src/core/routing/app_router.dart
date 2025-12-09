import 'package:go_router/go_router.dart';

import 'package:expense_tracker/src/features/expenses/presentation/add_edit_expense_screen.dart';
import 'package:expense_tracker/src/features/expenses/presentation/expense_list_screen.dart';

final router = GoRouter(
  routes: [
    // TODO: Add a currency-setup route (e.g. /currency-setup) that runs
    // before expenses on first launch; once saved, redirect here to '/'.
    GoRoute(
      path: '/',
      builder: (context, state) => const ExpenseListScreen(),
      routes: [
        GoRoute(
          path: 'add',
          builder: (context, state) => const AddEditExpenseScreen(),
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return AddEditExpenseScreen(expenseId: id);
          },
        ),
      ],
    ),
  ],
);
