import 'package:desafio_2/data/remote/remote_api.dart';
import 'package:desafio_2/models/book_model.dart';
import 'package:flutter/material.dart';

import 'components/book_cover.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> listOfBooks = [];

  Future<void> getListOfBooks() async {
    RemoteApi api = RemoteApi();

    List<dynamic> response = await api.fetchData();
    for (var element in response) {
      listOfBooks.add(
        BookModel(
          id: element['id'],
          title: element['title'],
          author: element['author'],
          coverUrl: element['cover_url'],
          downloadUrl: element['download_url'],
          isFavorite: false,
        ),
      );
    }
  }

  @override
  void initState() {
    getListOfBooks();
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
                onPressed: () {},
                child: Text("Livros"),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text("Favoritos"),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
              ),
            ],
          ),
        ),
        body: GridView.builder(
          itemCount: listOfBooks.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
            mainAxisExtent: 200,
          ),
          itemBuilder: (ctx, idx) {
            return BookCover(
              book: listOfBooks[idx],
            );
          },
        ));
  }
}
