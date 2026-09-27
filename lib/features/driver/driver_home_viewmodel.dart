import 'package:flutter/foundation.dart';

import '../../data/models/ride_models.dart';
import '../../data/repositories/ride_repository.dart';

class DriverHomeViewModel extends ChangeNotifier {
  DriverHomeViewModel(this._repo) {
    refresh();
  }

  final RideRepository _repo;

  bool online = true;
  bool loading = false;
  List<RideRequest> requests = [];

  Future<void> refresh() async {
    if (!online) return;
    loading = true;
    notifyListeners();
    requests = await _repo.fetchRequests();
    loading = false;
    notifyListeners();
  }

  void setOnline(bool value) {
    if (value == online) return;
    online = value;
    // أول ما يرجع online نجيب الطلبات من جديد
    if (online) {
      refresh();
    } else {
      requests = [];
      notifyListeners();
    }
  }
}
