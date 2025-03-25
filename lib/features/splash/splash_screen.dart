import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ModularState<SplashScreen, SplashController>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    AppTheme.setLightStatusBar();

    _animationController = AnimationController(
      vsync: this,
      duration: Durations.splashAnimation,
    )..addListener(_startListener);

    _scaleAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );

    _animationController.forward();

    super.initState();
  }

  void _startListener() {
    if (_animationController.isCompleted) {
      controller.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: AppColors.secondary,
    );
  }

  Widget _body() {
    return SafeArea(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => _animatedLogo(),
      ),
    );
  }

  Widget _animatedLogo() {
    return Center(
      child: Opacity(
        opacity: _scaleAnimation.value,
        child: SvgPicture.asset(
          Svgs.logoWhite,
          height: _scaleAnimation.value * Dimens.splashImageSize,
        ),
      ),
    );
  }
}
