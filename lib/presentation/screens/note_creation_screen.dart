import 'package:flutter/material.dart';

class NoteCreationScreen extends StatefulWidget {
  const NoteCreationScreen({super.key});

  @override
  State<NoteCreationScreen> createState() => _NoteCreationScreenState();
}

class _NoteCreationScreenState extends State<NoteCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Color selectedColor = Colors.yellowAccent;

  // Danh sách các màu có thể chọn
  final List<Color> noteColors = [
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        actions: [
          IconButton(
            onPressed: () async {
              if (_titleController.text.isNotEmpty ||
                  _contentController.text.isNotEmpty) {
                bool? shouldSave = await _showSaveDialog();
                if (shouldSave == true) {
                  Navigator.pop(context, {
                    "title": _titleController.text,
                    "content": _contentController.text,
                    "color": selectedColor.value, // Lưu giá trị màu
                  });
                }
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ô nhập tiêu đề
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: "Enter title"),
            ),
            const SizedBox(height: 10),
            // Ô nhập nôii dung
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  TextField(
                  controller: _contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Enter your note content",
                    border: InputBorder.none, // Ẩn viền để nhìn đẹp hơn
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Chọn màu
            Wrap(
              spacing: 10,
              children: noteColors.map((color) => _buildColorOption(color)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            width: selectedColor == color ? 3 : 1,
            color: selectedColor == color ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Future<bool?> _showSaveDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: const Row(
            children: [
              Icon(Icons.info, color: Colors.grey),
              SizedBox(width: 8),
              Text("Save changes?", style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Discard", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
