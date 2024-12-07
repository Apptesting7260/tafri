class TimeZoneModal {
  bool? status;
  List<Country>? result;

  TimeZoneModal({
    this.status,
    this.result,
  });

  factory TimeZoneModal.fromJson(Map<String, dynamic> json) => TimeZoneModal(
    status: json["status"],
    result: json["result"] == null ? [] : List<Country>.from(json["result"]!.map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Country {
  String? country;
  List<Timezone>? timezones;

  Country({
    this.country,
    this.timezones,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    country: json["country"],
    timezones: json["timezones"] == null ? [] : List<Timezone>.from(json["timezones"]!.map((x) => Timezone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "timezones": timezones == null ? [] : List<dynamic>.from(timezones!.map((x) => x.toJson())),
  };
}

class Timezone {
  int? id;
  String? timeZone;
  String? gmtOffset;

  Timezone({
    this.id,
    this.timeZone,
    this.gmtOffset,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    id: json["id"],
    timeZone: json["time_zone"],
    gmtOffset: json["gmt_offset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time_zone": timeZone,
    "gmt_offset": gmtOffset,
  };
}
