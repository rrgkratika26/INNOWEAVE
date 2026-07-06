// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import '../../Color/Colorclass.dart';
// import '../../services/DashboardApiServices.dart';
// import '../Dashboard Summary.dart';
// import 'dashBoardMapper.dart';
//
//
// // ─────────────────────────────────────────────
// //  MODEL — dept name + live count
// // ─────────────────────────────────────────────
// class DeptCountItem {
//   final String title;
//   final IconData icon;
//   final double value;
//   final Color color;
//
//   const DeptCountItem({
//     required this.title,
//     required this.icon,
//     required this.value,
//     required this.color,
//   });
// }
//
// // ─────────────────────────────────────────────
// //  TOP BAR WIDGET
// //  - Slides + fades in on mount
// //  - Below it, a continuously auto-scrolling
// //    ticker row of dept chips (Inquiry, Bom,
// //    Loom, Webbing, Work Order, etc.)
// // ─────────────────────────────────────────────
// class DashboardTopBarAnimated extends StatefulWidget {
//   final String unit;
//   final String fromDate;
//   final String toDate;
//
//   final VoidCallback? onMenuTap;
//   final VoidCallback? onProfileTap;
//
//   const DashboardTopBarAnimated({
//     super.key,
//     required this.unit,
//     required this.fromDate,
//     required this.toDate,
//     this.onMenuTap,
//     this.onProfileTap,
//   });
//
//   @override
//   State<DashboardTopBarAnimated> createState() =>
//       _DashboardTopBarAnimatedState();
// }
// class _DashboardTopBarAnimatedState extends State<DashboardTopBarAnimated>
//     with TickerProviderStateMixin {
//   // Entrance animation
//   late final AnimationController _entranceCtrl;
//   late final Animation<Offset> _slideAnim;
//   late final Animation<double> _fadeAnim;
//   int currentIndex = 0;
//   DashboardSummary? dashboardSummary;
//   List<DeptCountItem> deptCounts = [];
//   bool isLoading = true;
//
//   // Marquee / ticker scroll
//   final ScrollController _scrollCtrl = ScrollController();
//   Timer? _tickerTimer;
//   Timer? _refreshTimer;
//   double _scrollPos = 0;
//   static const double _scrollSpeed = 0.6; // px per tick
//   static const Duration _tickInterval = Duration(milliseconds: 16);
//
//   @override
//   void initState() {
//     super.initState();
//
//     _entranceCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _slideAnim = Tween<Offset>(
//       begin: const Offset(0, -0.3),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _entranceCtrl,
//         curve: Curves.easeOutCubic,
//       ),
//     );
//
//     _fadeAnim = CurvedAnimation(
//       parent: _entranceCtrl,
//       curve: Curves.easeIn,
//     );
//
//     _entranceCtrl.forward();
//
//     loadDashboard();
//
//     _refreshTimer = Timer.periodic(
//       const Duration(seconds: 30),
//           (_) => loadDashboard(),
//     );
//
//
//   }
//
//   void _startTicker() {
//     currentIndex = ((_scrollPos / 140).round()) % deptCounts.length;
//
//     if (mounted) {
//       setState(() {});
//     }
//     if (deptCounts.isEmpty) return;
//
//     _tickerTimer = Timer.periodic(_tickInterval, (_) {
//       if (!_scrollCtrl.hasClients) return;
//
//       final maxExtent = _scrollCtrl.position.maxScrollExtent;
//       if (maxExtent <= 0) return;
//
//       _scrollPos += _scrollSpeed;
//
//       // Seamless loop: once we've scrolled past the first copy of the
//       // list, snap back to 0 without animating (list is duplicated x2).
//       if (_scrollPos >= maxExtent / 2) {
//         _scrollPos = 0;
//       }
//
//       if (_scrollCtrl.hasClients) {
//         _scrollCtrl.jumpTo(
//           _scrollPos.clamp(
//             0.0,
//             _scrollCtrl.position.maxScrollExtent,
//           ),
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _tickerTimer?.cancel();
//     _refreshTimer?.cancel();
//     _scrollCtrl.dispose();
//     _entranceCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     final isMobile = mq.size.width < 600;
//
//     return SlideTransition(
//       position: _slideAnim,
//       child: FadeTransition(
//         opacity: _fadeAnim,
//         child: Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//
//               if (isLoading)
//                 const SizedBox(
//                   height: 60,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//               else
//                 _tickerRow(isMobile),
//               const SizedBox(height: 14),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   // ── Row 2: auto-scrolling dept ticker ────────
//   Widget _tickerRow(bool isMobile) {
//     if (isLoading) {
//       return const SizedBox(
//         height: 54,
//         child: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     if (deptCounts.isEmpty) {
//       return const SizedBox(
//         height: 54,
//         child: Center(
//           child: Text(
//             "No Data",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//     }
//
//     final doubled = [...deptCounts, ...deptCounts];
//
//     return SizedBox(
//       height: isMobile ? 54 : 62,
//       child: ListView.builder(
//         controller: _scrollCtrl,
//         scrollDirection: Axis.horizontal,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 28),
//         itemCount: doubled.length,
//
//         itemBuilder: (_, index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: _tickerChip(doubled[index], isMobile),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _tickerChip(DeptCountItem item, bool isMobile) {
//     final bool active = deptCounts[currentIndex].title == item.title;
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       transform: Matrix4.identity()..scale(active ? 1.08 : 1.0),
//       decoration: BoxDecoration(
//         color: active
//             ? item.color.withOpacity(.25)
//             : Colors.white.withOpacity(.12),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: active ? item.color : Colors.white24,
//           width: active ? 2 : 1,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(item.icon, color: C.textHigh, size: isMobile ? 16 : 18),
//           const SizedBox(width: 8),
//           Text(
//             item.title.toUpperCase(),
//             style: TextStyle(
//               color: C.textHigh,
//               fontWeight: FontWeight.w600,
//               fontSize: isMobile ? 12 : 13,
//               letterSpacing: .3,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//             decoration: BoxDecoration(
//               color: C.textHigh,
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Text(
//               '${item.value}',
//               style: TextStyle(
//                 color: item.color,
//                 fontWeight: FontWeight.bold,
//                 fontSize: isMobile ? 12 : 13,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future loadDashboard() async {
//     try {
//       dashboardSummary = await DashboardService().getDashboard(
//         unit: widget.unit,
//         fromDate: widget.fromDate,
//         toDate: widget.toDate,
//       );
//
//       deptCounts = createDepartments(dashboardSummary!);
//
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//
//         _tickerTimer?.cancel();
//
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _startTicker();
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
//



import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../Color/Colorclass.dart';
import '../../services/DashboardApiServices.dart';
import '../Dashboard Summary.dart';
import 'dashBoardMapper.dart';

// ─────────────────────────────────────────────
//  MODEL — dept name + MULTIPLE live metrics
// ─────────────────────────────────────────────
class MetricItem {
  final String label; // e.g. "Kg", "Mtr", "Total"
  final num value;

  const MetricItem(this.label, this.value);
}

class DeptCountItem {
  final String title;
  final IconData icon;
  final List<MetricItem> metrics; // 1..n values per dept
  final Color color;

  const DeptCountItem({
    required this.title,
    required this.icon,
    required this.metrics,
    required this.color,
  });
}

// ─────────────────────────────────────────────
//  TOP BAR WIDGET
// ─────────────────────────────────────────────
class DashboardTopBarAnimated extends StatefulWidget {
  final String unit;
  final String fromDate;
  final String toDate;

  final VoidCallback? onMenuTap;
  final VoidCallback? onProfileTap;

  const DashboardTopBarAnimated({
    super.key,
    required this.unit,
    required this.fromDate,
    required this.toDate,
    this.onMenuTap,
    this.onProfileTap,
  });

  @override
  State<DashboardTopBarAnimated> createState() =>
      _DashboardTopBarAnimatedState();
}

class _DashboardTopBarAnimatedState extends State<DashboardTopBarAnimated>
    with TickerProviderStateMixin {
  late final AnimationController _entranceCtrl;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  int currentIndex = 0;
  DashboardSummary? dashboardSummary;
  List<DeptCountItem> deptCounts = [];
  bool isLoading = true;

  final ScrollController _scrollCtrl = ScrollController();
  Timer? _tickerTimer;
  Timer? _refreshTimer;
  double _scrollPos = 0;
  static const double _scrollSpeed = 0.6;
  static const Duration _tickInterval = Duration(milliseconds: 16);

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));

    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeIn);

    _entranceCtrl.forward();

    loadDashboard();

    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) => loadDashboard());
  }

  void _startTicker() {
    if (deptCounts.isEmpty) return;

    currentIndex = ((_scrollPos / 170).round()) % deptCounts.length;
    if (mounted) setState(() {});

    _tickerTimer = Timer.periodic(_tickInterval, (_) {
      if (!_scrollCtrl.hasClients) return;

      final maxExtent = _scrollCtrl.position.maxScrollExtent;
      if (maxExtent <= 0) return;

      _scrollPos += _scrollSpeed;
      if (_scrollPos >= maxExtent / 2) _scrollPos = 0;

      if (_scrollCtrl.hasClients) {
        _scrollCtrl.jumpTo(_scrollPos.clamp(0.0, _scrollCtrl.position.maxScrollExtent));
      }
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    _refreshTimer?.cancel();
    _scrollCtrl.dispose();
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isMobile = mq.size.width < 600;

    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isLoading
                  ? const SizedBox(
                height: 90,
                child: Center(child: CircularProgressIndicator()),
              )
                  : _tickerRow(isMobile),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tickerRow(bool isMobile) {
    if (deptCounts.isEmpty) {
      return const SizedBox(
        height: 86,
        child: Center(
          child: Text("No Data", style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    final doubled = [...deptCounts, ...deptCounts];

    return SizedBox(
      height: isMobile ? 86 : 96,
      child: ListView.builder(
        controller: _scrollCtrl,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 28),
        itemCount: doubled.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _tickerCard(doubled[index], isMobile),
          );
        },
      ),
    );
  }

  // ── Redesigned card: glassmorphism + multi-metric row ──
  Widget _tickerCard(DeptCountItem item, bool isMobile) {
    final bool active = deptCounts[currentIndex].title == item.title;

    return AnimatedContainer(
      duration: const Duration(milliseconds:500),
      curve: Curves.bounceIn,
      transform: Matrix4.identity()..scale(active ? 1.05 : 1.0),
      child: IntrinsicWidth(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              constraints: BoxConstraints(minWidth: isMobile ? 150 : 170),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: active
                      ? [item.color.withOpacity(.35), item.color.withOpacity(.15)]
                      : [Colors.white.withOpacity(.10), Colors.white.withOpacity(.04)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active ? item.color.withOpacity(.9) : Colors.white24,
                  width: active ? 1.6 : 1,
                ),
                boxShadow: active
                    ? [
                  BoxShadow(
                    color: item.color.withOpacity(.35),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ]
                    : [],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: icon + title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: item.color.withOpacity(.25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(item.icon, color: C.textHigh, size: isMobile ? 13 : 14),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.title.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: C.textHigh,
                            fontWeight: FontWeight.w700,
                            fontSize: isMobile ? 11 : 12,
                            letterSpacing: .4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // All metric values from API response
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < item.metrics.length; i++) ...[
                        if (i > 0) const SizedBox(width: 14),
                        _metricPill(item.metrics[i], item.color, isMobile),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _metricPill(MetricItem m, Color color, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _fmt(m.value),
              style: TextStyle(
                color: C.textHigh,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 13 : 14,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              m.label,
              style: TextStyle(
                color: C.textHigh.withOpacity(.7),
                fontSize: isMobile ? 9 : 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(num v) {
    if (v == v.roundToDouble()) return v.toInt().toString();
    return v.toStringAsFixed(2);
  }

  Future loadDashboard() async {
    try {
      dashboardSummary = await DashboardService().getDashboard(
        unit: widget.unit,
        fromDate: widget.fromDate,
        toDate: widget.toDate,
      );

      deptCounts = createDepartments(dashboardSummary!);

      if (mounted) {
        setState(() {
          isLoading = false;
        });

        _tickerTimer?.cancel();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startTicker();
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}