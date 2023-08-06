class TodoModel {
  final int id;
  final String title;
  final bool isCompleted;
  final String description;
  final String createdAt;
  final String updatedAt;

  TodoModel(
    this.id,
    this.title,
    this.isCompleted,
    this.description,
    this.createdAt,
    this.updatedAt,
  );

  // JSON serialization: Map<String, dynamic> -> TodoModel
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      json['id'],
      json['title'],
      json['is_completed'],
      json['description'],
      json['created_at'],
      json['updated_at'],
    );
  }

  // JSON deserialization: TodoModel -> Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'is_completed': isCompleted,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
  //Copy with function

  TodoModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return TodoModel(
      id ?? this.id,
      title ?? this.title,
      isCompleted ?? this.isCompleted,
      description ?? this.description,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }
}
