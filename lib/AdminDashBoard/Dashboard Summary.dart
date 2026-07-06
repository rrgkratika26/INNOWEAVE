class DashboardSummary {
  final double planning;

  final double cutKg;
  final double cutMtr;
  final double cutTotal;

  final double cutPieceKg;
  final double cutPieceTotal;

  final double totalBagProduction;
  final double totalNetWt;
  final double totalBagOut;

  final double inBagNwt;
  final double inCount;
  final double outBagNwt;
  final double outCount;

  final double tapeLineKg;

  DashboardSummary({
    required this.planning,
    required this.cutKg,
    required this.cutMtr,
    required this.cutTotal,
    required this.cutPieceKg,
    required this.cutPieceTotal,
    required this.totalBagProduction,
    required this.totalNetWt,
    required this.totalBagOut,
    required this.inBagNwt,
    required this.inCount,
    required this.outBagNwt,
    required this.outCount,
    required this.tapeLineKg,
  });

  static double toDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is int) return value.toDouble();

    if (value is double) return value;

    return double.tryParse(value.toString()) ?? 0.0;
  }

  factory DashboardSummary.fromJson({
    required Map<String, dynamic> planningJson,
    required Map<String, dynamic> cuttingJson,
    required Map<String, dynamic> cutPcsJson,
    required Map<String, dynamic> bagJson,
    required Map<String, dynamic> bailingJson,
    required Map<String, dynamic> tapeJson,
  }) {
    return DashboardSummary(
      planning: toDouble(planningJson["planning"]),

      cutKg: toDouble(cuttingJson["cutKg"]),
      cutMtr: toDouble(cuttingJson["cutMtr"]),
      cutTotal: toDouble(cuttingJson["cutTotal"]),

      cutPieceKg: toDouble(cutPcsJson["cutPieceKg"]),
      cutPieceTotal: toDouble(cutPcsJson["cutPieceTotal"]),

      totalBagProduction: toDouble(bagJson["totalBagProduction"]),
      totalNetWt: toDouble(bagJson["totalNetWt"]),
      totalBagOut: toDouble(bagJson["totalBagOut"]),

      inBagNwt: toDouble(bailingJson["inBagNwt"]),
      inCount: toDouble(bailingJson["inCount"]),
      outBagNwt: toDouble(bailingJson["outBagNwt"]),
      outCount: toDouble(bailingJson["outCount"]),

      tapeLineKg: toDouble(tapeJson["tapeLineKg"]),
    );
  }
}