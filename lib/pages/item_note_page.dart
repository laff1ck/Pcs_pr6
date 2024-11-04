import 'package:flutter/material.dart';
import 'package:pr6/models/note.dart';

class ItemNotePage extends StatelessWidget {
  final Note note;

  const ItemNotePage({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.photo_id.isNotEmpty)
              Image.network(note.photo_id),
            const SizedBox(height: 16),
            Text(note.title, style: Theme.of(context).textTheme.titleLarge), // Изменение здесь
            const SizedBox(height: 8),
            Text(note.description),
            const SizedBox(height: 8),
            Text('${note.price} ₽', style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
