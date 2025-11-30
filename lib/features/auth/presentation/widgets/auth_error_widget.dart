import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/text_styles.dart';
import '../cubit/auth_cubit.dart';

class AuthErrorBody extends StatelessWidget {
  const AuthErrorBody({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: $message',
                textAlign: TextAlign.center,
                style: AppTextStyles.medium18PrimaryDark,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().checkBiometrics();
                },
                child: Text('Retry', style: AppTextStyles.semiBold16White),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
