part of '../../design_system.dart';

mixin NeoImageRenderer on DesignStyle {
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
                decoration: BoxDecoration(
                  color: tokens.placeholderColor,
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                ),
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: tokens.errorColor?.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.black,
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
                decoration: BoxDecoration(
                  color: tokens.errorColor?.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.black,
                  size: 48,
                ),
              );
        },
      );
    }

    // Neo style always has a border
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: ClipRect(child: imageWidget),
    );
  }
}
