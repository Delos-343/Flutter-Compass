import 'package:flutter/material.dart';

class NeuCircle extends StatelessWidget {
  final child;
  const NeuCircle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      margin: EdgeInsets.all(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade800,
            offset: Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0
          ),
          BoxShadow(
            color: Colors.blue.shade500,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade500,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.blue.shade800,
          ],
          stops: [0.1, 0.3, 0.8, 1],
        ),
      ),
      child: child,
    );
  }
}