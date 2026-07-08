import 'package:flutter/material.dart';

import '../../InquiryScreen/Marketing/MarketingModel.dart';
import '../../services/DashboardApiServices.dart';
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
      title: "WEBBING",
      icon: Icons.check_box,
      color: Colors.green,
      metrics: [

        MetricItem("Total WT", d.totalNetWt),
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
      title: "Bailing",
      icon: Icons.login,
      color: Colors.indigo,
      metrics: [
        MetricItem("Count", d.inCount),
        MetricItem("Net Wt", d.inBagNwt),
      ],
    ),

    DeptCountItem(
      title: "Bailing",
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
    DeptCountItem(
      title: "INQUIRY",

      icon: Icons.query_stats,
      color: Colors.yellow.shade600,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],  // ← inquiry count only
    ),
    DeptCountItem(
      title: "Quotation",

      icon: Icons.request_quote,
      color: Colors.teal.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Work Order",

      icon: Icons.assignment,
      color: Colors.blueGrey.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "BOM",

      icon: Icons.assignment,
      color: Colors.blueGrey.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Planning",

      icon: Icons.calendar_month,
      color: Colors.purple.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Quality",

      icon: Icons.verified,
      color: Colors.green.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),

    /// ── Show Metrics (netWeight, rollLength, noOfRoll) ──
    DeptCountItem(
      title: "RMD",

      icon: Icons.settings,
      color: Colors.indigo.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],  // ← shows KG / MTR / Rolls
    ),
    DeptCountItem(
      title: "Lamination",

      icon: Icons.layers,
      color: Colors.orange.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Cutting",

      icon: Icons.content_cut,
      color: Colors.green.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Webbing",

      icon: Icons.account_tree,
      color: Colors.deepOrange.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Loom",

      icon: Icons.factory,
      color: Colors.pink.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Bag Production",

      icon: Icons.shopping_bag,
      color: Colors.lightGreen.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Baling",

      icon: Icons.inventory_2,
      color: Colors.redAccent.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Tape Line",

      icon: Icons.straighten,
      color: Colors.amber.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    DeptCountItem(
      title: "Cut Piece",

      icon: Icons.crop_square,
      color: Colors.cyan.shade200,
      metrics: [
        MetricItem("Prod", d.totalBagProduction),
        MetricItem("Net Wt", d.totalNetWt),
        MetricItem("Out", d.totalBagOut),
      ],
    ),
    
  ];
}


