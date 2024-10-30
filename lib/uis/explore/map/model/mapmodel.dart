class MapModel {
  bool? status;
  String? message;
  List<MapResult>? result;

  MapModel({
    this.status,
    this.message,
    this.result,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
    status: json["status"],
    message: json["message"],
    result: json["result"] == null ? [] : List<MapResult>.from(json["result"]!.map((x) => MapResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class MapResult {
  bool? status;
  String? name;
  String? latitude;
  String? longitude;
  String? icon;
  int? id;
  int? hostId;

  MapResult({
    this.status,
    this.name,
    this.latitude,
    this.longitude,
    this.icon,
    this.id,
    this.hostId
  });

  factory MapResult.fromJson(Map<String, dynamic> json) => MapResult(
    status: json["status"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    icon: json["icon"],
    id: json['id'],
    hostId: json['host_id']
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "icon": icon,
  };
}
