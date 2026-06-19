import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({this.size = 34, this.heroTag, super.key});

  final double size;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final mark = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'T',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Georgia',
            fontSize: size * 0.59,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    if (heroTag == null) return mark;
    return Hero(tag: heroTag!, child: mark);
  }
}
