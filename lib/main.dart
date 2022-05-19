import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    /// アニメーションの定義
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        // addStatusListenerで現在の状態を管理
        // .completeでアニメーション完了を確認するとリバース
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
        // .dismissedでアニメーションが消えたことを確認すると再度実行
        else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward(); // animation呼び出し
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  // メモリリークを防ぐため、animation.valueが更新されるとcontrollerを破棄
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      // Opacityで不透明度を調節
      child: Opacity(
        opacity: _opacityTween.evaluate(animation), // 0.0(透明) ~ 1.0(不透明)
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}