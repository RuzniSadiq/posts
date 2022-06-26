class Posts {
  String? name;
  String? type;
  String? color;
  String? category;
  List? searchnamekeywords;


  Posts({
    this.name,
    this.type,
    this.color,
    this.category,
    this.searchnamekeywords
  });

  //convert object to json
  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'type': type,
        'color': color,
        'category': category,
        'searchnamekeywords': searchnamekeywords
      };

  //returns user object
  static Posts fromJson(Map<String, dynamic> json) =>
      Posts(
          name: json['name'],
          type: json['type'],
          color: json['color'],
          category: json['category'],
          searchnamekeywords: json['searchnamekeywords']
      );

}