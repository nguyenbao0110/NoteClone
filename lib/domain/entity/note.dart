class Note {
  final String id;
  final String title;
  final String content;
  final DateTime remindAt;
  final int color; // Đảm bảo kiểu dữ liệu là int

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.remindAt,
    this.color = 0xFFFFFFFF, // Mặc định là màu trắng
  });
}
