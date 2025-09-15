# Rick and Morty Wiki 🛸👽

Um aplicativo Flutter que lista personagens do universo **Rick and Morty**, com detalhes dos personagens, paginação infinita e sistema de favoritos.

---

## ✨ Funcionalidades
- Listagem de personagens com **scroll infinito** usando [`fquery`](https://pub.dev/packages/fquery)
- Exibição de **detalhes** de cada personagem (imagem, status, espécie, origem, localização, episódios)
- **Salvar favoritos** com `SharedPreferences` + `Provider`
- Alternar entre **Todos os personagens** e apenas **Favoritos**
- UI responsiva e customizada com `Google Fonts` e `flutter_svg`

---

## 🧩 Arquitetura
Este projeto segue os princípios da **Clean Architecture**, garantindo separação de responsabilidades, testabilidade e escalabilidade:

- **Domain** → contém as entidades e casos de uso (`CharacterEntity`, `GetCharacters`, `GetCharacterDetails`).
- **Infra** → lida com persistência e serviços externos, como o `FavoritesService` e o `QueryClient`.
- **Presentation** → cuida da camada de UI (páginas, widgets e integração com o estado), utilizando `Provider` e `Flutter Hooks`.

Essa organização permite que mudanças na interface ou no backend não afetem diretamente as regras de negócio. Além disso, o uso do **Service Locator** facilita a injeção de dependências e mantém a aplicação desacoplada.

---

## 🛠️ Principais tecnologias utilizadas
- **[Provider](https://pub.dev/packages/provider)** 
- **[fquery](https://pub.dev/packages/fquery)** 
- **[SharedPreferences](https://pub.dev/packages/shared_preferences)** 
- **[Flutter Hooks](https://pub.dev/packages/flutter_hooks)** 
- **[Get it](https://pub.dev/packages/get_it)** 
