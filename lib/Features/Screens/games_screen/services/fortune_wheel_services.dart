import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kivaloop/Features/Screens/games_screen/Model/fortune_wheel_model.dart';

class FortuneWheelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  DocumentReference get _userDoc =>
      _firestore.collection('fortune_wheel').doc(userId);

  Future<void> initializeUserData() async {
    final doc = await _userDoc.get();
    if (!doc.exists) {
      await _userDoc.set(
        FortuneWheelModel(
          streak: 0,
          lastSpinDate: null,
          purchaseSpins: 0,
          socialSpins: 0,
          referralSpins: 0,
          birthdaySpinUsed: false,
          anniversarySpinUsed: false,
          secretCodeSpins: 0,
          spinHistory: [],
        ).toMap(),
      );
    }
  }

  Future<FortuneWheelModel?> getUserSpinData() async {
    final snapshot = await _userDoc.get();
    if (snapshot.exists) {
      return FortuneWheelModel.fromMap(
        snapshot.data()! as Map<String, dynamic>,
      );
    }
    return null;
  }

  Future<void> useDailySpin(rewardPts) async {
    await initializeUserData(); // Ensure document exists first
    final data = await getUserSpinData();
    if (data == null) return;

    DateTime today = DateTime.now();
    bool isSameDay =
        data.lastSpinDate != null &&
        data.lastSpinDate!.difference(today).inDays == 0;

    if (isSameDay) {
      throw Exception('Already spun today');
    }

    int newStreak = 1;
    if (data.lastSpinDate != null &&
        data.lastSpinDate!
                .difference(today.subtract(const Duration(days: 1)))
                .inDays ==
            0) {
      newStreak = data.streak + 1;
    }

    // int rewardPts = [5, 10, 15, 20, 25][newStreak.clamp(0, 4)]; // max day 5 = 25 pts

    await _userDoc.update({
      'streak': newStreak,
      'lastSpinDate': Timestamp.now(),
      'spinHistory': FieldValue.arrayUnion([
        {'reward': '$rewardPts', 'source': 'daily', 'date': Timestamp.now()},
      ]),
    });

    print("Added==========================>");
  }

  Future<void> useSpin(String sourceField, reward) async {
    final data = await getUserSpinData();
    if (data == null) return;

    Map<String, dynamic> updateData = {};

    if (sourceField == 'purchaseSpins' && data.purchaseSpins > 0) {
      updateData['purchaseSpins'] = data.purchaseSpins - 1;
    } else if (sourceField == 'socialSpins' && data.socialSpins > 0) {
      updateData['socialSpins'] = data.socialSpins - 1;
    } else if (sourceField == 'referralSpins' && data.referralSpins > 0) {
      updateData['referralSpins'] = data.referralSpins - 1;
    } else if (sourceField == 'secretCodeSpins' && data.secretCodeSpins > 0) {
      updateData['secretCodeSpins'] = data.secretCodeSpins - 1;
    } else {
      throw Exception('No spins available for this source');
    }

    // Example reward (you can randomize this)
    // String reward = "10 pts";

    updateData['spinHistory'] = FieldValue.arrayUnion([
      {
        'reward': reward,
        'source': sourceField.replaceAll('Spins', ''),
        'date': Timestamp.now(),
      },
    ]);

    await _userDoc.update(updateData);
  }

  // Check if user has already spun today
  Future<DateTime?> getNextAvailableSpinTime() async {
    final data = await getUserSpinData();
    if (data?.lastSpinDate == null) return null;

    DateTime last = data!.lastSpinDate!;
    DateTime now = DateTime.now();

    // If already spun today, show next available time
    if (last.difference(DateTime(now.year, now.month, now.day)).inDays == 0) {
      return DateTime(now.year, now.month, now.day + 1); // next day 00:00
    }
    return null; // spin is available now
  }
}
