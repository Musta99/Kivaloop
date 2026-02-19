// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kivaloop/Features/AddPostScreen/add_post_screen.dart';
// import 'package:kivaloop/Features/Screens/games_screen/game_screen.dart';
// import 'package:kivaloop/Features/Screens/home_screen/home_screen.dart';
// import 'package:kivaloop/Features/Screens/map_screen/map_screen.dart';
// import 'package:kivaloop/Features/Screens/profile_screen/profile_screen.dart';
// import 'package:kivaloop/State-Management/BottomNavbarState/bottom_navbar_state_management.dart';
// import 'package:provider/provider.dart';

// class BottomNavbarScreen extends StatefulWidget {
//   BottomNavbarScreen({super.key});

//   @override
//   State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
// }

// class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
//   int selectedIndex = 0;
//   List screensList = [
//     HomeScreen(),
//     GameScreen(),
//     AddPostScreen(),
//     MapScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black38,
//               blurRadius: 10,
//               offset: Offset(0, -3),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(24),
//             topRight: Radius.circular(24),
//           ),
//           child: BottomNavigationBar(
//             currentIndex:
//                 Provider.of<BottomNavbarStateManagement>(context).selectedIndex,
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             onTap: (index) {
//               Provider.of<BottomNavbarStateManagement>(
//                 context,
//                 listen: false,
//               ).changeBottomNavbar(index);
//             },
//             type: BottomNavigationBarType.fixed,
//             selectedItemColor: Color(0xff745340),

//             unselectedItemColor: Colors.black.withOpacity(0.5),
//             backgroundColor: Colors.white,
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Iconsax.game), label: 'Game'),
//               BottomNavigationBarItem(
//                 icon: Icon(Iconsax.add_circle),
//                 label: 'Add',
//               ),
//               BottomNavigationBarItem(icon: Icon(Iconsax.map), label: 'Map'),

//               BottomNavigationBarItem(
//                 icon: Icon(Iconsax.user),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       ),
//       body:
//           screensList[Provider.of<BottomNavbarStateManagement>(
//             context,
//           ).selectedIndex],
//     );
//   }
// }

// ------------------------------ 2222222222222222222 --------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/AddPostScreen/add_post_screen.dart';
import 'package:kivaloop/Features/Screens/games_screen/game_screen.dart';
import 'package:kivaloop/Features/Screens/home_screen/home_screen.dart';
import 'package:kivaloop/Features/Screens/map_screen/map_screen.dart';
import 'package:kivaloop/Features/Screens/profile_screen/profile_screen.dart';
import 'package:kivaloop/State-Management/BottomNavbarState/bottom_navbar_state_management.dart';
import 'package:provider/provider.dart';

class BottomNavbarScreen extends StatefulWidget {
  BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Widget> screensList = [
    HomeScreen(),
    GameScreen(),
    AddPostScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  final List<Map<String, dynamic>> navItems = [
    {'icon': Iconsax.home_2, 'activeIcon': Iconsax.home_15, 'label': 'Home'},
    {'icon': Iconsax.game, 'activeIcon': Iconsax.game5, 'label': 'Games'},
    {
      'icon': Iconsax.add,
      'activeIcon': Iconsax.add,
      'label': 'Post',
      'isCenter': true,
    },
    {'icon': Iconsax.map_1, 'activeIcon': Iconsax.map5, 'label': 'Explore'},
    {'icon': Iconsax.user, 'activeIcon': Iconsax.user, 'label': 'Profile'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8F5),
      extendBody: true,
      body: Consumer<BottomNavbarStateManagement>(
        builder: (context, navState, child) {
          return IndexedStack(
            index: navState.selectedIndex,
            children: screensList,
          );
        },
      ),
      bottomNavigationBar: Consumer<BottomNavbarStateManagement>(
        builder: (context, navState, child) {
          return Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              bottom: 8.h,
              top: 8.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF5C4033).withOpacity(0.08),
                  blurRadius: 30,
                  offset: Offset(0, -10),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Container(
                height: 50.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    final isSelected = navState.selectedIndex == index;
                    final isCenter = item['isCenter'] == true;

                    if (isCenter) {
                      // Center Add Button
                      return GestureDetector(
                        onTap: () {
                          Provider.of<BottomNavbarStateManagement>(
                            context,
                            listen: false,
                          ).changeBottomNavbar(index);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOutBack,
                          height: 58.h,
                          width: 58.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:
                                  isSelected
                                      ? [Color(0xFFFFD700), Color(0xFFFF9800)]
                                      : [Color(0xFF8B6914), Color(0xFF5C4033)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (isSelected
                                        ? Color(0xFFFF9800)
                                        : Color(0xFF5C4033))
                                    .withOpacity(0.4),
                                blurRadius: isSelected ? 20 : 15,
                                offset: Offset(0, isSelected ? 8 : 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            isSelected ? Iconsax.add : Iconsax.add,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      );
                    }

                    // Regular Nav Item
                    return GestureDetector(
                      onTap: () {
                        Provider.of<BottomNavbarStateManagement>(
                          context,
                          listen: false,
                        ).changeBottomNavbar(index);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSelected ? 16.w : 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Color(0xFF5C4033).withOpacity(0.1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              child: Icon(
                                isSelected ? item['activeIcon'] : item['icon'],
                                color:
                                    isSelected
                                        ? Color(0xFF5C4033)
                                        : Colors.grey[400],
                                size: isSelected ? 26 : 24,
                              ),
                            ),
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                              child:
                                  isSelected
                                      ? Row(
                                        children: [
                                          SizedBox(width: 8.w),
                                          Text(
                                            item['label'],
                                            style: GoogleFonts.roboto(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF5C4033),
                                            ),
                                          ),
                                        ],
                                      )
                                      : SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
