import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/Screens/games_screen/services/fortune_wheel_services.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> items = [
    '50',
    '10',
    '5',
    'Myster Brew',
    'Myster Brew',
    '5',
    '📦Mystry',
    '25',
  ];
  List colorList = [Color(0xff9c682f), Color(0xff8e581b)];
  final StreamController<int> selected = StreamController<int>();
  int? selectedIndex;
  bool isSpinAvailable = false;
  DateTime? nextSpinTime;

  void _checkSpinAvailability() async {
    DateTime? next = await FortuneWheelService().getNextAvailableSpinTime();
    setState(() {
      nextSpinTime = next;
      isSpinAvailable = next == null;
    });
  }

  void _showNextAvailableDialog() {
    String message =
        nextSpinTime != null
            ? "Your next spin will be available on ${nextSpinTime!.toLocal().toString().substring(0, 16)}"
            : "Spin not available now.";

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Spin Unavailable"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkSpinAvailability();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              'Feeling lucky? Spin the Loop and see what brews!',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 30,
                width: 112,
                child: Text(
                  'You can choose from our references',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 46),
            Container(
              height: 300,
              width: 300,
              child: Stack(
                children: [
                  FortuneWheel(
                    animateFirst: false,
                    selected: selected.stream,
                    onAnimationEnd: () async {
                      if (selectedIndex == null) return;

                      final reward = items[selectedIndex!];
                      final service = FortuneWheelService();

                      try {
                        if (isSpinAvailable) {
                          await service.useDailySpin(reward);
                          EasyLoading.showSuccess("Your Reward: ${reward}");
                        } else {
                          _showNextAvailableDialog();
                        }
                      } catch (err) {
                        EasyLoading.showError(err.toString());
                      }

                      // try {
                      //   final nextSpinTime =
                      //       await service.getNextAvailableSpinTime();

                      //   if (nextSpinTime == null) {
                      //     // Eligible to spin

                      //   } else {
                      //     // Not eligible - already spun today
                      //     final formattedTime =
                      //         "${nextSpinTime.hour.toString().padLeft(2, '0')}:${nextSpinTime.minute.toString().padLeft(2, '0')}";
                      //     showDialog(
                      //       context: context,
                      //       builder:
                      //           (_) => AlertDialog(
                      //             title: Text("Try Again Later"),
                      //             content: Text(
                      //               "You can spin again after $formattedTime today.",
                      //             ),
                      //             actions: [
                      //               TextButton(
                      //                 onPressed: () => Navigator.pop(context),
                      //                 child: Text("OK"),
                      //               ),
                      //             ],
                      //           ),
                      //     );
                      //   }
                      // } catch (e) {
                      //   print("Spin failed: $e");
                      // }
                    },

                    items: [
                      for (int i = 0; i < items.length; i++)
                        FortuneItem(
                          child: Text(
                            items[i],
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Color(0xfffaeccd),
                            ),
                          ),
                          style: FortuneItemStyle(
                            color: i % 2 == 0 ? colorList[1] : colorList[0],
                          ),
                        ),
                    ],
                    indicators: const <FortuneIndicator>[
                      FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: TriangleIndicator(color: Colors.black),
                      ),
                    ],
                  ),

                  Positioned(
                    top: 150 - 30,
                    left: 150 - 30,
                    child: GestureDetector(
                      onTap: () async {
                        if (isSpinAvailable) {
                          selectedIndex = Random().nextInt(items.length);
                          selected.add(selectedIndex!);
                        } else {
                          _showNextAvailableDialog();
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   color: Color(0xff9f4b1a),
                          //   width: 3,
                          // ),
                        ),

                        child: Center(
                          child: Text(
                            'SPIN',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xfffaeccd),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed:
                  isSpinAvailable
                      ? () {
                        selectedIndex = Random().nextInt(items.length);
                        selected.add(selectedIndex!);
                      }
                      : _showNextAvailableDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff745340),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text(
                    'Play',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Icon(Iconsax.arrow_right_1, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
