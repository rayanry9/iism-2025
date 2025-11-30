import 'package:flutter/material.dart';

class RequestOutingScreen extends StatefulWidget {
  const RequestOutingScreen({super.key});

  @override
  State<RequestOutingScreen> createState() => _RequestOutingScreenState();
}

class _RequestOutingScreenState extends State<RequestOutingScreen> {
  bool showNewRequest = true;

  // FORM DATA
  final TextEditingController reasonController = TextEditingController();
  String? selectedExitTime;
  String? selectedEntryTime;

  // 30-minute time list
  late final List<String> timeSlots = _generateTimeSlots();

  // Dummy history
  final List<Map<String, dynamic>> pastRequests = [
    {
      "date": "14 December",
      "title": "Going out Secunderabad (9 AM)",
      "exit": "11:30 AM",
      "entry": "3:00 PM",
      "approved": true,
    },
    {
      "date": "13 December",
      "title": "Going out Secunderabad (8:30 AM)",
      "exit": "11:30 AM",
      "entry": "3:00 PM",
      "approved": false,
    }
  ];

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
              // _buildHeader(),
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

  
  Widget _buildTabs() {
    return Row(
      children: [
        _tab("NEW REQUEST", showNewRequest, () {
          setState(() => showNewRequest = true);
        }),
        _tab("PAST REQUESTS", !showNewRequest, () {
          setState(() => showNewRequest = false);
        }),
      ],
    );
  }

  Widget _tab(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.grey[200],
            border: Border.all(
                color: active ? const Color(0xFF0A6C70) : Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active ? const Color(0xFF0A6C70) : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------
                NEW REQUEST FORM
  --------------------------------------------------*/
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
            child: ElevatedButton(
              onPressed: () {
                print("Reason: ${reasonController.text}");
                print("Exit: $selectedExitTime");
                print("Entry: $selectedEntryTime");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(0xFF227B80),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
              ),
              child: const Text(
                "SUBMIT FOR APPROVAL",
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* -------------------------------------------------
                INPUT WIDGETS
  --------------------------------------------------*/
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

  // 30-minute interval dropdown
  Widget _dropdownTime(
      String label, String? selected, Function(String?) onChange) {
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

  /* -------------------------------------------------
                PAST REQUESTS
  --------------------------------------------------*/
  Widget _buildPastRequests() {
    return ListView.builder(
      itemCount: pastRequests.length,
      itemBuilder: (ctx, i) => _pastTile(pastRequests[i]),
    );
  }

  Widget _pastTile(Map<String, dynamic> req) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(req["date"],
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
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
                  req["approved"] ? Icons.check_circle : Icons.cancel,
                  color: req["approved"] ? Colors.green : Colors.red,
                  size: 26,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /* -------------------------------------------------
                TIME SLOT GENERATION (30 mins)
  --------------------------------------------------*/
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
