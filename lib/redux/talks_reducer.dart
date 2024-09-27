import 'package:exun_app_21/redux/talks_actions.dart';
import 'package:exun_app_21/redux/talks_state.dart';

postsReducer(TalksState prevState, SetTalksStateAction action) {
  final payload = action.talksState;
  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    talks: payload.talks,
  );
}