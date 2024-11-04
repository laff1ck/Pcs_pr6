import 'package:flutter/material.dart';
import 'package:pr6/models/note.dart';
import 'package:pr6/components/note_card.dart' as noteCard;
import 'add_note_page.dart';
import 'favorites_notes_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'item_note_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Note> notes = [];
  List<Note> favorites = [];
  List<Note> cart = [];

  @override
  void initState() {
    super.initState();
    notes = [
      // Пример данных
    ];
  }

  void _addNoteToCart(Note note) {
    setState(() {
      if (cart.contains(note)) {
        note.quantity++;
      } else {
        note.quantity = 1;
        cart.add(note);
      }
    });
  }

  void _addQuantity(Note note) {
    setState(() {
      note.quantity++;
    });
  }

  void _removeQuantity(Note note) {
    setState(() {
      if (note.quantity > 1) {
        note.quantity--;
      } else {
        cart.remove(note);
      }
    });
  }

  void _openCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartItems: cart,
          onAddQuantity: _addQuantity,
          onRemoveQuantity: _removeQuantity,
        ),
      ),
    );
  }


  void _addNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  void _toggleFavorite(Note note) {
    setState(() {
      note.isFavorite = !note.isFavorite;
      if (note.isFavorite) {
        favorites.add(note);
      } else {
        favorites.remove(note);
      }
    });
  }

  void _openNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemNotePage(note: note),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentPage() {
    switch (_selectedIndex) {
      case 1:
        return FavoritePage(
          favorites: favorites,
          onOpenNote: _openNote,
          onRemoveFromFavorites: _toggleFavorite,
          onAddToCart: _addNoteToCart,
        );
      case 2:
        return ProfilePage();
      default:
        return _buildNoteList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),

        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _openCartPage,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateNotePage(onCreate: _addNote),
                ),
              );
            },
          ),
        ],
      ),
      body: _getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildNoteList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return noteCard.NoteCard(
          note: note,
          onTap: () => _openNote(note),
          onToggleFavorite: () {
            _toggleFavorite(note);
          },
          onAddToCart: () {
            _addNoteToCart(note);
          },
        );
      },
    );
  }
}
