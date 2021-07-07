import 'package:flutter/material.dart';

import 'package:stream_payment/res/pallet.dart';

class TransactionPage extends StatelessWidget {
  final String destinationWalletAddress;

  TransactionPage({required this.destinationWalletAddress});

  final TextEditingController _amountTextController = TextEditingController();

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Pallet.streamBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sending To',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          destinationWalletAddress,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 150,
                    child: TextField(
                      // textAlign: TextAlign.center,
                      controller: _amountTextController,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            '\$',
                            style: TextStyle(fontSize: 40.0),
                          ),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 80.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Pallet.streamBlue),
                      onPressed: () {
                        if (_amountTextController.text != '') {
                          Navigator.pop(context, _amountTextController.text);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Pay',
                          style: TextStyle(color: Colors.white, fontSize: 24.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
