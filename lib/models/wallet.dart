class Wallet {
  Wallet({
    required this.status,
    required this.data,
  });

  Status status;
  Data data;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
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
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.status,
    required this.accounts,
  });

  String phoneNumber;
  String email;
  dynamic firstName;
  String lastName;
  String id;
  String status;
  List<Account> accounts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phoneNumber: json["phone_number"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        id: json["id"],
        status: json["status"],
        accounts: List<Account>.from(
            json["accounts"].map((x) => Account.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "id": id,
        "status": status,
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
      };
}

class Account {
  Account({
    required this.id,
    required this.currency,
    required this.balance,
  });

  String id;
  String currency;
  int balance;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        currency: json["currency"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "balance": balance,
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
