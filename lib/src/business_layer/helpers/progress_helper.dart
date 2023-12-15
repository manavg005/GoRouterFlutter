import 'package:flutter/material.dart';

class Loader {
  /// Function to display circular progress bar
  static display(
    BuildContext context, {
    double opacity = 0.6,
    String? message,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: MessageProgressBar(opacity: opacity),
          );
        },
      ),
    );
  }

  /// Function to stop circular progress bar
  static close(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}

class ProgressOverlay extends StatelessWidget {
  final double opacity;

  const ProgressOverlay({
    Key? key,
    this.opacity = 0.6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, opacity),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}

/// Widget used to display progress bar
class MessageProgressBar extends StatelessWidget {
  final double opacity;
  final bool shouldShowMessage;

  const MessageProgressBar({
    Key? key,
    this.opacity = 0.6,
    this.shouldShowMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          const SizedBox(height: 25),
          shouldShowMessage
              ? const Text(
                  "Please Wait...",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

/*
class ProgressBar extends StatelessWidget {
  final double opacity;

  const ProgressBar({Key? key, this.opacity = 0.6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white.withOpacity(opacity),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.peach,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      ),
    );
  }
}
*/
