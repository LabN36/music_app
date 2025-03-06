import 'package:bloc/bloc.dart';
import 'package:music_app/domain/song/song_entity.dart';
import 'package:music_app/domain/song/song_usecase.dart';

abstract class SongEvent {}

class GetSongsEvent extends SongEvent {}

class SongState {
  final List<SongEntity>? songs;
  final bool isLoading;
  final String error;

  SongState({
    required this.songs,
    required this.isLoading,
    required this.error,
  });

  factory SongState.initial() {
    return SongState(
      songs: [],
      isLoading: false,
      error: '',
    );
  }

  SongState copyWith({
    List<SongEntity>? songs,
    bool? isLoading,
    String? error,
  }) {
    return SongState(
      songs: songs ?? this.songs,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class SongCubit extends Cubit<SongState> {
  final GetSongsUsecase getSongsUsecase;

  SongCubit(this.getSongsUsecase) : super(SongState.initial());

  void getSongs() async {
    emit(state.copyWith(isLoading: true));
    try {
      final songs = await getSongsUsecase.execute();
      emit(state.copyWith(songs: songs, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
