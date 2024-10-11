class AllCustomerModal {
  Embedded? embedded;
  int? count;

  AllCustomerModal({
    this.embedded,
    this.count,
  });


  factory AllCustomerModal.fromJson(Map<String, dynamic> json) => AllCustomerModal(
    embedded: json["_embedded"] == null ? null : Embedded.fromJson(json["_embedded"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "_embedded": embedded?.toJson(),
    "count": count,
  };
}

class Embedded {
  List<Customer>? customers;

  Embedded({
    this.customers,
  });


  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
    customers: json["customers"] == null ? [] : List<Customer>.from(json["customers"]!.map((x) => Customer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customers": customers == null ? [] : List<dynamic>.from(customers!.map((x) => x.toJson())),
  };
}

class Customer {
  String? resource;
  String? id;
  String? mode;
  String? name;
  String? email;
  String? locale;
  dynamic metadata;
  DateTime? createdAt;

  Customer({
    this.resource,
    this.id,
    this.mode,
    this.name,
    this.email,
    this.locale,
    this.metadata,
    this.createdAt,
  });


  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    resource: json["resource"],
    id: json["id"],
    mode: json["mode"],
    name: json["name"],
    email: json["email"],
    locale: json["locale"],
    metadata: json["metadata"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "resource": resource,
    "id": id,
    "mode": mode,
    "name": name,
    "email": email,
    "locale": locale,
    "metadata": metadata,
    "createdAt": createdAt?.toIso8601String(),
  };
}



