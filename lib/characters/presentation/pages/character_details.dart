import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:rick_and_morty_wiki/characters/domain/characters_use_cases.dart';
import 'package:rick_and_morty_wiki/core/infra/favorites_service.dart';
import 'package:rick_and_morty_wiki/core/infra/service_locator.dart';
import 'package:rick_and_morty_wiki/core/theme/app_typography.dart';
import 'package:rick_and_morty_wiki/core/theme/color_theme.dart';

class CharacterDetails extends HookWidget {
  const CharacterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final characterId = ModalRoute.of(context)!.settings.arguments as int;

    final characterDetailsQuery = useQuery([
      'character-details',
      characterId,
    ], () => sl<GetCharacterDetails>().call(characterId));
    final characterDetails = characterDetailsQuery.data;

    final favoritesService = sl<FavoritesService>();
    final isFavorite = useState<bool>(false);
    useEffect(() {
      favoritesService.isFavorite(characterId).then((value) {
        isFavorite.value = value;
      });
      return null;
    }, []);

    if (characterDetails == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.background,
        title: Text(
          characterDetails.name,
          style: AppTypography.bold25.copyWith(color: Colors.white),
        ),

        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.vertical(
                  bottom: Radius.circular(32),
                ),
                child: Image.network(
                  characterDetails.image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _InfoCard(
                        label: characterDetails.species,
                        color: ColorTheme.tertiary,
                      ),
                      _InfoCard(
                        label: characterDetails.gender,
                        color: ColorTheme.secondary,
                        textColor: Colors.white,
                      ),
                      if (characterDetails.status.name != 'unknown')
                        _InfoCard(
                          label: characterDetails.status.label,
                          color: characterDetails.status.color,
                          textColor: characterDetails.status.name == "Dead"
                              ? Colors.white
                              : Colors.black87,
                        ),
                    ],
                  ),

                  SizedBox(height: 16),

                  if (characterDetails.origin.name != 'unknown')
                    Text(
                      'Origem: ${characterDetails.origin.name}',
                      style: AppTypography.regular22,
                    ),
                  if (characterDetails.location.name != 'unknown')
                    Text(
                      'Localizado em: ${characterDetails.location.name}',
                      style: AppTypography.regular22,
                    ),
                  Text(
                    'Aparece em ${characterDetails.episode.length} episódios',
                    style: AppTypography.regular22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(ColorTheme.primary),
          ),
          onPressed: () async {
            await favoritesService.toggleFavorite(characterId);
            isFavorite.value = !isFavorite.value;
          },
          child: Row(
            spacing: 8,
            children: [
              Icon(isFavorite.value ? Icons.favorite : Icons.favorite_border),
              Text(
                isFavorite.value
                    ? "Remover dos favoritos"
                    : "Adicionar aos favoritos",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const _InfoCard({
    required this.label,
    required this.color,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Text(
        label,
        style: AppTypography.medium20.copyWith(color: textColor),
      ),
    );
  }
}
