import 'package:flutter/material.dart';

class ApproveRequestScreen extends StatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  State<ApproveRequestScreen> createState() => _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends State<ApproveRequestScreen> {
  bool showApproveTab = true;

  // Dummy live pending requests
  List<Map<String, dynamic>> pending = [
    {
      "name": "Rohit Sharma",
      "title": "Going out Secunderabad",
      "exit": "11:30 AM",
      "entry": "3:00 PM",
      "time": "Today 8:30 AM"
    },
    {
      "name": "Virat Kohli",
      "title": "Going out for Hyderabad…",
      "exit": "11:30 AM",
      "entry": "3:00 PM",
      "time": "Today 8:30 AM"
    },
    {
      "name": "Rohit Sharma",
      "title": "Going out Secunderabad",
      "exit": "11:30 AM",
      "entry": "3:00 PM",
      "time": "Today 8:30 AM"
    },
  ];

  // Past requests history
  final List<Map<String, dynamic>> history = [
    {
      "date": "14 December",
      "list": [
        {
          "name": "Rohit Sharma",
          "title": "Going out Secunderabad (8:30 AM)",
          "exit": "11:30 AM",
          "entry": "3:00 PM",
          "approved": true
        },
        {
          "name": "Virat Kohli",
          "title": "Going out Secunderabad (8:30 AM)",
          "exit": "11:30 AM",
          "entry": "3:00 PM",
          "approved": true
        }
      ]
    },
    {
      "date": "13 December",
      "list": [
        {
          "name": "Rohit Sharma",
          "title": "Going out Secunderabad (8:30 AM)",
          "exit": "11:30 AM",
          "entry": "3:00 PM",
          "approved": false
        },
        {
          "name": "Virat Kohli",
          "title": "Going out Secunderabad (8:30 AM)",
          "exit": "11:30 AM",
          "entry": "3:00 PM",
          "approved": true
        },
      ]
    }
  ];

  Map<String, dynamic>? lastDeniedItem; // for UNDO UI

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

  
  Widget _buildTabs() {
    return Row(
      children: [
        _tabButton("APPROVE REQUEST", showApproveTab, () {
          setState(() => showApproveTab = true);
        }),
        _tabButton("PAST REQUESTS", !showApproveTab, () {
          setState(() => showApproveTab = false);
        }),
      ],
    );
  }

  Widget _tabButton(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.grey[200],
            border: Border.all(
              color: active ? Color(0xFF227B80) : Colors.grey,
              width: active ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active ? Color(0xFF227B80) : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------------
                APPROVE REQUEST LIST
  --------------------------------------------------------*/
  Widget _buildApproveList() {
    return Stack(
      children: [
        ListView.builder(
          itemCount: pending.length,
          itemBuilder: (context, i) {
            return _pendingTile(pending[i], i);
          },
        ),

        if (lastDeniedItem != null) _undoSnackbar(),
      ],
    );
  }

  Widget _pendingTile(Map<String, dynamic> req, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(req["time"],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(req["name"],
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          Text(req["title"]),
          const SizedBox(height: 6),
          Text("Exit Time – ${req["exit"]}"),
          Text("Entry Time – ${req["entry"]}"),
          const SizedBox(height: 10),

          // APPROVE / DENY BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pending.removeAt(index);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                  ),
                  child: const Text("APPROVE"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      lastDeniedItem = pending[index];
                      pending.removeAt(index);
                    });

                    Future.delayed(const Duration(seconds: 4), () {
                      if (mounted) {
                        setState(() => lastDeniedItem = null);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[200],
                  ),
                  child: const Text("DENY"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /* -------------------------------------------------------
                      UNDO BUBBLE
  --------------------------------------------------------*/
  Widget _undoSnackbar() {
    return Positioned(
      right: 0,
      top: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Text("You just Denied the request"),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  pending.insert(0, lastDeniedItem!);
                  lastDeniedItem = null;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("UNDO"),
              ),
            )
          ],
        ),
      ),
    );
  }

  /* -------------------------------------------------------
                      PAST REQUESTS
  --------------------------------------------------------*/
  Widget _buildPastRequests() {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, i) {
        return _historyBlock(history[i]);
      },
    );
  }

  Widget _historyBlock(Map<String, dynamic> block) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(block["date"],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),

          ...block["list"].map<Widget>((item) => _historyTile(item)).toList()
        ],
      ),
    );
  }

  Widget _historyTile(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
                Text(item["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                Text(item["title"]),
                const SizedBox(height: 6),
                Text("Exit Time – ${item["exit"]}"),
                Text("Entry Time – ${item["entry"]}"),
              ],
            ),
          ),
          Icon(
            item["approved"] ? Icons.check_circle : Icons.cancel,
            color: item["approved"] ? Colors.green : Colors.red,
            size: 26,
          )
        ],
      ),
    );
  }
}
