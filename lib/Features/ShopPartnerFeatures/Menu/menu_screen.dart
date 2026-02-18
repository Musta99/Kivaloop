import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kivaloop/Features/ShopPartnerFeatures/Menu/add_menu_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future fetchMenuItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance
            .collection("shops")
            .where("ownerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final shopId = querySnapshot.docs.first.id;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection("shops")
              .doc(shopId)
              .collection("menus")
              .get();

      return snapshot.docs;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    final isShopAvailable = fetchMenuItems();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 20.w),
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           CupertinoPageRoute(builder: (context) => AddMenuScreen()),
        //         );
        //       },
        //       child: CircleAvatar(radius: 12.r, child: Icon(Iconsax.add)),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: fetchMenuItems(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (!snapshots.hasData) {
                return Center(
                  child: Text(
                    "No Items has been found. Please add a Cafe First",
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshots.data.length,
                        itemBuilder: (context, index) {
                          final doc = snapshots.data![index];
                          final itemName = doc['itemName'] ?? 'No Name';
                          final itemDescription =
                              doc['itemDescription'] ?? 'No Name';
                          final itemPrice = doc['itemPrice'] ?? 'No Price';
                          final itemImage = doc['itemImage'] ?? '';
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // IMAGE
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child:
                                        itemImage.isNotEmpty
                                            ? Image.network(
                                              itemImage,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            )
                                            : Container(
                                              width: 60,
                                              height: 60,
                                              color: Colors.grey[300],
                                              child: Icon(
                                                Icons.image,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                  ),

                                  SizedBox(width: 12),

                                  // CONTENT
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Top row: Name + Available + Edit
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                itemName,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green[100],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                'Available',
                                                style: TextStyle(
                                                  color: Colors.green[800],
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: Colors.grey[700],
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 4),

                                        // Subtitle / Category
                                        Text(
                                          'Coffee',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 13,
                                          ),
                                        ),

                                        SizedBox(height: 4),

                                        // Description (you can customize)
                                        Text(
                                          itemDescription ??
                                              'Delicious coffee made fresh.',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 13,
                                          ),
                                        ),

                                        SizedBox(height: 8),

                                        // Price and Buttons
                                        Row(
                                          children: [
                                            Text(
                                              '\$${itemPrice}',
                                              style: TextStyle(
                                                color: Colors.orange[800],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Spacer(),
                                            OutlinedButton.icon(
                                              onPressed: () {
                                                // View action
                                              },
                                              icon: Icon(
                                                Icons.visibility,
                                                size: 16,
                                              ),
                                              label: Text('View'),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.orange,
                                                side: BorderSide(
                                                  color: Colors.orange,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            OutlinedButton(
                                              onPressed: () {
                                                // Disable action
                                              },
                                              child: Text('Disable'),
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: Colors.red,
                                                side: BorderSide(
                                                  color: Colors.red,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 6,
                                                ),
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
                          );
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AddMenuScreen(),
                          ),
                        );
                      },
                      child: Text("Add Menu"),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
