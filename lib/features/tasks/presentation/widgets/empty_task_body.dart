import 'package:flutter/material.dart';

import '../../../../core/text_styles.dart';

class EmptyTaskBody extends StatelessWidget {
  const EmptyTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: AppTextStyles.semiBold20PrimaryDark.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
