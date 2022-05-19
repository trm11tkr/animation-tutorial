import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin:
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    /// アニメーションの定義
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
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
  Widget build(BuildContext context) {
    return GrowTransition(animation: animation, child: const LogoWidget());
  }

  // メモリリークを防ぐため、animation.valueが更新されるとcontrollerを破棄
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// ロゴをレンダリングするWidget
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  // heightとweightを記述しないことで親Widgetを埋める
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

/// 変遷をレンダリング
class GrowTransition extends StatelessWidget {
  const GrowTransition({required this.child, required this.animation, Key? key})
      : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
