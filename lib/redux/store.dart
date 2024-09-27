

import 'package:exun_app_21/redux/talks_actions.dart';
import 'package:exun_app_21/redux/talks_reducer.dart';
import 'package:exun_app_21/redux/talks_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:redux_thunk/redux_thunk.dart';

//todo: update
AppState appReducer(AppState state, dynamic action) {
  if (action is SetTalksStateAction) {
    final nextPostsState = postsReducer(state.talksState, action);

    return state.copyWith(talksState: nextPostsState);
  }

  return state;
}

@immutable
class AppState {
  final TalksState talksState;

  AppState({
    required this.talksState,
  });

  AppState copyWith({
    required TalksState talksState,
  }) {
    return AppState(
      talksState: talksState ?? this.talksState,
    );
  }
}

class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final talksStateInitial = TalksState.initial();

    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(talksState: talksStateInitial),
    );
  }
}