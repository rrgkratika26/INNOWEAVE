import 'package:flutter/material.dart';

import '../Dashboard Summary.dart';
import 'DashboardTopBarAnimated.dart';

List<DeptCountItem> createDepartments(DashboardSummary d) {
  return [
    DeptCountItem(
      title: "Planning",
      icon: Icons.event_note,
      color: Colors.blue,
      metrics: [
        MetricItem("Count", d.planning),
      ],
    ),

    DeptCountItem(
      title: "Cutting",
      icon: Icons.content_cut,
      color: Colors.deepOrange,
      metrics: [
        MetricItem("Kg", d.cutKg),
        MetricItem("Mtr", d.cutMtr),
        MetricItem("Total", d.cutTotal),
      ],
    ),

    DeptCountItem(
      title: "Cut Piece",
      icon: Icons.check_box,
      color: Colors.green,
      metrics: [
        MetricItem("Kg", d.cutPieceKg),
        MetricItem("Total", d.cutPieceTotal),
      ],
    ),

    DeptCountItem(
      title: "Bag Production",
      icon: Icons.shopping_bag,
      color: Colors.blue,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),

    DeptCountItem(
      title: "Bailing In",
      icon: Icons.login,
      color: Colors.indigo,
      metrics: [
        MetricItem("Count", d.inCount),
        MetricItem("Net Wt", d.inBagNwt),
      ],
    ),

    DeptCountItem(
      title: "Bailing Out",
      icon: Icons.logout,
      color: Colors.red,
      metrics: [
        MetricItem("Count", d.outCount),
        MetricItem("Net Wt", d.outBagNwt),
      ],
    ),

    DeptCountItem(
      title: "Tape Line",
      icon: Icons.straighten,
      color: Colors.cyan,
      metrics: [
        MetricItem("Kg", d.tapeLineKg),
      ],
    ),
  ];
}