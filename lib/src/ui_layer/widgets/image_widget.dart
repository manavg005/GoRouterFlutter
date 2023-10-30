import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// this is a custom widget that shows an image from the internet and handles
/// errors
/// it uses the [cached_network_image] package
/// https://pub.dev/packages/cached_network_image
class CommonNetworkImage extends StatefulWidget {
  const CommonNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.placeholderWidget,
    this.errorWidget,
    this.errorIcon = Icons.error,
    this.errorIconColor = Colors.red,
    this.errorIconSize = 50,
    this.errorText = 'Cannot load image',
    this.retryButtonText = 'Retry',
    this.retryButtonOnPressed,
    this.showRetryButton = true,
    this.showErrorIcon = true,
    this.showPlaceholderWidget = true,
    this.showErrorWidget = true,
    this.fit = BoxFit.cover,
  });

  /// the url of the image
  final String imageUrl;

  /// the width and height of the image
  final double? width, height;

  /// the placeholder and the error widget to show while loading the image
  final Widget? placeholderWidget, errorWidget;

  /// the error icon to show when the image fails to load
  final IconData errorIcon;

  /// the color of the error icon
  final Color errorIconColor;

  /// the size of the error icon
  final double errorIconSize;

  /// the error text to show when the image fails to load
  /// and the retry button text
  final String errorText, retryButtonText;

  /// the retry button onPressed callback
  final VoidCallback? retryButtonOnPressed;

  /// whether to show the retry button, the error icon, the placeholder widget
  final bool showRetryButton,
      showErrorIcon,
      showPlaceholderWidget,
      showErrorWidget;

  final BoxFit fit;

  @override
  State<CommonNetworkImage> createState() => _CommonNetworkImageState();
}

class _CommonNetworkImageState extends State<CommonNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: widget.width,
      height: widget.height,
      imageUrl: widget.imageUrl ?? '',
      fit: widget.fit,
      placeholder: (context, url) => widget.showPlaceholderWidget
          ? widget.placeholderWidget ?? const CircularProgressIndicator()
          : Container(),
      errorWidget: (context, url, error) {
        return widget.showErrorWidget
            ? widget.errorWidget ??
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// this is the error icon
                    if (widget.showErrorIcon)
                      Icon(widget.errorIcon,
                          color: widget.errorIconColor,
                          size: widget.errorIconSize),

                    /// some space
                    // const SizedBox(height: 10),

                    /// this is the error text
                    // Text(widget.errorText),

                    /// this is the retry button
                    if (widget.showRetryButton)
                      TextButton(
                        onPressed: () {
                          /// call the retry button callback
                          widget.retryButtonOnPressed?.call();

                          // Force reload image
                          setState(() {});
                        },

                        /// this is the retry button text
                        child: Text(widget.retryButtonText),
                      ),
                  ],
                )
            : Container();
      },
    );
  }
}
