import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract interface class StateLifecycleObserver {
  void onInit();

  void onClose();

  static R useStateLifecycleObserver<R extends StateLifecycleObserver>(
      R observer) => use(_StateLifecycleObserverHook(observer));
}

class _StateLifecycleObserverHook<R extends StateLifecycleObserver>
    extends Hook<R> {
  const _StateLifecycleObserverHook(this.observer);

  final R observer;

  @override
  HookState<R, Hook<R>> createState() =>
      _StateLifecycleObserverHookState(observer);
}

class _StateLifecycleObserverHookState<R extends StateLifecycleObserver>
    extends HookState<R, _StateLifecycleObserverHook<R>> {
  _StateLifecycleObserverHookState(this.observer);

  final R observer;

  @override
  R build(BuildContext context) => observer;

  @override
  void initHook() {
    super.initHook();
    observer.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    observer.onClose();
  }
}
