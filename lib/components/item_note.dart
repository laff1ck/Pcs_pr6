import 'package:flutter/material.dart';
import 'package:pr6/models/note.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  final Function(int) onDelete;

  const ItemNote({
    Key? key,
    required this.note,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.photo_id.isNotEmpty)
              Image.network(note.photo_id),
            const SizedBox(height: 16),
            Text(note.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(note.description),
            const SizedBox(height: 8),
            Text('${note.price} ₽', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтверждение'),
          content: const Text('Вы уверены, что хотите удалить этот товар?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                onDelete(note.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}