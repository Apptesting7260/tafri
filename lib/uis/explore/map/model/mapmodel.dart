class MapModel {
  bool? status;
  String? message;
  List<Result>? result;

  MapModel({
    this.status,
    this.message,
    this.result,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
    status: json["status"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  bool? status;
  String? name;
  String? latitude;
  String? longitude;
  String? icon;

  Result({
    this.status,
    this.name,
    this.latitude,
    this.longitude,
    this.icon,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    status: json["status"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "icon": icon,
  };
}
