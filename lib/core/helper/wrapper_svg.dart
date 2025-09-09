import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SvgImage: wrapper بسيط ومرن لعرض SVGs في المشروع
class SvgImage {
  // خيارات افتراضية يمكن تعديلها هنا
  static const BoxFit _defaultFit = BoxFit.contain;
  static const double? _defaultWidth = null;
  static const double? _defaultHeight = null;

  /// عرض svg من assets
  static Widget asset(
    String assetPath, {
    double? width = _defaultWidth,
    double? height = _defaultHeight,
    BoxFit fit = _defaultFit,
    String? semanticsLabel,
    Alignment alignment = Alignment.center,
    bool matchTextDirection = false,
    Widget? placeholder, // يظهر أثناء التحميل (لو عايز)
    Widget? errorWidget, // يظهر لو حصل خطأ
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: placeholder != null
          ? (_) => SizedBox(
                width: width,
                height: height,
                child: Center(child: placeholder),
              )
          : null,
      // flutter_svg لا توفر "errorBuilder" مباشر للـ asset،
      // لكن يمكن التفاف فوقها لو احتجت لذلك.
    );
  }

  /// عرض svg من الشبكة (URL)
  static Widget network(
    String url, {
    double? width = _defaultWidth,
    double? height = _defaultHeight,
    BoxFit fit = _defaultFit,
    String? semanticsLabel,
    Alignment alignment = Alignment.center,
    bool matchTextDirection = false,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      matchTextDirection: matchTextDirection,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: placeholder != null
          ? (_) => SizedBox(
                width: width,
                height: height,
                child: Center(child: placeholder),
              )
          : null,
      // للتعامل مع خطأ التحميل، ممكن التفاف بالخارج:
    );
  }

  /// نسخة للايقونات (مناسبة لو عايز تستخدمها في IconButton مثلاً)
  static Widget icon(
    String assetPath, {
    double size = 24,
    Color? color,
    BoxFit fit = BoxFit.scaleDown,
    String? semanticsLabel,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      color: color,
      fit: fit,
      semanticsLabel: semanticsLabel,
    );
  }
}
