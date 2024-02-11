import 'package:flutter/material.dart';

Widget BackwardButton(BuildContext context) {
  return Column(
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          '뒤로가기',
          style: TextStyle(fontSize: 20),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
