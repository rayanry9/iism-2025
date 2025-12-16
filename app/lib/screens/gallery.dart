import 'package:flutter/material.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/day_selector.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  DateTime _selectedDate = DateTime(2025, 12, 13);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          DaySelector(
            isStaff: context.read<UserViewModel>().me!.staff,
            onUpdate: (v) {
              setState(() {
                _selectedDate = v;
              });
            },
            selectedDate: _selectedDate,
          ),
        ],
      ),
    );
  }
}
