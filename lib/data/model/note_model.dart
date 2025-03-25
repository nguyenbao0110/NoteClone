import 'package:apple_notes_clone/domain/entity/note.dart';

class NoteModel extends Note {
  @override
  final String id;
  final String title;
  final String content;
  final DateTime remindAt;// Kiểm tra kiểu dữ liệu này
  final int color;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.remindAt,
    this.color = 0xFFFFFFFF
  }) : super(id: id, title: title, content: content, remindAt: remindAt,color: color);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'remindAt': remindAt.millisecondsSinceEpoch, // Lưu dưới dạng timestamp
      'color': color
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'].toString(), // Đảm bảo id luôn là String
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      remindAt: json['remindAt'] is int  // Kiểm tra nếu là int thì convert
          ? DateTime.fromMillisecondsSinceEpoch(json['remindAt'])
          : DateTime.parse(json['remindAt']),
      color: json['color'] ?? 0xFFFFFFFF,
    );
  }


}

