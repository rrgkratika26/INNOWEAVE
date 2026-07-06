import 'dart:convert';
import 'package:IMS/services/getSupervisors/getSupervisors.dart';
import 'package:http/http.dart' as http;

import '../AdminDashBoard/Dashboard Summary.dart';

class DashboardService {
  double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return double.tryParse(value.toString()) ?? 0.0;
  }

  Future<DashboardSummary> getDashboard({
    required String unit,
    required String fromDate,
    required String toDate,
  }) async {

    Future<Map<String, dynamic>> get(String api) async {
      final url = Uri.parse(
          "${InStockService.baseUrl}/Dashboard/$api?unit=$unit&fromDate=$fromDate&toDate=$toDate");

      print("========== API ==========");
      print("URL : $url");

      final response = await http.get(url);

      print("STATUS : ${response.statusCode}");
      print("RESPONSE : ${response.body}");
      print("=========================");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      throw Exception(response.body);
    }

    final result = await Future.wait([
      get("planning"),
      get("cutting"),
      get("cutpcs"),
      get("totalbagproduction"),
      get("bailing"),
      get("tapeline"),
    ]);

    return DashboardSummary.fromJson(
      planningJson: result[0],
      cuttingJson: result[1],
      cutPcsJson: result[2],
      bagJson: result[3],
      bailingJson: result[4],
      tapeJson: result[5],
    );
  }
}




