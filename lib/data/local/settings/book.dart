import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String author;
  @HiveField(3)
  String coverUrl;
  @HiveField(4)
  String downloadUrl;
  @HiveField(5)
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
    required this.isFavorite,
  });
}
