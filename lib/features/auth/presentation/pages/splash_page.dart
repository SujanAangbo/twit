import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twit/features/auth/presentation/providers/splash_provider.dart';
import 'package:twit/features/auth/presentation/providers/user_provider.dart';

import '../../../../app/routes/app_route.gr.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    print("initialized calledsss");

    initialize();
  }

  Future<void> initialize() async {
    Future.delayed(Duration(seconds: 3), () async {
      final state = ref.read(splashProvider);

      if (state != null) {
        ref.read(userProvider.notifier).setUser(state);
        context.router.replaceAll([const BottomNavBar()]);
      } else {
        context.router.replaceAll([const LoginRoute()]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.read(splashProvider);
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
