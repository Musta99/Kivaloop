import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Customers/customer_screen.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Dashboard/dashboard_screen.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Menu/menu_screen.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Orders/orders_screen.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Profile/shop_partner_profile_screen.dart';
import 'package:kivaloop/State-Management/ShopPartnerStateManagement/shop_partner_bottom_navbar_state.dart';
import 'package:provider/provider.dart';

class ShopPartnerBottomNavbarScreen extends StatelessWidget {
  ShopPartnerBottomNavbarScreen({super.key});

  List shopPartnerScreensList = [
    DashboardScreen(),
    OrdersScreen(),
    MenuScreen(),
    CustomerScreen(),
    ShopPartnerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex:
                Provider.of<ShopPartnerBottomNavbarState>(
                  context,
                ).selectedIndex,
            onTap: (index) {
              Provider.of<ShopPartnerBottomNavbarState>(
                context,
                listen: false,
              ).changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xff745340),
            unselectedItemColor: Colors.black.withOpacity(0.5),
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.activity),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(icon: Icon(Iconsax.box), label: 'Orders'),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.coffee),
                label: 'Menu',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_2user),
                label: 'Customers',
              ),

              BottomNavigationBarItem(
                icon: Icon(Iconsax.shop),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body:
          shopPartnerScreensList[Provider.of<ShopPartnerBottomNavbarState>(
            context,
          ).selectedIndex],
    );
  }
}
