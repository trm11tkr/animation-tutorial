# animation_tutorial

This is an exercise in implementing animations in Flutter.

## AnimatedWidgetを使用したアニメーションの作成
- 利用することで、ビュー(AnimatedLogo)とロジック(LogoApp)を分離することが可能になった
- addListenerメソッドで現在の状態を管理できる
  AnimationStatus.completeやAnimationStatus.dismissedなどを条件に用いることで
  無限ループが可能になった