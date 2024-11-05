class Sheet {
  String id;
  String name;
  int width;

  Sheet({
    required this.id,
    this.name = '',
    this.width = 0,
  });

  Sheet copyWith({
    String? id,
    String? name,
    int? width,
  }) {
    return Sheet(
      id: id ?? this.id,
      name: name ?? this.name,
      width: width ?? this.width,
    );
  }
}
