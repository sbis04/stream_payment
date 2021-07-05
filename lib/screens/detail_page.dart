import 'package:flutter/material.dart';

import 'package:stream_payment/models/transfer.dart';

class DetailPage extends StatelessWidget {
  final Transfer transaction;

  const DetailPage({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text(
                    'Transaction details',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sender wallet ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(transaction.data.sourceEwalletId),
                  SizedBox(height: 16),
                  Text(
                    'Receiver wallet ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(transaction.data.destinationEwalletId),
                  SizedBox(height: 16),
                  Text(
                    'Operation ID',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(transaction.data.id),
                  SizedBox(height: 16),
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                      '${transaction.data.amount} ${transaction.data.currencyCode}'),
                  SizedBox(height: 16),
                  Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    transaction.data.status == 'PEN'
                        ? 'Pending'
                        : transaction.data.status == 'DEC'
                            ? 'Declined'
                            : 'Completed',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
