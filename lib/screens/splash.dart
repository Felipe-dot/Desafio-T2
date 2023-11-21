import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/remote/remote_api.dart';
import '../models/book_model.dart';
import '../providers/providers.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getListOfBooks() async {
    List<BookModel> listOfBooks = [];
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

    if (!mounted) {
      return;
    }

    context.read<BookList>().add(listOfBooks);
  }

  @override
  void initState() {
    super.initState();
    getListOfBooks();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Cor de fundo da splash screen
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
