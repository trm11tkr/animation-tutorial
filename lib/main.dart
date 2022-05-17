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

    // ロゴの大きさの遷移範囲を設定
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() { // animation.addListener()と同じ
        // setStateを呼び出し、強制的に再buildを呼び出す
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }

  // メモリリークを防ぐため、animation.valueが更新されるとcontrollerを破棄
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
