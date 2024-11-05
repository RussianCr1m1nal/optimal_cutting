class DetailParametr {
  String id;
  String name;
  int value;

  DetailParametr({
    required this.id,
    this.name = '',
    this.value = 0,
  });

  DetailParametr copyWith({
    String? id,
    String? name,
    int? value,
  }) {
    return DetailParametr(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is DetailParametr &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.name == name &&
      other.value == value;

  @override
  int get hashCode => id.hashCode;
}
