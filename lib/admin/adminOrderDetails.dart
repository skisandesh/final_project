import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (ctx, dynamic snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return Text('Nothing ordered');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return FittedBox(
              fit: BoxFit.cover,
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                    'email',
                    style: Constants.regularPrimaryText,
                  )),
                  DataColumn(
                      label: Text(
                    'product',
                    style: Constants.regularPrimaryText,
                  )),
                  DataColumn(
                      label: Text(
                    'quantity',
                    style: Constants.regularPrimaryText,
                  )),
                  DataColumn(
                      label: Text(
                    'Total',
                    style: Constants.regularPrimaryText,
                  )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                        FirebaseFirestore.instance.collection('orders').id)),
                    DataCell(Text('aa')),
                    DataCell(Text('aa')),
                    DataCell(Text('aa')),
                  ])
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
