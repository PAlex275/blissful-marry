import 'package:blissful_marry/core/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class ExpenseTrackerCard extends StatelessWidget {
  final Widget child;
  final double? height;
  const ExpenseTrackerCard({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: light,
      ),
      width: context.width * 0.9,
      height: height ?? 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
