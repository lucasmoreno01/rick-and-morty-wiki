import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/domain/charater_status.dart';
import 'package:rick_and_morty_wiki/core/app_routes.dart';
import 'package:rick_and_morty_wiki/core/theme/app_typography.dart';
import 'package:rick_and_morty_wiki/core/theme/color_theme.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.characterDetails,
        arguments: character.id,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: character.status.color, width: 2),
          color: ColorTheme.primary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              character.name,
              style: AppTypography.bold20.copyWith(color: Colors.white),
            ),
            Text(
              character.species,
              style: AppTypography.medium20.copyWith(color: Colors.white70),
            ),

            if (character.status != CharacterStatus.unknown)
              Text(
                character.status.label,
                style: AppTypography.medium20.copyWith(
                  color: character.status.color,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
