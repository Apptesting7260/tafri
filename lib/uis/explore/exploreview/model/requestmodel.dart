class Requestmodel {
  String? result;
  bool? status;
  String? requestStatus;
  int? upToPeople;
  int? spotsLeft;

  Requestmodel({
    this.result,
    this.status,
    this.requestStatus,
    this.upToPeople,
    this.spotsLeft,
  });

  factory Requestmodel.fromJson(Map<String, dynamic> json) => Requestmodel(
    result: json["result"],
    status: json["status"],
    requestStatus: json["request_status"],
    upToPeople: json["up_to_people"],
    spotsLeft: json["spots_left"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "status": status,
    "request_status": requestStatus,
    "up_to_people": upToPeople,
    "spots_left": spotsLeft,
  };
}
