import 'package:collection/collection.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/models/outing.dart';
import 'package:iism_2025/services/api_service.dart';
import 'package:iism_2025/viewmodel/approve_outing_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApproveRequestScreen extends StatelessWidget {
  final UserViewModel _userViewModel;
  final ApiService _apiService;
  const ApproveRequestScreen({
    super.key,
    required UserViewModel user,
    required ApiService api,
  }) : _userViewModel = user,
       _apiService = api;

  @override
  Widget build(BuildContext context) {
    final approveOutingVM = context.watch<ApproveOutingViewModel>();
    return Padding(
      padding: const EdgeInsets.all(Constants.screenWidthPadding),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSlidingSegmentedControl<bool>(
            initialValue: approveOutingVM.approveRequestTab,
            innerPadding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              border: BoxBorder.all(color: CustomColors.gray, width: 0.5),
              borderRadius: BorderRadius.circular(40),
            ),
            thumbDecoration: BoxDecoration(
              color: CustomColors.pastelBlue,
              borderRadius: BorderRadius.circular(40),
            ),
            children: {
              true: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "APPROVE REQUEST",
                  style: TextStyle(fontSize: Constants.buttonTextSize),
                ),
              ),
              false: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "PAST REQUESTS",
                  style: TextStyle(fontSize: Constants.buttonTextSize),
                ),
              ),
            },
            onValueChanged: (v) {
              approveOutingVM.changeScreenTab(v);
            },
          ),
          Center(
            child: approveOutingVM.approveRequestTab
                ? const Text(
                    "Approve the Outing Requests here.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Constants.buttonTextSize,
                    ),
                  )
                : const SizedBox(width: 0),
          ),
          const Divider(height: 1, color: CustomColors.gray),
          Expanded(
            child: ListView(
              children: approveOutingVM.approveRequestTab
                  ? approveOutingVM.pendingRequests.map((elem) {
                      return _RequestTile(
                        outing: elem,
                        onDeny: () {
                          _apiService.denyOuting(elem.outingId).then((_) {
                            approveOutingVM.refetch();
                          });
                        },
                        onAccept: () async {
                          _apiService.approveOuting(elem.outingId).then((_) {
                            approveOutingVM.refetch();
                          });
                        },
                      );
                    }).toList()
                  : approveOutingVM.pastRequests
                        .map((elem) {
                          return elem.entryTime.day;
                        })
                        .indexed
                        .where((elem) {
                          return elem.$1 ==
                              approveOutingVM.pastRequests.indexWhere(
                                (a) => a.entryTime.day == elem.$2,
                              );
                        })
                        .sorted((a, b) => b.$2 - a.$2)
                        .map((elem) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              Text(
                                '${elem.$2} December',
                                style: TextStyle(
                                  color: CustomColors.blue,
                                  fontSize: Constants.titlesTextSize,
                                ),
                              ),

                              ...approveOutingVM.pastRequests
                                  .where((a) => a.entryTime.day == elem.$2)
                                  .map((e) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${e.firstName} ${e.lastName}',
                                                style: TextStyle(
                                                  fontSize:
                                                      Constants.titlesTextSize,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                              Text(
                                                e.reason,
                                                style: TextStyle(
                                                  fontSize:
                                                      Constants.buttonTextSize,
                                                ),
                                              ),
                                              Row(
                                                spacing: 16,
                                                children: [
                                                  Text(
                                                    'Exit Time - ${DateFormat("hh:dd a").format(e.exitTime).toUpperCase()}',
                                                    style: TextStyle(
                                                      fontSize: Constants
                                                          .buttonTextSize,
                                                      color:
                                                          CustomColors.darkGray,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Entry Time - ${DateFormat("hh:dd a").format(e.entryTime).toUpperCase()}',
                                                    style: TextStyle(
                                                      fontSize: Constants
                                                          .buttonTextSize,
                                                      color:
                                                          CustomColors.darkGray,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                color: CustomColors.gray,
                                              ),
                                            ],
                                          ),
                                        ),

                                        e.status == 1
                                            ? Icon(
                                                Icons.check_circle_rounded,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.remove_circle_rounded,
                                                color: Colors.red,
                                              ),
                                      ],
                                    );
                                  }),
                              SizedBox(height: 20),
                            ],
                          );
                        })
                        .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestTile extends StatefulWidget {
  final GetOutingDataResponse _outingData;
  final VoidCallback onDeny;
  final VoidCallback onAccept;
  const _RequestTile({
    required GetOutingDataResponse outing,
    required this.onDeny,
    required this.onAccept,
  }) : _outingData = outing;

  @override
  State<StatefulWidget> createState() {
    return _RequestTileState();
  }
}

