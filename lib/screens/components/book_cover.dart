import 'dart:io';

import 'package:desafio_2/models/book_model.dart';
import 'package:desafio_2/providers/providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:flutter/services.dart';

import '../../controllers/epub_viewer_controller.dart';
import '../../utils/utils.dart';

class BookCover extends StatefulWidget {
  final BookModel book;

  const BookCover({super.key, required this.book});

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  final platform = MethodChannel('my_channel');
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () async {
                print("=====filePath======$filePath");
                if (filePath == "") {
                  await download(startDownload);
                  if (!mounted) {
                    return;
                  }
                  openBook(context, filePath, widget.book.id);
                } else {
                  openBook(context, filePath, widget.book.id);
                }
              },
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
                    if (widget.book.isFavorite == true) {
                      context.read<FavoriteBookList>().push(widget.book);
                      showSnackBar("O livro foi adicionada a lista", context);
                    } else {
                      context.read<FavoriteBookList>().remove(widget.book);
                      showSnackBar("O livro foi removido da lista", context);
                    }
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
        const Divider(
          endIndent: 20,
          indent: 20,
        ),
        Text(widget.book.author),
      ],
    );
  }

  startDownload() async {
    setState(() {
      loading = true;
    });
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = appDocDir!.path + '/${widget.book.title}.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        widget.book.downloadUrl,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          print('Download --- ${(receivedBytes / totalBytes) * 100}');
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }
}
