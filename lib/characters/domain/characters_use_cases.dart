import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<List<CharacterEntity>> call({int page = 1}) {
    return repository.getCharacters(page: page);
  }
}

class GetCharacterDetails {
  final CharacterRepository repository;

  GetCharacterDetails(this.repository);

  Future<CharacterEntity> call(int id) {
    return repository.getCharacterById(id);
  }
}
