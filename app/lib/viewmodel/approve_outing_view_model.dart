import 'package:flutter/widgets.dart';
import 'package:iism_2025/models/outing.dart';
import 'package:iism_2025/services/api_service.dart';

class ApproveOutingViewModel extends ChangeNotifier {
  bool _approveRequestTab = true;
  bool _isFetching = false;
  final ApiService _apiService;

  List<GetOutingDataResponse> _pendingRequests = [];
  List<GetOutingDataResponse> _pastRequests = [];

  bool get approveRequestTab => _approveRequestTab;
  bool get isFetching => _isFetching;
  List<GetOutingDataResponse> get pendingRequests => _pendingRequests;
  List<GetOutingDataResponse> get pastRequests => _pastRequests;

  ApproveOutingViewModel(ApiService api) : _apiService = api;

  Future<void> init() async {
    _isFetching = true;
    final allOutingData = await _apiService.getAllOutingData();
    _pendingRequests =
        allOutingData?.where((out) => out.status == 0).toList() ?? [];
    _pastRequests =
        allOutingData?.where((out) => out.status != 0).toList() ?? [];
    notifyListeners();
  }

  Future<void> refetch() async {
    final allOutingData = await _apiService.getAllOutingData();
    _pendingRequests =
        allOutingData?.where((out) => out.status == 0).toList() ?? [];
    _pastRequests =
        allOutingData?.where((out) => out.status != 0).toList() ?? [];
    notifyListeners();
  }

  void changeScreenTab(bool goToApproveRequest) {
    _approveRequestTab = goToApproveRequest;
    notifyListeners();
  }
}
