part of '../../design_system.dart';

mixin CupertinoImageRenderer on DesignStyle {
  @override
  ImageTokens get imageTokens => ImageTokens.fromFoundation(foundation);

  @override
  Widget renderImage({
    required String src,
    double? width,
    double? height,
    BoxFit? fit,
    Widget? placeholder,
    Widget? errorWidget,
    double borderRadius = 0.0,
  }) {
    final tokens = imageTokens;
    final effectiveFit = fit ?? tokens.defaultFit;
    final isNetwork = src.startsWith('http://') || src.startsWith('https://');

    Widget imageWidget;

    if (isNetwork) {
      imageWidget = Image.network(
        src,
        width: width,
        height: height,
        fit: effectiveFit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              Container(
                width: width,
                height: height,
                color: tokens.placeholderColor,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                color: tokens.errorColor?.withValues(alpha: 0.1),
                child: Icon(
                  CupertinoIcons.photo,
                  color: tokens.errorColor,
                  size: 48,
                ),
              );
        },
      );
    } else {
      imageWidget = Image.asset(
        src,
        width: width,
        height: height,
        fit: effectiveFit,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                color: tokens.errorColor?.withValues(alpha: 0.1),
                child: Icon(
                  CupertinoIcons.photo,
                  color: tokens.errorColor,
                  size: 48,
                ),
              );
        },
      );
    }

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
