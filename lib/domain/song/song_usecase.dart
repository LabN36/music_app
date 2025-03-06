import 'package:music_app/domain/song/song_entity.dart';

import 'song_repository.dart';

class GetSongsUsecase {
  final SongRepository _songRepository;

  GetSongsUsecase(this._songRepository);

  Future<List<SongEntity>?> execute() {
    return _songRepository.getSongs();
  }
}
