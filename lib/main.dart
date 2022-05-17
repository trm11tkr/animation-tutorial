import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

// AnimatedWidgetにより、ロジックとビューの分離が可能に
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  // 現在のvalueをanimationで保持する

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

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

    // ロゴの大きさの遷移範囲を設定
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        // addStatusListenerで現在の状態を管理
        // .completeでアニメーション完了を確認するとリバース
        if(status == AnimationStatus.completed) {
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
