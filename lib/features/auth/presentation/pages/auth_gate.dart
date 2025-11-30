import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service_locator.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_error_widget.dart';
import '../widgets/auth_unauthenticated_body.dart';
import 'splash_screen.dart';
import '../../../../features/tasks/presentation/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(sl())..checkBiometrics(),
      child: const AuthGateView(),
    );
  }
}

class AuthGateView extends StatelessWidget {
  const AuthGateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const HomePage();
        } else if (state is AuthUnauthenticated) {
          return AuthUnauehnticatedBody(message: state.message);
        } else if (state is AuthError) {
          return AuthErrorBody(message: state.message);
        }

        // AuthInitial or AuthLoading
        return const SplashScreen();
      },
    );
  }
}
