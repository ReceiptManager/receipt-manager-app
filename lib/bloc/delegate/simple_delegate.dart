import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (transition.currentState == null) {
      log("[TRANSITION] can't follow transaction. State is empty.");
      return;
    }

    super.onTransition(bloc, transition);
    print(transition.toString());
  }
}
