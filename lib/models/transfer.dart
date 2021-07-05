class Transfer {
  Transfer({
    required this.status,
    required this.data,
  });

  Status status;
  Data data;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        status: Status.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.status,
    required this.amount,
    required this.currencyCode,
    required this.destinationPhoneNumber,
    required this.destinationEwalletId,
    required this.destinationTransactionId,
    required this.sourceEwalletId,
    required this.sourceTransactionId,
    required this.createdAt,
  });

  String id;
  String status;
  int amount;
  String currencyCode;
  String destinationPhoneNumber;
  String destinationEwalletId;
  String destinationTransactionId;
  String sourceEwalletId;
  String sourceTransactionId;
  int createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        amount: json["amount"],
        currencyCode: json["currency_code"],
        destinationPhoneNumber: json["destination_phone_number"],
        destinationEwalletId: json["destination_ewallet_id"],
        destinationTransactionId: json["destination_transaction_id"],
        sourceEwalletId: json["source_ewallet_id"],
        sourceTransactionId: json["source_transaction_id"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "amount": amount,
        "currency_code": currencyCode,
        "destination_phone_number": destinationPhoneNumber,
        "destination_ewallet_id": destinationEwalletId,
        "destination_transaction_id": destinationTransactionId,
        "source_ewallet_id": sourceEwalletId,
        "source_transaction_id": sourceTransactionId,
        "created_at": createdAt,
      };
}

class Status {
  Status({
    required this.status,
    required this.operationId,
  });

  String status;
  String operationId;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        status: json["status"],
        operationId: json["operation_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "operation_id": operationId,
      };
}
