import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/redux/store.dart';
import 'package:exun_app_21/redux/talks_state.dart';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:meta/meta.dart';

import '../main_screens/talks_screen.dart';

@immutable
class SetTalksStateAction {
  final TalksState talksState;

  SetTalksStateAction(this.talksState);
}

Future<void> fetchPostsAction(Store<AppState> store) async {

  List<Talk> _talks = [];
  final _firestore = FirebaseFirestore.instance;

  store.dispatch(SetTalksStateAction(TalksState(isLoading: true, talks: [], isError: false)));

  try {
    final tsnapshot = await _firestore.collection("talks").get();
    print("snapshot");
    print(tsnapshot);
    print(tsnapshot.docs);
    // final snapshot = await _firestore.collection("users").doc(currentUser?.uid).get();
    // print("snapshot");
    store.dispatch(
      SetTalksStateAction(
        TalksState(
          isLoading: false,
          talks: tsnapshot.docs.map((e) => Talk.fromSnapshot(e)).toList(),
          isError: false,
        ),
      ),
    );
  } catch (error) {
    store.dispatch(SetTalksStateAction(TalksState(isLoading: false, isError: true, talks: [])));
  }
}