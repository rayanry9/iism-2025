import 'package:flutter/widgets.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/widgets/campus_map.dart';

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: Constants.screenWidthPadding,
      ),
      child: CampusMap(),
    );
  }
}
