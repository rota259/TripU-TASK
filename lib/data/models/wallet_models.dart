import 'package:flutter/material.dart';

enum TxnKind {
  fawry('txn_fawry', Icons.bolt_rounded),
  card('txn_card', Icons.credit_card_rounded),
  paypal('txn_paypal', Icons.account_balance_wallet_rounded),
  trip('txn_trip', Icons.local_taxi_rounded);

  const TxnKind(this.labelKey, this.icon);

  final String labelKey;
  final IconData icon;
}

class WalletTransaction {
  const WalletTransaction({
    required this.kind,
    required this.date,
    required this.amount,
  });

  final TxnKind kind;
  final DateTime date;
  final int amount;
}

class WalletSummary {
  const WalletSummary({
    required this.balance,
    required this.earnedToday,
    required this.transactions,
  });

  final double balance;
  final int earnedToday;
  final List<WalletTransaction> transactions;
}
