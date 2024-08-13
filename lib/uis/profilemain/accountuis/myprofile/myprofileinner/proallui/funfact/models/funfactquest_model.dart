class FunfactQuestModel {
  bool? status;
  List<Result>? result;

  FunfactQuestModel({
    this.status,
    this.result,
  });

  factory FunfactQuestModel.fromJson(Map<String, dynamic> json) => FunfactQuestModel(
    status: json["status"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? question;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isSelected;
  String? answer;

  Result({
    this.id,
    this.question,
    this.createdAt,
    this.updatedAt,
    this.isSelected,
    this.answer,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    question: json["question"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isSelected: json["isSelected"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "isSelected": isSelected,
    "answer": answer,
  };
}
