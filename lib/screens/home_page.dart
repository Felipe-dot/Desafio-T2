import 'package:desafio_2/models/book_model.dart';
import 'package:desafio_2/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/book_cover.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFavoritesBooks = false;
  List<BookModel> listOfFavoriteBooks = [];
  List<BookModel> listOfBooks = [];

  @override
  void initState() {
    listOfFavoriteBooks = context.read<FavoriteBookList>().favoriteBookList;
    listOfBooks = context.read<BookList>().bookList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 600,
          leading: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    showFavoritesBooks = false;
                  });
                },
                child: Text("Livros"),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    showFavoritesBooks = true;
                  });
                },
                child: Text("Favoritos"),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
              ),
            ],
          ),
        ),
        body: GridView.builder(
          itemCount: showFavoritesBooks
              ? listOfFavoriteBooks.length
              : listOfBooks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
            mainAxisExtent: 200,
          ),
          itemBuilder: (ctx, idx) {
            return showFavoritesBooks
                ? BookCover(
                    book: listOfFavoriteBooks[idx],
                  )
                : BookCover(
                    book: listOfBooks[idx],
                  );
          },
        ));
  }
}
