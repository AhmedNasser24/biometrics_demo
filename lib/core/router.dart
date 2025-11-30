import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/auth_gate.dart';
import '../features/tasks/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const AuthGate()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}
