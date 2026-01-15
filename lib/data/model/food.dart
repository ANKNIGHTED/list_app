import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Food {
  final int id;
  final String title;
  final String image;
  final String imageType;

  Food({
    required this.title,
    required this.id,
    required this.image,
    required this.imageType,
  });
  factory Food.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'title': String title, 'image': String image} => Food(
        id: id,
        title: title,
        image: image,
        imageType: json['imageType'],
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
