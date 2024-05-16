import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final Function() onRefresh;

  const CustomError({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: onRefresh, child: const Text('Refresh')),
    );
  }
}
