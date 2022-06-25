class Posts {
  String? name;
  String? type;
  String? color;
  String? category;


  Posts({
    this.name,
    this.type,
    this.color,
    this.category
  });

  //convert object to json
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'type': type,
        'color': color,
        'category': category,
      };

  //returns user object
  static Posts fromJson(Map<String, dynamic> json) =>
      Posts(
          name: json['name'],
          type: json['type'],
          color: json['color'],
          category: json['category']
      );

}