import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/services/api_service.dart';

class ApproveRequestScreen extends StatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  State<ApproveRequestScreen> createState() => _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends State<ApproveRequestScreen> {
  bool showApproveTab = true;

  List<Map<String, dynamic>> pending = [];

  List<Map<String, dynamic>> history = [];

  Map<String, dynamic>? lastDeniedItem;

  @override
  void initState() {
    super.initState();
    _loadAllOutings();
  }

  Future<void> _approveOuting(int id) async {
    try {
      String apiUrl = dotenv.env['API_URL']!;
      await dio.post(apiUrl + "/api/outing/approve", data: {"outingId": id});
      _loadAllOutings(); // refresh lists
    } catch (e) {
      print("Approve error: $e");
    }
  }

  Future<void> _denyOuting(int id) async {
    try {
      String apiUrl = dotenv.env['API_URL']!;
      await dio.post(apiUrl + "/api/outing/deny", data: {"outingId": id});
      _loadAllOutings(); // refresh lists
    } catch (e) {
      print("Deny error: $e");
    }
  }

  Future<void> _loadAllOutings() async {
    try {
      String apiUrl = dotenv.env['API_URL']!;
      final response = await dio.get(apiUrl + "/api/outing/all");

      if (response.statusCode == 200) {
        final List<dynamic> raw = response.data;
        final List<Map<String, dynamic>> newPending = [];
        final List<Map<String, dynamic>> allHistoryItems = [];

        for (final item in raw) {
          final map = Map<String, dynamic>.from(item as Map);
          final int status = map["status"] ?? 0;

          final DateTime createdAt = DateTime.parse(map["createdAt"]);
          final DateTime entryTime = DateTime.parse(map["entryTime"]);
          final DateTime exitTime = DateTime.parse(map["exitTime"]);

          final String name =
              "${map["firstName"] ?? ""} ${map["lastName"] ?? ""}".trim();
          final String reason = map["reason"] ?? "";
          final int outingId = map["outingId"];

          final String createdTimeLabel = _formatTime(
            TimeOfDay.fromDateTime(createdAt),
          );
          final String entryLabel = _formatTime(
            TimeOfDay.fromDateTime(entryTime),
          );
          final String exitLabel = _formatTime(
            TimeOfDay.fromDateTime(exitTime),
          );

          if (status == 0) {
            newPending.add({
              "outingId": outingId,
              "name": name,
              "title": reason,
              "exit": exitLabel,
              "entry": entryLabel,
              "time": createdTimeLabel,
            });
          } else {
            final String dateLabel = _dateLabel(createdAt);
            allHistoryItems.add({
              "outingId": outingId,
              "date": dateLabel,
              "name": name,
              "title": "$reason ($createdTimeLabel)",
              "exit": exitLabel,
              "entry": entryLabel,
              "approved": status == 1,
            });
          }
        }

        final Map<String, List<Map<String, dynamic>>> grouped = {};
        for (final item in allHistoryItems) {
          final String date = item["date"];
          grouped.putIfAbsent(date, () => []);
          grouped[date]!.add({
            "outingId": item["outingId"],
            "name": item["name"],
            "title": item["title"],
            "exit": item["exit"],
            "entry": item["entry"],
            "approved": item["approved"],
          });
        }

        final List<Map<String, dynamic>> newHistory = [];
        grouped.forEach((date, list) {
          newHistory.add({"date": date, "list": list});
        });

        setState(() {
          pending = newPending;
          history = newHistory;
        });
      }
    } catch (e) {
      print("Error loading outings (all): $e");
    }
  }

  String _monthName(int m) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[m];
  }

  String _dateLabel(DateTime d) {
    return "${d.day} ${_monthName(d.month)}";
  }

  String _formatTime(TimeOfDay t) {
    final hour = (t.hour % 12 == 0) ? 12 : t.hour % 12;
    final min = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$min $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tabs(),
              const SizedBox(height: 12),
              Center(
                child: showApproveTab
                    ? const Text(
                        "Approve the Outing Requests here.",
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      )
                    : const SizedBox(width: 0),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xffD9D9D9)),
              showApproveTab
                  ? const SizedBox(height: 0)
                  : const SizedBox(height: 12),
              Expanded(
                child: showApproveTab
                    ? _buildApproveList()
                    : _buildPastRequests(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xffD9D9D9), width: 1),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          _tabButton("APPROVE REQUEST", showApproveTab, true),
          _tabButton("PAST REQUESTS", !showApproveTab, false),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool selected, bool isLeft) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => showApproveTab = isLeft),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: selected
              ? BoxDecoration(
                  color: const Color(0xFFE2F3F4),
                  borderRadius: BorderRadius.circular(20),
                )
              : null,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? const Color(0xFF2E7E81) : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApproveList() {
    return ListView.separated(
      itemCount: pending.length + 1,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, color: Color(0xffD9D9D9)),
      itemBuilder: (context, index) {
        if (index == pending.length) {
          return const Divider(height: 0, color: Color(0xffD9D9D9));
        }
        return _pendingTile(pending[index], index);
      },
    );
  }

  Widget _approveDenyButtons({
    required VoidCallback onApprove,
    required VoidCallback onDeny,
  }) {
    const leftRight = BorderRadius.horizontal(
      left: Radius.circular(30),
      right: Radius.circular(30),
    );
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: leftRight,
        border: Border.all(color: Color(0xffD9D9D9), width: 1),
      ),
      child: Column(
        children: [
          Container(
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFC8FFC8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onApprove,
              child: const Center(
                child: Text(
                  "APPROVE",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF006400),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            decoration: BoxDecoration(
              color: Color(0xFFFFD6D6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onDeny,
              child: const Center(
                child: Text(
                  "DENY",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pendingTile(Map<String, dynamic> req, int index) {
    final int id = req["outingId"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  req["time"],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C7A89),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  req["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(req["title"], style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text("Exit Time -"),
                        Text("${req["exit"]}"),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        const Text("Entry Time -"),
                        Text("${req["entry"]}"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          _approveDenyButtons(
            onApprove: () => _approveOuting(id),
            onDeny: () => _denyOuting(id),
          ),
        ],
      ),
    );
  }

  Widget _buildPastRequests() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: history.length,
      itemBuilder: (context, i) => _historyBlock(history[i]),
    );
  }

  Widget _historyBlock(Map<String, dynamic> block) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block["date"],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ...block["list"].map(
            (e) => Column(
              children: [
                _pastTile(e),
                const Divider(height: 2, color: Color(0xffD9D9D9)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pastTile(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(item["title"]),
                const SizedBox(height: 4),
                Text("Exit Time – ${item["exit"]}"),
                Text("Entry Time – ${item["entry"]}"),
              ],
            ),
          ),
          Icon(
            item["approved"] ? Icons.check_circle : Icons.cancel,
            color: item["approved"] ? Colors.green : Colors.red,
            size: 26,
          ),
        ],
      ),
    );
  }
}
