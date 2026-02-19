// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kivaloop/Features/Screens/games_screen/services/fortune_wheel_services.dart';

// class GameScreen extends StatefulWidget {
//   const GameScreen({super.key});

//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }

// class _GameScreenState extends State<GameScreen> {
//   final List<String> items = [
//     '50',
//     '10',
//     '5',
//     'Myster Brew',
//     'Myster Brew',
//     '5',
//     '📦Mystry',
//     '25',
//   ];
//   List colorList = [Color(0xff9c682f), Color(0xff8e581b)];
//   final StreamController<int> selected = StreamController<int>();
//   int? selectedIndex;
//   bool isSpinAvailable = false;
//   DateTime? nextSpinTime;

//   void _checkSpinAvailability() async {
//     DateTime? next = await FortuneWheelService().getNextAvailableSpinTime();
//     setState(() {
//       nextSpinTime = next;
//       isSpinAvailable = next == null;
//     });
//   }

//   void _showNextAvailableDialog() {
//     String message =
//         nextSpinTime != null
//             ? "Your next spin will be available on ${nextSpinTime!.toLocal().toString().substring(0, 16)}"
//             : "Spin not available now.";

//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: Text("Spin Unavailable"),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("OK"),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _checkSpinAvailability();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         child: Column(
//           children: [
//             Text(
//               'Feeling lucky? Spin the Loop and see what brews!',
//               style: GoogleFonts.roboto(
//                 color: Colors.black,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 32),

//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 30,
//                 width: 112,
//                 child: Text(
//                   'You can choose from our references',
//                   style: GoogleFonts.roboto(
//                     color: Colors.black,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 46),
//             Container(
//               height: 300,
//               width: 300,
//               child: Stack(
//                 children: [
//                   FortuneWheel(
//                     animateFirst: false,
//                     selected: selected.stream,
//                     onAnimationEnd: () async {
//                       if (selectedIndex == null) return;

//                       final reward = items[selectedIndex!];
//                       final service = FortuneWheelService();

//                       try {
//                         if (isSpinAvailable) {
//                           await service.useDailySpin(reward);
//                           EasyLoading.showSuccess("Your Reward: ${reward}");
//                         } else {
//                           _showNextAvailableDialog();
//                         }
//                       } catch (err) {
//                         EasyLoading.showError(err.toString());
//                       }

//                     },

//                     items: [
//                       for (int i = 0; i < items.length; i++)
//                         FortuneItem(
//                           child: Text(
//                             items[i],
//                             style: GoogleFonts.roboto(
//                               fontSize: 15,
//                               color: Color(0xfffaeccd),
//                             ),
//                           ),
//                           style: FortuneItemStyle(
//                             color: i % 2 == 0 ? colorList[1] : colorList[0],
//                           ),
//                         ),
//                     ],
//                     indicators: const <FortuneIndicator>[
//                       FortuneIndicator(
//                         alignment: Alignment.topCenter,
//                         child: TriangleIndicator(color: Colors.black),
//                       ),
//                     ],
//                   ),

//                   Positioned(
//                     top: 150 - 30,
//                     left: 150 - 30,
//                     child: GestureDetector(
//                       onTap: () async {
//                         if (isSpinAvailable) {
//                           selectedIndex = Random().nextInt(items.length);
//                           selected.add(selectedIndex!);
//                         } else {
//                           _showNextAvailableDialog();
//                         }
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           shape: BoxShape.circle,
//                           // border: Border.all(
//                           //   color: Color(0xff9f4b1a),
//                           //   width: 3,
//                           // ),
//                         ),

//                         child: Center(
//                           child: Text(
//                             'SPIN',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Color(0xfffaeccd),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),

