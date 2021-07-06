import 'package:flutter/material.dart';

class TransactionAttachment extends StatelessWidget {
  final int amount;

  const TransactionAttachment({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF4161ff),
      width: double.maxFinite,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payment,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(width: 8),
          Column(
            children: [
              Text(
                '$amount USD',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
