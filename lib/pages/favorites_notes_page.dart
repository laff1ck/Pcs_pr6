import 'package:flutter/material.dart';
import 'package:pr6/models/note.dart';

class FavoritePage extends StatelessWidget {
  final List<Note> favorites;
  final Function(Note) onOpenNote;
  final Function(Note) onRemoveFromFavorites;
  final Function(Note) onAddToCart;

  const FavoritePage({
    Key? key,
    required this.favorites,
    required this.onOpenNote,
    required this.onRemoveFromFavorites,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final note = favorites[index];
        return ListTile(
          title: Text(note.title),
          subtitle: Text('${note.price} ₽'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onRemoveFromFavorites(note),
              ),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () => onAddToCart(note),
              ),
            ],
          ),
          onTap: () => onOpenNote(note),
        );
      },
    );
  }
}
