import 'package:final_year_project/firebase_services/order.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Your Order',
            style: Constants.headingPrimaryText,
          ),
          SizedBox(
            height: 40,
          ),
          FutureBuilder(
              future: OrderService().getOrderItem(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data;
                  return getCard(data);
                } else {
                  return Text('No Order Made');
                }
              })
        ],
      ),
    );
  }
}

Widget getCard(data) {
  return FittedBox(
    fit: BoxFit.cover,
    child: DataTable(columns: [
      DataColumn(
          label: Text(
        'Product',
        style: Constants.regularPrimaryText,
      )),
      DataColumn(
          label: Text(
        'Quantity',
        style: Constants.regularPrimaryText,
      )),
      DataColumn(
          label: Text(
        'Price',
        style: Constants.regularPrimaryText,
      )),
      DataColumn(
          label: Text(
        'Total',
        style: Constants.regularPrimaryText,
      )),
      DataColumn(
          label: Text(
        'Order At',
        style: Constants.regularPrimaryText,
      )),
    ], rows: [
      for (int i = 0; i < data.length; i++)
        DataRow(cells: [
          DataCell(Text(data[i]['productName'])),
          DataCell(Text(data[i]['quantity'].toString())),
          DataCell(Text(data[i]['price'].toString())),
          DataCell(Text((data[i]['price'] * data[i]['quantity']).toString())),
          DataCell(Text(data[i]['orderTime'].toString())),
        ])
    ]),
  );
}
