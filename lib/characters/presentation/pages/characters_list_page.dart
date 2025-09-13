import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fquery/fquery.dart';
import 'package:rick_and_morty_wiki/characters/domain/character_entity.dart';
import 'package:rick_and_morty_wiki/characters/presentation/widgets/character_card.dart';
import 'package:rick_and_morty_wiki/core/infra/service_locator.dart';
import 'package:rick_and_morty_wiki/characters/domain/characters_use_cases.dart';
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.background,
        title: SvgPicture.asset('assets/rick_and_morty_logo.svg', height: 32),
        centerTitle: true,
      ),
      backgroundColor: ColorTheme.background,
      body: GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: allCharacters.length + 1,
        itemBuilder: (_, index) {
          if (index == allCharacters.length) {
            if (charactersQuery.hasNextPage) {
              charactersQuery.fetchNextPage();
              return const Center(child: CircularProgressIndicator());
            } else {
              return const SizedBox.shrink();
            }
          }
          final character = allCharacters[index];
          return CharacterCard(character: character);
        },
      ),
    );
  }
}
