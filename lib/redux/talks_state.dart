import 'package:exun_app_21/main_screens/talks_screen.dart';
import 'package:meta/meta.dart';

@immutable
class TalksState {
  final bool isLoading;
  final bool isError;
  final List<Talk> talks;

  TalksState({required this.talks, required this.isError, required this.isLoading});

  factory TalksState.initial() => TalksState(
    isLoading: false,
    isError: false,
    talks: const [],
  );

  TalksState copyWith({required isError, required isLoading, required talks}) {
    return TalksState(talks: talks ?? this.talks, isError: isError ?? this.isError, isLoading: isLoading ?? this.isLoading);
  }

}