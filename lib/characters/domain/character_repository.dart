import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters({int page = 1});
  Future<CharacterEntity> getCharacterById(int id);
}
