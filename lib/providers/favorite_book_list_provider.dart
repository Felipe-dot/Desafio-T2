import 'package:flutter/material.dart';

import '../models/book_model.dart';

class FavoriteBookList with ChangeNotifier {
  List<BookModel> _favoriteBookList = [];

  List<BookModel> get favoriteBookList => _favoriteBookList;

  void add(List<BookModel> myList) {
    _favoriteBookList = myList;
    notifyListeners();
  }

  void push(BookModel myBook) {
    _favoriteBookList.add(myBook);
    notifyListeners();
  }

  void remove(BookModel myBook) {
    _favoriteBookList.remove(myBook);
    notifyListeners();
  }
}
