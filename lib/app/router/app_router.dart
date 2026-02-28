import 'package:breathe_app/features/breathing/presentation/pages/finish_page.dart';
import 'package:breathe_app/features/breathing/presentation/pages/session_page.dart';
import 'package:breathe_app/features/breathing/presentation/pages/setup_page.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String setup = '/';
  static const String session = '/session';
  static const String finish = '/finish';
}

class AppRouter {
  static GoRouter create() {
    return GoRouter(
      initialLocation: AppRoutes.setup,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.setup,
          builder: (context, state) => const SetupPage(),
        ),
        GoRoute(
          path: AppRoutes.session,
          builder: (context, state) => const SessionPage(),
        ),
        GoRoute(
          path: AppRoutes.finish,
          builder: (context, state) => const FinishPage(),
        ),
      ],
    );
  }
}
