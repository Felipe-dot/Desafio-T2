import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookList with ChangeNotifier {
  List<BookModel> _bookList = [];

  List<BookModel> get bookList => _bookList;

  void add(List<BookModel> myList) {
    _bookList = myList;
    notifyListeners();
  }
}
