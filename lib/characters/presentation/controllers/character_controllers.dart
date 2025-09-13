import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/domain/characters_use_cases.dart';

class CharacterController {
  final GetCharacters getCharacters;
  final GetCharacterDetails getCharacterDetails;

  CharacterController({
    required this.getCharacters,
    required this.getCharacterDetails,
  });

  final ValueNotifier<List<CharacterEntity>> characters = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  Future<void> loadCharacters({int page = 1}) async {
    isLoading.value = true;
    error.value = null;

    try {
      final result = await getCharacters.call(page: page);
      characters.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<CharacterEntity?> loadCharacterById(int id) async {
    try {
      return await getCharacterDetails.call(id);
    } catch (e) {
      error.value = e.toString();
      return null;
    }
  }
}
