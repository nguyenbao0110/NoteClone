import 'package:flutter/material.dart';
import '../../domain/entity/note.dart';

class ItemsWidget extends StatefulWidget {
  final List<Note> notes;
  final Function(int) onDelete;

  const ItemsWidget({super.key, required this.notes, required this.onDelete});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.notes.length,
      itemBuilder: (context, index) {
        final note = widget.notes[index];

        return Dismissible(
          key: Key(note.id), // Sử dụng ID của Note để tránh lỗi trùng key
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            widget.onDelete(index);
          },
          child: Card(
            color: Color(note.color), // Đặt màu nền cho Card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bo góc đẹp hơn
            ),
            child: ListTile(
              title: Text(
                note.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(note.content),
            ),
          ),
        );
      },
    );
  }
}
