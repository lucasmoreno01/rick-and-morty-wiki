import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/presentation/widgets/character_card.dart';
import 'package:rick_and_morty_wiki/core/infra/service_locator.dart';
import 'package:rick_and_morty_wiki/characters/domain/characters_use_cases.dart';
import 'package:rick_and_morty_wiki/core/infra/favorites_service.dart';
import 'package:rick_and_morty_wiki/core/theme/app_typography.dart';
import 'package:rick_and_morty_wiki/core/theme/color_theme.dart';

class CharactersListPage extends HookWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final charactersQuery =
        useInfiniteQuery<List<CharacterEntity>, Object, int>(
          ['characters'],
          (page) async => sl<GetCharacters>().call(page: page),
          getNextPageParam: (lastPage, pages, pageParam, pageParams) =>
              lastPage.isEmpty ? null : pages.length + 1,
          initialPageParam: 1,
        );

    final showFavorites = useState(false);
    final favorites = useState<List<int>>([]);

    useEffect(() {
      void onScroll() {
        if (charactersQuery.isFetchingNextPage ||
            !charactersQuery.hasNextPage) {
          return;
        }
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100) {
          charactersQuery.fetchNextPage();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController, charactersQuery]);

    useEffect(() {
      if (showFavorites.value) {
        sl<FavoritesService>().getFavorites().then((ids) {
          favorites.value = ids;
        });
      }
      return null;
    }, [showFavorites.value]);

    if (charactersQuery.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (charactersQuery.isError) {
      return Scaffold(
        body: Center(child: Text('Erro: ${charactersQuery.error}')),
      );
    }

    final allCharacters =
        charactersQuery.data?.pages.expand((p) => p).toList() ?? [];

    final charactersToShow = showFavorites.value
        ? allCharacters.where((c) => favorites.value.contains(c.id)).toList()
        : allCharacters;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.background,
        title: SvgPicture.asset('assets/rick_and_morty_logo.svg', height: 32),
        centerTitle: true,
      ),
      backgroundColor: ColorTheme.background,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => showFavorites.value = false,
                    child: Text(
                      "Todos os Personagens",
                      style: AppTypography.bold22.copyWith(
                        color: showFavorites.value
                            ? Colors.white70
                            : ColorTheme.tertiary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showFavorites.value = true,
                    child: Text(
                      "Favoritos",
                      style: AppTypography.bold22.copyWith(
                        color: showFavorites.value
                            ? ColorTheme.tertiary
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: charactersToShow.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'Nenhum personagem salvo como favorito',
                        style: AppTypography.medium20.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (!showFavorites.value &&
                            index == charactersToShow.length) {
                          if (charactersQuery.hasNextPage) {
                            charactersQuery.fetchNextPage();
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }

                        if (index >= charactersToShow.length) {
                          return const SizedBox.shrink();
                        }

                        final character = charactersToShow[index];
                        return CharacterCard(character: character);
                      },
                      childCount:
                          charactersToShow.length +
                          (showFavorites.value ? 0 : 1),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                  ),
          ),
        ],
      ),
    );
  }
}
