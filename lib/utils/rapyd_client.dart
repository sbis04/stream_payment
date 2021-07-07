import 'dart:convert';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:stream_payment/models/transfer.dart';
import 'package:stream_payment/models/wallet.dart';

import '../secrets.dart';

class RapydClient {
  final _baseURL = 'https://sandboxapi.rapyd.net';
  final _accessKey = RAPYD_ACCESS_KEY;
  final _secretKey = RAPYD_SECRET_KEY;

  String _generateSalt() {
    final _random = Random.secure();
    // Generate 16 characters for salt by generating 16 random bytes
    // and encoding it.
    final randomBytes = List<int>.generate(16, (index) => _random.nextInt(256));
    return base64UrlEncode(randomBytes);
  }

  Map<String, String> _generateHeader({
    required String method,
    required String endpoint,
    String body = '',
  }) {
    int unixTimetamp = DateTime.now().millisecondsSinceEpoch;
    String timestamp = (unixTimetamp / 1000).round().toString();

    var salt = _generateSalt();

    var toSign =
        method + endpoint + salt + timestamp + _accessKey + _secretKey + body;

    var keyEncoded = ascii.encode(_secretKey);
    var toSignEncoded = ascii.encode(toSign);

    var hmacSha256 = Hmac(sha256, keyEncoded); // HMAC-SHA256
    var digest = hmacSha256.convert(toSignEncoded);
    var ss = hex.encode(digest.bytes);
    var tt = ss.codeUnits;
    var signature = base64.encode(tt);

    var headers = {
      'Content-Type': 'application/json',
      'access_key': _accessKey,
      'salt': salt,
      'timestamp': timestamp,
      'signature': signature,
    };

    return headers;
  }

  Future<Wallet?> getWalletDetails({required String walletID}) async {
    Wallet? retrievedWallet;

    var method = "get";
    var walletEndpoint = '/v1/user/$walletID';

    final walletURL = Uri.parse(_baseURL + walletEndpoint);

    final headers = _generateHeader(
      method: method,
      endpoint: walletEndpoint,
    );

    try {
      var response = await http.get(walletURL, headers: headers);

      print(response.body);

      if (response.statusCode == 200) {
        print('Wallet retrieved successfully!');
        retrievedWallet = Wallet.fromJson(jsonDecode(response.body));
      }
    } catch (_) {
      print('Failed to retrieve wallet');
    }

    return retrievedWallet;
  }

  Future<Transfer?> transferMoney({
    required String sourceWallet,
    required String destinationWallet,
    required int amount,
  }) async {
    Transfer? transferDetails;

    var method = "post";
    var transferEndpoint = '/v1/account/transfer';

    final transferURL = Uri.parse(_baseURL + transferEndpoint);

    var data = jsonEncode({
      "source_ewallet": sourceWallet,
      "amount": amount,
      "currency": "USD",
      "destination_ewallet": destinationWallet,
    });

    final headers = _generateHeader(
      method: method,
      endpoint: transferEndpoint,
      body: data,
    );

    try {
      var response = await http.post(
        transferURL,
        headers: headers,
        body: data,
      );

      print(response.body);

      if (response.statusCode == 200) {
        print('SUCCESSFULLY TRANSFERED');
        transferDetails = Transfer.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Failed to transfer amount');
    }

    return transferDetails;
  }

  Future<Transfer?> transferResponse({
    required String id,
    required String response,
  }) async {
    Transfer? transferDetails;

    var method = "post";
    var responseEndpoint = '/v1/account/transfer/response';

    final responseURL = Uri.parse(_baseURL + responseEndpoint);

    var data = jsonEncode({
      "id": id,
      "status": response,
    });

    final headers = _generateHeader(
      method: method,
      endpoint: responseEndpoint,
      body: data,
    );

    try {
      var response = await http.post(
        responseURL,
        headers: headers,
        body: data,
      );

      print(response.body);

      if (response.statusCode == 200) {
        print('TRANSFER STATUS UPDATED: $response');
        transferDetails = Transfer.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Failed to update transfer status');
    }

    return transferDetails;
  }
}
