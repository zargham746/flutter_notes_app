import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 80,
        vertical: 20,
      ),
      child: SizedBox.square(
        child: brightness == Brightness.dark
            ? Image.asset('assets/icons/logo-dark-mode.png')
            : Image.asset('assets/icons/logo-light-mode.png'),
      ),
    );
  }
}
