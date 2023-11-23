import 'package:flutter/material.dart';

void showSnackBar(String text, dynamic context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '${text}',
      ),
    ),
  );
}

void showLoadingDialog(dynamic context) {
  showDialog(
    context: context,
    barrierDismissible:
        false, // Impede que o alerta seja fechado clicando fora dele
    builder: (BuildContext context) {
      return const AlertDialog(
        title: Text('Baixando...'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(), // Indicador de carregamento
            SizedBox(height: 10),
            Text('Carregando...'),
          ],
        ),
      );
    },
  );
}
