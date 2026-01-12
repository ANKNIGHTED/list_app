// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
  title: json['title'] as String,
  id: (json['id'] as num).toInt(),
  image: json['image'] as String,
);

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'image': instance.image,
};
