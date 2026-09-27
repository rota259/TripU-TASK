import 'package:flutter/foundation.dart';

import '../../data/models/wallet_models.dart';
import '../../data/repositories/wallet_repository.dart';

class WalletViewModel extends ChangeNotifier {
  WalletViewModel(this._repo, {required this.isDriver}) {
    _load();
  }

  final WalletRepository _repo;
  final bool isDriver;

  bool loading = true;
  bool addingFunds = false;
  double balance = 0;
  int earnedToday = 0;
  List<WalletTransaction> _txns = [];

  Future<void> _load() async {
    final s = await _repo.fetchSummary(driver: isDriver);
    balance = s.balance;
    earnedToday = s.earnedToday;
    _txns = s.transactions;
    loading = false;
    notifyListeners();
  }

  /// متجمعة باليوم (النهارده، وبعدين كل يوم لوحده) بنفس ترتيبها
  Map<DateTime, List<WalletTransaction>> get grouped {
    final map = <DateTime, List<WalletTransaction>>{};
    for (final t in _txns) {
      final day = DateTime(t.date.year, t.date.month, t.date.day);
      map.putIfAbsent(day, () => []).add(t);
    }
    return map;
  }

  Future<void> addFunds(int amount) async {
    addingFunds = true;
    notifyListeners();
    balance = await _repo.addFunds(amount);
    addingFunds = false;
    notifyListeners();
  }
}
