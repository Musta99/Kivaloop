import 'package:cloud_firestore/cloud_firestore.dart';

class FortuneWheelModel {
  int streak;
  DateTime? lastSpinDate;
  int purchaseSpins;
  int socialSpins;
  int referralSpins;
  bool birthdaySpinUsed;
  bool anniversarySpinUsed;
  int secretCodeSpins;
  List<SpinHistory> spinHistory;

  FortuneWheelModel({
    required this.streak,
    this.lastSpinDate,
    required this.purchaseSpins,
    required this.socialSpins,
    required this.referralSpins,
    required this.birthdaySpinUsed,
    required this.anniversarySpinUsed,
    required this.secretCodeSpins,
    required this.spinHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'streak': streak,
      'lastSpinDate':
          lastSpinDate != null ? Timestamp.fromDate(lastSpinDate!) : null,
      'purchaseSpins': purchaseSpins,
      'socialSpins': socialSpins,
      'referralSpins': referralSpins,
      'birthdaySpinUsed': birthdaySpinUsed,
      'anniversarySpinUsed': anniversarySpinUsed,
      'secretCodeSpins': secretCodeSpins,
      'spinHistory': spinHistory.map((e) => e.toMap()).toList(),
    };
  }

  factory FortuneWheelModel.fromMap(Map<String, dynamic> map) {
    return FortuneWheelModel(
      streak: map['streak'] ?? 0,
      lastSpinDate:
          map['lastSpinDate'] != null
              ? (map['lastSpinDate'] as Timestamp).toDate()
              : null,
      purchaseSpins: map['purchaseSpins'] ?? 0,
      socialSpins: map['socialSpins'] ?? 0,
      referralSpins: map['referralSpins'] ?? 0,
      birthdaySpinUsed: map['birthdaySpinUsed'] ?? false,
      anniversarySpinUsed: map['anniversarySpinUsed'] ?? false,
      secretCodeSpins: map['secretCodeSpins'] ?? 0,
      spinHistory:
          map['spinHistory'] != null
              ? List<SpinHistory>.from(
                (map['spinHistory'] as List).map((x) => SpinHistory.fromMap(x)),
              )
              : [],
    );
  }
}

class SpinHistory {
  final String reward;
  final String source;
  final DateTime date;

  SpinHistory({required this.reward, required this.source, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'reward': reward,
      'source': source,
      'date': Timestamp.fromDate(date),
    };
  }

  factory SpinHistory.fromMap(Map<String, dynamic> map) {
    return SpinHistory(
      reward: map['reward'],
      source: map['source'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
