import 'package:json_annotation/json_annotation.dart';
part 'food.g.dart';

@JsonSerializable()
class Food {
  final int id;
  final String title;

  final String image;
  Food({required this.title, required this.id, required this.image});
  factory Food.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title, 'image': String image} => Food(
        id: id,
        title: title,
        image: image,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