//             ElevatedButton(
//               onPressed:
//                   isSpinAvailable
//                       ? () {
//                         selectedIndex = Random().nextInt(items.length);
//                         selected.add(selectedIndex!);
//                       }
//                       : _showNextAvailableDialog,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xff745340),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 32,
//                   vertical: 12,
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 spacing: 10,
//                 children: [
//                   Text(
//                     'Play',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                   Icon(Iconsax.arrow_right_1, color: Colors.white),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ------------------------------- 2222222222222222222222222222222 ---------------------------------
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/Screens/games_screen/services/fortune_wheel_services.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> items = [
    {'label': '50', 'icon': Iconsax.coin, 'type': 'coins'},
    {'label': '10', 'icon': Iconsax.coin, 'type': 'coins'},
    {'label': '5', 'icon': Iconsax.coin, 'type': 'coins'},
    {'label': 'Mystery Brew', 'icon': Iconsax.coffee, 'type': 'special'},
    {'label': 'Free Coffee', 'icon': Iconsax.cup, 'type': 'prize'},
    {'label': '25', 'icon': Iconsax.coin, 'type': 'coins'},
    {'label': '📦 Mystery', 'icon': Iconsax.gift, 'type': 'special'},
    {'label': '100', 'icon': Iconsax.medal_star, 'type': 'jackpot'},
  ];

  final List<Color> wheelColors = [
    Color(0xFF8B6914),
    Color(0xFF5C4033),
    Color(0xFFD4A574),
    Color(0xFF3D2817),
    Color(0xFFB8860B),
    Color(0xFF6B4423),
    Color(0xFFCD853F),
    Color(0xFF4A3728),
  ];

  final StreamController<int> selected = StreamController<int>.broadcast();
  int? selectedIndex;
  bool isSpinAvailable = true;
  bool isSpinning = false;
  DateTime? nextSpinTime;
  int userCoins = 850;
  int spinsRemaining = 1;

  late AnimationController _pulseController;
  late AnimationController _glowController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _checkSpinAvailability();

    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _glowController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    selected.close();
    _pulseController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _checkSpinAvailability() async {
    DateTime? next = await FortuneWheelService().getNextAvailableSpinTime();
    if (!mounted) return;
    setState(() {
      nextSpinTime = next;
      isSpinAvailable = next == null;
    });
  }

  void _showNextAvailableDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF9800).withOpacity(0.1),
                        Color(0xFFFF5722).withOpacity(0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.timer_1,
                    size: 50,
                    color: Color(0xFFFF9800),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Come Back Later!",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  nextSpinTime != null
                      ? "Your next spin will be available on\n${_formatDateTime(nextSpinTime!)}"
                      : "Spin not available right now.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 10.h),

                // Countdown Timer Display
                if (nextSpinTime != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAF8F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeBlock(
                          _getTimeRemaining()['hours'].toString(),
                          "Hours",
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          ":",
                          style: GoogleFonts.roboto(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        _buildTimeBlock(
                          _getTimeRemaining()['minutes'].toString(),
                          "Min",
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          ":",
                          style: GoogleFonts.roboto(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        _buildTimeBlock(
                          _getTimeRemaining()['seconds'].toString(),
                          "Sec",
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 10.h),

                // Watch Ad Button
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Watch ad logic
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: 16.h),
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: [Color(0xFF8B6914), Color(0xFF5C4033)],
                //       ),
                //       borderRadius: BorderRadius.circular(16),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Color(0xFF5C4033).withOpacity(0.3),
                //           blurRadius: 12,
                //           offset: Offset(0, 4),
                //         ),
                //       ],
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Iconsax.video_play, color: Colors.white),
                //         SizedBox(width: 10.w),
                //         Text(
                //           "Watch Ad for Free Spin",
                //           style: GoogleFonts.roboto(
                //             fontSize: 15.sp,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Maybe Later",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _showRewardDialog(String reward) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Confetti Animation Placeholder
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFD700).withOpacity(0.2),
                          Color(0xFFFF9800).withOpacity(0.2),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFD700), Color(0xFFFF9800)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Iconsax.gift, size: 50, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "🎉 Congratulations! 🎉",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "You won",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8B6914), Color(0xFF5C4033)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      reward,
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          "Claim Reward",
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Map<String, int> _getTimeRemaining() {
    if (nextSpinTime == null) {
      return {'hours': 0, 'minutes': 0, 'seconds': 0};
    }
    Duration diff = nextSpinTime!.difference(DateTime.now());
    return {
      'hours': diff.inHours,
      'minutes': diff.inMinutes % 60,
      'seconds': diff.inSeconds % 60,
    };
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8F5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 100.h,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Color(0xFF5C4033),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF8B6914),
                      Color(0xFF5C4033),
                      Color(0xFF3D2817),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      // Decorative Elements
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 5,
                        child: Icon(
                          Iconsax.gift,
                          size: 40,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          children: [
                            // Top Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Iconsax.game,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Spin & Win",
                                          style: GoogleFonts.playfairDisplay(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Try your luck today!",
                                          style: GoogleFonts.roboto(
                                            fontSize: 12.sp,
                                            color: Colors.white.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Coins Display
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFFD700),
                                        Color(0xFFFF9800),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(
                                          0xFFFF9800,
                                        ).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Iconsax.coin_1,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        userCoins.toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // Spins Remaining Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF5C4033).withOpacity(0.1),
                          Color(0xFF8B6914).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xFF5C4033).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF5C4033),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Iconsax.refresh_circle,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Spins",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                              Text(
                                isSpinAvailable
                                    ? "$spinsRemaining spins remaining today"
                                    : "Come back tomorrow!",
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Fortune Wheel Section
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.star_1,
                              size: 20,
                              color: Color(0xFFFFD700),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Spin the Wheel",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Iconsax.star_1,
                              size: 20,
                              color: Color(0xFFFFD700),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Wheel
                        AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Container(
                              height: 300.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFFFD700).withOpacity(
                                      isSpinAvailable && !isSpinning
                                          ? _glowAnimation.value
                                          : 0.2,
                                    ),
                                    blurRadius: 40,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: child,
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer Ring
                              Container(
                                height: 300.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFFD700),
                                      Color(0xFF8B6914),
                                      Color(0xFFFFD700),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF5C4033).withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: FortuneWheel(
                                    animateFirst: false,
                                    selected: selected.stream,
                                    physics: CircularPanPhysics(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.decelerate,
                                    ),
                                    onAnimationEnd: () async {
                                      if (!mounted) return;
                                      setState(() => isSpinning = false);

                                      if (selectedIndex == null) return;

                                      final reward =
                                          items[selectedIndex!]['label'];
                                      final service = FortuneWheelService();

                                      try {
                                        if (isSpinAvailable) {
                                          await service.useDailySpin(reward);
                                          if (!mounted) return;
                                          setState(() {
                                            spinsRemaining--;
                                            if (spinsRemaining <= 0) {
                                              isSpinAvailable = false;
                                            }
                                          });
                                          _showRewardDialog(reward);
                                        }
                                      } catch (err) {
                                        EasyLoading.showError(err.toString());
                                      }
                                    },
                                    items: [
                                      for (int i = 0; i < items.length; i++)
                                        FortuneItem(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  items[i]['icon'],
                                                  size: 14,
                                                  color: Color(0xFFFAECCD),
                                                ),
                                                SizedBox(width: 4.w),
                                                Flexible(
                                                  child: Text(
                                                    items[i]['label'],
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFFFAECCD),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          style: FortuneItemStyle(
                                            color:
                                                wheelColors[i %
                                                    wheelColors.length],
                                            borderColor: Colors.white
                                                .withOpacity(0.2),
                                            borderWidth: 1,
                                          ),
                                        ),
                                    ],
                                    indicators: [
                                      FortuneIndicator(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                blurRadius: 8,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: TriangleIndicator(
                                            color: Color(0xFF2D2D2D),
                                            width: 30,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Center Spin Button
                              ScaleTransition(
                                scale:
                                    isSpinAvailable && !isSpinning
                                        ? _pulseAnimation
                                        : AlwaysStoppedAnimation(1.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (isSpinAvailable && !isSpinning) {
                                      setState(() => isSpinning = true);
                                      selectedIndex = Random().nextInt(
                                        items.length,
                                      );
                                      selected.add(selectedIndex!);
                                    } else if (!isSpinAvailable) {
                                      _showNextAvailableDialog();
                                    }
                                  },
                                  child: Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors:
                                            isSpinAvailable
                                                ? [
                                                  Color(0xFF2D2D2D),
                                                  Color(0xFF1A1A1A),
                                                ]
                                                : [
                                                  Colors.grey[400]!,
                                                  Colors.grey[600]!,
                                                ],
                                      ),
                                      border: Border.all(
                                        color: Color(0xFFFFD700),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child:
                                          isSpinning
                                              ? SizedBox(
                                                height: 24.h,
                                                width: 24.w,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Color(0xFFFFD700),
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                              : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Iconsax.arrow,
                                                    color: Color(0xFFFFD700),
                                                    size: 20,
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Text(
                                                    'SPIN',
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14.sp,
                                                      color: Color(0xFFFAECCD),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Play Button
                  GestureDetector(
                    onTap: () {
                      if (isSpinAvailable && !isSpinning) {
                        setState(() => isSpinning = true);
                        selectedIndex = Random().nextInt(items.length);
                        selected.add(selectedIndex!);
                      } else if (!isSpinAvailable) {
                        _showNextAvailableDialog();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      decoration: BoxDecoration(
                        gradient:
                            isSpinAvailable
                                ? LinearGradient(
                                  colors: [
                                    Color(0xFF8B6914),
                                    Color(0xFF5C4033),
                                  ],
                                )
                                : LinearGradient(
                                  colors: [
                                    Colors.grey[400]!,
                                    Colors.grey[500]!,
                                  ],
                                ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: (isSpinAvailable
                                    ? Color(0xFF5C4033)
                                    : Colors.grey)
                                .withOpacity(0.3),
                            blurRadius: 15,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSpinning ? Iconsax.timer_1 : Iconsax.play,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            isSpinning
                                ? "Spinning..."
                                : isSpinAvailable
                                ? "Spin Now!"
                                : "Spin Later",
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Prizes Section
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD700).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Iconsax.gift,
                                size: 18,
                                color: Color(0xFFFFD700),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Available Prizes",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children:
                              items.map((item) {
                                Color badgeColor;
                                switch (item['type']) {
                                  case 'jackpot':
                                    badgeColor = Color(0xFFFFD700);
                                    break;
                                  case 'special':
                                    badgeColor = Color(0xFF9C27B0);
                                    break;
                                  case 'prize':
                                    badgeColor = Color(0xFF4CAF50);
                                    break;
                                  default:
                                    badgeColor = Color(0xFF5C4033);
                                }
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: badgeColor.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        item['icon'],
                                        size: 14,
                                        color: badgeColor,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        item['label'],
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: badgeColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Recent Wins Section
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4CAF50).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Iconsax.medal,
                                    size: 18,
                                    color: Color(0xFF4CAF50),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Recent Winners",
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D2D2D),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "View All",
                              style: GoogleFonts.roboto(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5C4033),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildRecentWinItem(
                          "John D.",
                          "100 Coins",
                          "2 min ago",
                          Iconsax.medal_star,
                        ),
                        _buildRecentWinItem(
                          "Sarah M.",
                          "Free Coffee",
                          "5 min ago",
                          Iconsax.cup,
                        ),
                        _buildRecentWinItem(
                          "Alex K.",
                          "Mystery Brew",
                          "12 min ago",
                          Iconsax.coffee,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBlock(String value, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Color(0xFF5C4033),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.padLeft(2, '0'),
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.roboto(fontSize: 10.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Widget _buildRecentWinItem(
    String name,
    String prize,
    String time,
    IconData icon,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8B6914), Color(0xFF5C4033)],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0],
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                Row(
                  children: [
                    Icon(icon, size: 12, color: Color(0xFFFFD700)),
                    SizedBox(width: 4.w),
                    Text(
                      "Won $prize",
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.roboto(fontSize: 11.sp, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
