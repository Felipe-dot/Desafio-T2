import 'package:desafio_2/models/book_model.dart';
import 'package:flutter/material.dart';

class BookCover extends StatefulWidget {
  final BookModel book;

  const BookCover({super.key, required this.book});

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 100,
                width: 80,
                child: Image.network(
                  widget.book.coverUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 60,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.book.isFavorite = !widget.book.isFavorite;
                  });
                },
                child: Container(
                  width: 20,
                  height: 35,
                  decoration: BoxDecoration(
                      color: widget.book.isFavorite ? Colors.red : Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                ),
              ),
            ),
          ],
        ),
        Text(widget.book.title),
        Text(widget.book.author),
      ],
    );
  }
}
