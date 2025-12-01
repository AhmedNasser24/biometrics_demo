import 'package:flutter/material.dart';
import '../../../../core/text_styles.dart';

class EmptyTaskBody extends StatelessWidget {
  final String message;

  const EmptyTaskBody({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: AppTextStyles.semiBold20PrimaryDark.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
