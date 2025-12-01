import 'package:flutter/material.dart';

class ApproveRequestScreen extends StatefulWidget {
  const ApproveRequestScreen({super.key});

  @override
  State<ApproveRequestScreen> createState() => _ApproveRequestScreenState();
}

class _ApproveRequestScreenState extends State<ApproveRequestScreen> {
  bool showApproveTab = true;

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
      "title": "Going out for hyderaba…",
      "exit": "11:30 AM",
      "entry": "3:00 PM",
      "time": "Today 8:30 AM"
    },
  ];

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
      ]
    }
  ];

  Map<String, dynamic>? lastDeniedItem;

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
                child: showApproveTab ? Text(
                  "Approve the Outing Requests here.",
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ): SizedBox(width: 0,),
              ),
              const SizedBox(height: 12),
              const Divider(
                height: 1,
                color: Color(0xffD9D9D9),
              ),
              showApproveTab ? SizedBox(height: 0) : SizedBox(height: 12,),

              Expanded(
                child:
                    showApproveTab ? _buildApproveList() : _buildPastRequests(),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // TOGGLE TABS
  // ----------------------------------------------------------
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

  // ----------------------------------------------------------
  // APPROVE LIST  (Padding added)
  // ----------------------------------------------------------
 Widget _buildApproveList() {
  return ListView.separated(
    itemCount: pending.length + 1,          // +1 for divider
    separatorBuilder: (_, __) => const Divider(
      height: 1,
      color: Color(0xffD9D9D9),
    ),
    itemBuilder: (context, index) {
      if (index == pending.length) {
        // LAST ITEM → the bottom divider
        return const Divider(
          height: 0,
          color: Color(0xffD9D9D9),
        );
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
        border: Border.all(
          color: Color(0xffD9D9D9),
          width: 1,
        ),
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
            onApprove: () {},
            onDeny: () {},
          ),
          
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // PAST REQUESTS  (Padding added)
  // ----------------------------------------------------------
  Widget _buildPastRequests() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16), // << ADDED
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

        // Each card + divider
        ...block["list"].map((e) => Column(
              children: [
                _pastTile(e),
                const Divider(
                  height: 2,
                  color: Color(0xffD9D9D9),
                ),
              ],
            )),
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
                      fontWeight: FontWeight.w600, fontSize: 15),
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
