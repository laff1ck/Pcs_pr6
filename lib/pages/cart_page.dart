import 'package:flutter/material.dart';
import 'package:pr6/models/note.dart';

class CartPage extends StatefulWidget {
  final List<Note> cartItems;
  final Function(Note) onAddQuantity;
  final Function(Note) onRemoveQuantity;

  const CartPage({
    Key? key,
    required this.cartItems,
    required this.onAddQuantity,
    required this.onRemoveQuantity,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final note = widget.cartItems[index];
          return ListTile(
            leading: note.photo_id.isNotEmpty
                ? Image.network(note.photo_id, width: 100, height: 100, fit: BoxFit.cover)
                : null,
            title: Text(note.title),
            subtitle: Text('${note.price} ₽'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    widget.onRemoveQuantity(note);
                  },
                ),
                Text(note.quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.onAddQuantity(note);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
