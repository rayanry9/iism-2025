import 'package:flutter/material.dart';
import 'package:iism_2025/screens/logindetails.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RequestOutingScreen extends StatefulWidget {
  const RequestOutingScreen({super.key});

  @override
  State<RequestOutingScreen> createState() => _RequestOutingScreenState();
}

class _RequestOutingScreenState extends State<RequestOutingScreen> {
  TimeOfDay _parseTime(String value) {
    final parts = value.split(" ");
    final hm = parts[0].split(":");

    int hour = int.parse(hm[0]);
    int minute = int.parse(hm[1]);
    String period = parts[1];

    if (period == "PM" && hour != 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> submitOutingRequest() async {
    if (reasonController.text.isEmpty ||
        selectedExitTime == null ||
        selectedEntryTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    try {
      TimeOfDay exitTOD = _parseTime(selectedExitTime!);
      TimeOfDay entryTOD = _parseTime(selectedEntryTime!);

      DateTime now = DateTime.now();

      String _formatRFC3339(DateTime dt) {
        dt = dt.toLocal();

        final offset = dt.timeZoneOffset;
        final hours = offset.inHours.abs().toString().padLeft(2, '0');
        final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
        final sign = offset.isNegative ? '-' : '+';

        final offsetString = "$sign$hours:$minutes";

        final y = dt.year.toString().padLeft(4, '0');
        final m = dt.month.toString().padLeft(2, '0');
        final d = dt.day.toString().padLeft(2, '0');
        final h = dt.hour.toString().padLeft(2, '0');
        final min = dt.minute.toString().padLeft(2, '0');
        final s = dt.second.toString().padLeft(2, '0');

        return "${y}-${m}-${d}T${h}:${min}:${s}${offsetString}";
      }

      DateTime exitTime = DateTime(now.year, now.month, now.day, exitTOD.hour, exitTOD.minute);
      DateTime entryTime = DateTime(now.year, now.month, now.day, entryTOD.hour, entryTOD.minute);

      final formattedExit = _formatRFC3339(exitTime);
      final formattedEntry = _formatRFC3339(entryTime);

      String apiUrl = dotenv.env['API_URL']!;
      final response = await dio.post(
        apiUrl + "/api/outing/create",
        data: {
          "reason": reasonController.text,
          "exitTime": formattedExit,
          "entryTime": formattedEntry,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Outing request submitted successfully")),
        );
        setState(() => showNewRequest = false);
      }
    } catch (e) {
      print("Outing error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send request")),
      );
    }
  }

  bool showNewRequest = true;

  final TextEditingController reasonController = TextEditingController();
  String? selectedExitTime;
  String? selectedEntryTime;

  late final List<String> timeSlots = _generateTimeSlots();

  List<Map<String, dynamic>> pastRequests = [];

  Future<void> loadMyPastOutings() async {
    try {
      String apiUrl = dotenv.env['API_URL']!;
      final response = await dio.get(apiUrl + "/api/outing/mine");

      if (response.statusCode == 200) {
        final data = List<Map<String, dynamic>>.from(response.data);

        pastRequests = data.map((o) {
          final exit = DateTime.parse(o["exitTime"]);
          final entry = DateTime.parse(o["entryTime"]);
          final created = DateTime.parse(o["createdAt"]);

          return {
            "date": "${created.day} ${_monthName(created.month)}",
            "title": "${o["reason"]} (${_formatTileTime(created)})",
            "exit": _formatTileTime(exit),
            "entry": _formatTileTime(entry),
            "status": o["status"],
          };
        }).toList();

        setState(() {});
      }
    } catch (e) {
      print("Error loading outings: $e");
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
      "December"
    ];
    return months[m];
  }

  String _formatTileTime(DateTime dt) {
    final t = TimeOfDay.fromDateTime(dt);
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
              const SizedBox(height: 20),
              _buildTabs(),
              const SizedBox(height: 20),

              Expanded(
                child: showNewRequest
                    ? _buildNewRequestForm()
                    : _buildPastRequests(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // NEW TABS (MATCH ApproveRequestScreen)
  // ----------------------------------------------------------
  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xffD9D9D9), width: 1),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          _tabButton("NEW REQUEST", showNewRequest, true),
          _tabButton("PAST REQUESTS", !showNewRequest, false),
        ],
      ),
    );
  }

  Widget _tabButton(String text, bool selected, bool isLeft) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => showNewRequest = isLeft);
          if (!isLeft) loadMyPastOutings();
        },
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

  // -------------------------------------------------
  // NEW REQUEST FORM (UNCHANGED)
  // -------------------------------------------------
  Widget _buildNewRequestForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Request campus outing approval here.",
              style: TextStyle(color: Colors.black54)),
          const SizedBox(height: 20),
          _textInput("Reason For Outing", reasonController),
          const SizedBox(height: 20),
          _dropdownTime("Select Exit Time", selectedExitTime, (val) {
            setState(() => selectedExitTime = val);
          }),
          const SizedBox(height: 20),
          _dropdownTime("Select Expected Entry Time", selectedEntryTime, (val) {
            setState(() => selectedEntryTime = val);
          }),
          const SizedBox(height: 30),
          Center(
            child: Transform(
              transform: Matrix4.skewX(-0.2),   // button skew
              child: ElevatedButton(
                onPressed: () {
                  print("Reason: ${reasonController.text}");
                  print("Exit: $selectedExitTime");
                  print("Entry: $selectedEntryTime");
                  submitOutingRequest();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF227B80),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: Transform(
                  transform: Matrix4.skewX(0.2),  // opposite direction to straighten text visually
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Text(
                        "SUBMIT FOR APPROVAL",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Transform.translate(
                        offset:  Offset(0, -2), // (x, y) → adjust manually
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _textInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 2,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "Enter here",
          ),
        ),
      ],
    );
  }

  Widget _dropdownTime(String label, String? selected, Function(String?) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: selected,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: const Text("Select time"),
            items: timeSlots
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: onChange,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------
  // NEW PAST REQUEST TILE (MATCH ApproveRequestScreen)
  // -------------------------------------------------
  Widget _buildPastRequests() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: pastRequests.length,
      itemBuilder: (ctx, i) => _pastTile(pastRequests[i]),
    );
  }

  Widget _pastTile(Map<String, dynamic> req) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(req["date"],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(req["title"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      const SizedBox(height: 6),
                      Text("Exit Time – ${req["exit"]}"),
                      Text("Entry Time – ${req["entry"]}"),
                    ],
                  ),
                ),
                Icon(
                  req["status"] == 1
                      ? Icons.check_circle
                      : req["status"] == 2
                          ? Icons.cancel
                          : Icons.remove, // dash for pending
                  color: req["status"] == 1
                      ? Colors.green
                      : req["status"] == 2
                          ? Colors.red
                          : Colors.grey, // grey for dash
                  size: 26,
                )
              ],
            ),
          ),
          const Divider(height: 2, color: Color(0xffD9D9D9)),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // TIME SLOTS
  // -------------------------------------------------
  List<String> _generateTimeSlots() {
    List<String> slots = [];

    for (int h = 0; h < 24; h++) {
      for (int m = 0; m < 60; m += 30) {
        final t = TimeOfDay(hour: h, minute: m);
        slots.add(_formatTime(t));
      }
    }

    return slots;
  }

  String _formatTime(TimeOfDay t) {
    final hour = (t.hour % 12 == 0) ? 12 : t.hour % 12;
    final min = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$min $period";
  }
}