class _RequestTileState extends State<_RequestTile>
    with SingleTickerProviderStateMixin {
  bool _canUndo = false;
  bool _approveSelected = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isRequested = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isRequested = true;
          if (_approveSelected) {
            widget.onAccept();
          } else {
            widget.onDeny();
          }
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Text(
                    '${widget._outingData.createdAt.day == DateTime.now().day ? "Today " : DateFormat("dd MMM ").format(widget._outingData.createdAt.toLocal())} ${DateFormat("hh:mm a").format(widget._outingData.createdAt.toLocal()).toUpperCase()}',
                    style: TextStyle(
                      color: CustomColors.blue,
                      fontSize: Constants.buttonTextSize,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget._outingData.firstName} ${widget._outingData.lastName}',
                        style: TextStyle(
                          fontSize: Constants.titlesTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget._outingData.reason,
                        style: TextStyle(fontSize: Constants.buttonTextSize),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 24,
                    children: [
                      Text(
                        'Exit Time\n${DateFormat("hh:mm a").format(widget._outingData.exitTime).toUpperCase()}',
                        style: TextStyle(
                          fontSize: Constants.titlesTextSize,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.darkTeal,
                        ),
                      ),
                      Text(
                        'Entry Time\n${DateFormat("hh:mm a").format(widget._outingData.entryTime).toUpperCase()}',
                        style: TextStyle(
                          fontSize: Constants.titlesTextSize,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.darkTeal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _isRequested
                ? CircularProgressIndicator()
                : IntrinsicWidth(
                    child: _canUndo
                        ? Column(
                            spacing: 6,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: Constants.buttonTextSize,
                                  ),
                                  children: [
                                    const TextSpan(text: "You Just "),
                                    TextSpan(
                                      text: _approveSelected
                                          ? "Approved\n"
                                          : "Denied\n",
                                      style: TextStyle(
                                        color: _approveSelected
                                            ? Colors.lightGreen
                                            : Colors.red,
                                      ),
                                    ),
                                    const TextSpan(text: "the request"),
                                  ],
                                ),
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: CustomColors.teal,
                                  backgroundColor: Color.fromRGBO(
                                    210,
                                    237,
                                    242,
                                    1,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _approveSelected = false;
                                    _canUndo = true;
                                    _animationController.forward();
                                  });
                                },
                                child: Text("UNDO"),
                              ),
                              LinearProgressIndicator(
                                value: _animation.value,
                                backgroundColor: CustomColors.gray,
                                color: CustomColors.darkTeal,
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Color.fromRGBO(
                                    0,
                                    131,
                                    28,
                                    1,
                                  ),
                                  backgroundColor: Color.fromRGBO(
                                    180,
                                    255,
                                    188,
                                    1,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _approveSelected = true;
                                    _canUndo = true;
                                    _animationController.forward();
                                  });
                                },
                                child: Text("APPROVE"),
                              ),

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Color.fromRGBO(206, 0, 0, 1),
                                  backgroundColor: Color.fromRGBO(
                                    255,
                                    215,
                                    215,
                                    1,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _approveSelected = false;
                                    _canUndo = true;
                                    _animationController.forward();
                                  });
                                },
                                child: Text("DENY"),
                              ),
                            ],
                          ),
                  ),
          ],
        ),
        const Divider(height: 1, color: CustomColors.gray),
      ],
    );
  }
}
