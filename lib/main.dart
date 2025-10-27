import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;
import 'package:twit/app/routes/app_route.dart';

import 'core/constants/supabase_constants.dart';
import 'features/local_database/local_storage.dart';
import 'theme/app_theme.dart';

ProviderContainer _globalContainer = ProviderContainer();
Directory? directory;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.init();
  directory = await getApplicationDocumentsDirectory();

  // setup supabase
  await Supabase.initialize(
    url: SupabaseConstants.projectUrl,
    anonKey: SupabaseConstants.apiKey,
  );

  runApp(ProviderScope(child: const MyApp(), parent: _globalContainer));
}

final _appRouter = AppRouter();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Twits',
      theme: AppTheme.theme(context),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
