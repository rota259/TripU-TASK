import '../mock/mock_data.dart';
import '../models/wallet_models.dart';

class WalletRepository {
  double _balance = 0;

  Future<WalletSummary> fetchSummary({required bool driver}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final txns = driver ? MockData.driverTransactions() : MockData.transactions();
    // earned today = مجموع رحلات النهارده بس
    final now = DateTime.now();
    final earned = txns
        .where((t) => t.kind == TxnKind.trip && t.date.day == now.day)
        .fold<int>(0, (sum, t) => sum + t.amount);
    return WalletSummary(balance: _balance, earnedToday: earned, transactions: txns);
  }

  Future<double> addFunds(int amount) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _balance += amount;
    return _balance;
  }
}
