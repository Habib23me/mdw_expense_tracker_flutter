import 'package:expense_tracker/src/core/routing/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/src/features/expenses/providers/expense_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  // TODO: Kick off an onboarding flow that asks for preferred currency
  // before showing expenses; seed it with getMyCurrency() from the
  // currency package to guess based on locale, then persist the choice.
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(routerConfig: router);
  }
}
