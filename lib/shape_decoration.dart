import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MyShapeDecoration extends OutlinedBorder {
  const MyShapeDecoration({
    required this.borderGradien,
    required this.borderWidth,
  }) : super();

  final Gradient borderGradien;
  final double borderWidth;
  final double bevel = 8.0;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.symmetric(vertical: borderWidth, horizontal: bevel / 2 + borderWidth);
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is MyShapeDecoration) {
      return MyShapeDecoration(
        borderGradien: Gradient.lerp(a.borderGradien, borderGradien, t)!,
        borderWidth: lerpDouble(a.borderWidth, borderWidth, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is MyShapeDecoration) {
      return MyShapeDecoration(
        borderGradien: Gradient.lerp(borderGradien, b.borderGradien, t)!,
        borderWidth: lerpDouble(borderWidth, b.borderWidth, t)!,
      );
    }
    return super.lerpFrom(b, t);
  }

  @override
  OutlinedBorder copyWith({Gradient? borderGradien, double? borderWidth, BorderSide? side}) {
    return MyShapeDecoration(
      borderGradien: borderGradien ?? this.borderGradien,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return MyShapeDecoration(
      borderGradien: borderGradien.scale(t),
      borderWidth: borderWidth * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    path.moveTo(rect.left + bevel, rect.top);
    path.lineTo(rect.right, rect.top);
    path.lineTo(rect.right - bevel, rect.bottom);
    path.lineTo(rect.left, rect.bottom);
    path.close();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getInnerPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {
    final shader = borderGradien.createShader(rect);

    final paint = Paint()
      ..shader = shader
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final innerPath = getInnerPath(rect, textDirection: textDirection);
    canvas.drawPath(innerPath, paint);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is MyShapeDecoration && other.side == side && other.borderWidth == borderWidth && other.borderGradien == borderGradien;
  }

  @override
  int get hashCode => hashValues(side, borderWidth, borderGradien);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'MyShapeDecoration')}($side, $borderWidth, $borderGradien)';
  }
}
