import 'package:final_year_project/adaptive_and_responsive/adaptive.dart';
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
                  return orderTable(context, data);
                } else {
                  return Text('No Order Made');
                }
              })
        ],
      ),
    );
  }
}

Widget orderTable(context, data) {
  return Container(
    margin: Adaptive.isMobile(context)
        ? EdgeInsets.symmetric(horizontal: 10)
        : EdgeInsets.symmetric(horizontal: 200),
    child: Table(
      defaultColumnWidth: FixedColumnWidth(100),
      columnWidths: {0: FlexColumnWidth(0.2), 2: FlexColumnWidth(0.7)},
      border: TableBorder.all(color: Colors.grey, width: 2.0),
      children: [
        TableRow(children: [
          Center(
              child: Text(
            '',
          )),
          Center(child: Text('product', style: Constants.regularPrimaryText)),
          Center(child: Text('quantity', style: Constants.regularPrimaryText)),
          Center(child: Text('total', style: Constants.regularPrimaryText)),
          Center(
              child: Text('ordered at', style: Constants.regularPrimaryText)),
        ]),
        for (int i = 0; i < data.length; i++)
          TableRow(children: [
            Center(
                child: Text(
              i.toString(),
              style: Constants.regularDarkText,
            )),
            Center(
                child: Text(data[i]['productName'],
                    style: Constants.regularDarkText)),
            Center(
                child: Text(data[i]['quantity'].toString(),
                    style: Constants.regularDarkText)),
            Center(
                child: Text((data[i]['price'] * data[i]['quantity']).toString(),
                    style: Constants.regularDarkText)),
            Center(
                child: Text(data[i]['orderTime'].toString(),
                    style: Constants.regularDarkText)),
          ])
      ],
    ),
  );
}
