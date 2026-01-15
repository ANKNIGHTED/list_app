class Recipe {
  final int id;
  final String title;
  final String image;
  final String summary;
  final String instructions;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.instructions,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var ingredientList =
        (json['extendedIngredients'] as List?)
            ?.map((item) => item['original'] as String)
            .toList() ??
        [];

    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      // Removing HTML tags from the strings
      summary: json['summary']?.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '') ?? '',
      instructions:
          json['instructions']?.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '') ??
          'No instructions available.',
      ingredients: ingredientList,
    );
  }
}
