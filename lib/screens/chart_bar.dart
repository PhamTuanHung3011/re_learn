import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String label;
  late final double spendingAmount;
  late final double spendingPctOfTotal;

  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contraint) {
      return Column(
        children: <Widget>[
          Container(
              height: contraint.maxHeight * 0.1,
              child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: contraint.maxHeight * 0.05,
          ),
          Container(
            height: contraint.maxHeight * 0.6,
            width: 10.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                          style: BorderStyle.solid),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Container(
              height: contraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
