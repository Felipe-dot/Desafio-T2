import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteApi {
  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://escribo.com/books.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Falha na requisição');
    }
  }
}
