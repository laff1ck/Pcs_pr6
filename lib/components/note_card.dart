// note_card.dart
import 'package:flutter/material.dart';
import 'package:pr6/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function() onTap;
  final Function() onToggleFavorite;
  final Function() onAddToCart;

  const NoteCard({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onToggleFavorite,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (note.photo_id.isNotEmpty)
              Image.network(
                note.photo_id,
                width: 150,
                height: 100,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text('${note.price} ₽'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          note.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: note.isFavorite ? Colors.red : null,
                        ),
                        onPressed: onToggleFavorite,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: onAddToCart,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
