class GetPlanModal {
  bool? status;
  List<Result>? result;

  GetPlanModal({
    this.status,
    this.result,
  });

  factory GetPlanModal.fromJson(Map<String, dynamic> json) => GetPlanModal(
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
  String? name;
  String? price;
  String? billingInterval;
  String? billingPeriod;
  String? trailDays;
  String? planStatus;
  String? feature;
  String? createdAt;
  String? updatedAt;

  Result({
    this.id,
    this.name,
    this.price,
    this.billingInterval,
    this.billingPeriod,
    this.trailDays,
    this.planStatus,
    this.feature,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    billingInterval: json["billing_interval"],
    billingPeriod: json["billing_period"],
    trailDays: json["trail_days"],
    planStatus: json["plan_status"],
    feature: json["feature"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "billing_interval": billingInterval,
    "billing_period": billingPeriod,
    "trail_days": trailDays,
    "plan_status": planStatus,
    "feature": feature,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
