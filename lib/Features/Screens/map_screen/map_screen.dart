// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart' as geo;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   MapboxMap? mapBoxController;
//   double? latitude;
//   double? longitude;
//   void determinePosition() async {
//     bool serviceEnabled;
//     geo.LocationPermission permission;

//     serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }

//     permission = await geo.Geolocator.checkPermission();
//     if (permission == geo.LocationPermission.denied) {
//       permission = await geo.Geolocator.requestPermission();
//       if (permission == geo.LocationPermission.denied) {
//         throw Exception('Location permissions are denied');
//       }
//     }

//     if (permission == geo.LocationPermission.deniedForever) {
//       throw Exception('Location permissions are permanently denied.');
//     }

//     geo.Position position = await geo.Geolocator.getCurrentPosition(
//       desiredAccuracy: geo.LocationAccuracy.high,
//     );
//     if (!mounted) return;
//     setState(() {
//       latitude = position.latitude;
//       longitude = position.longitude;
//     });

//     EasyLoading.showSuccess(
//       ("${latitude!.toString()}, ${longitude!.toString()}"),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
//       ),

//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         margin: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           children: [
//             Container(
//               child: Column(
//                 children: [
//                   // ShadInput(
//                   //   leading: const Padding(
//                   //     padding: EdgeInsets.all(4.0),
//                   //     child: Icon(LucideIcons.coffee),
//                   //   ),
//                   //   decoration: ShadDecoration(
//                   //     border: ShadBorder.all(color: Colors.black),
//                   //   ),
//                   //   placeholder: Text('Search Coffee shop'),
//                   //   keyboardType: TextInputType.emailAddress,
//                   // ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20.w,
//                         vertical: 15.h,
//                       ),
//                       child: Column(
//                         spacing: 8.h,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 150.h,
//                             width: double.infinity,
//                             color: Colors.grey.shade400,
//                           ),

//                           Text(
//                             "Name of the Cafe",
//                             style: GoogleFonts.roboto(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Icon(Iconsax.location),
//                               Text(
//                                 "Cafe location",
//                                 style: GoogleFonts.roboto(fontSize: 12.sp),
//                               ),
//                             ],
//                           ),

//                           Row(
//                             children: [
//                               Icon(Iconsax.watch),
//                               Text(
//                                 "Time of cafe openning",
//                                 style: GoogleFonts.roboto(fontSize: 12.sp),
//                               ),
//                             ],
//                           ),

//                           Row(
//                             children: [
//                               Icon(Iconsax.mobile),
//                               Text(
//                                 "Contact No of the cafe",
//                                 style: GoogleFonts.roboto(fontSize: 12.sp),
//                               ),
//                             ],
//                           ),

//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Sppecialities",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),

//                               Wrap(
//                                 children: [
//                                   for (int i = 0; i < 3; i++)
//                                     Container(
//                                       margin: EdgeInsets.only(right: 5.w),
//                                       color: Colors.grey.shade400,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           "Special item 1",
//                                           style: GoogleFonts.roboto(
//                                             fontSize: 10.sp,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),

//                           ElevatedButton(
//                             child: Row(
//                               spacing: 15.w,
//                               children: [
//                                 Icon(Iconsax.coffee),
//                                 Text(
//                                   'Order Now',
//                                   style: GoogleFonts.roboto(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }

// ----------------------------------- 22222222222222222222222222222222 --------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  MapboxMap? mapBoxController;
  double? latitude;
  double? longitude;
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  bool _isMapView = false;
  late TabController _tabController;

  final List<Map<String, dynamic>> categories = [
    {"icon": Iconsax.coffee, "label": "All"},
    {"icon": Iconsax.star, "label": "Top Rated"},
    {"icon": Iconsax.location, "label": "Nearby"},
    {"icon": Iconsax.heart, "label": "Favorites"},
    {"icon": Iconsax.discount_shape, "label": "Offers"},
  ];

  final List<Map<String, dynamic>> coffeeShops = [
    {
      "name": "Brew & Bloom Café",
      "location": "123 Coffee Lane, Amsterdam",
      "distance": "0.5 km",
      "rating": 4.8,
      "reviews": 234,
      "openTime": "7:00 AM - 10:00 PM",
      "isOpen": true,
      "contact": "+31 20 123 4567",
      "specialties": ["Espresso", "Latte Art", "Croissants"],
      "image":
          "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
      "priceRange": "€€",
      "isFavorite": true,
    },
    {
      "name": "The Coffee House",
      "location": "456 Roast Street, Amsterdam",
      "distance": "1.2 km",
      "rating": 4.6,
      "reviews": 189,
      "openTime": "6:30 AM - 9:00 PM",
      "isOpen": true,
      "contact": "+31 20 234 5678",
      "specialties": ["Cold Brew", "Matcha", "Pastries"],
      "image":
          "https://images.unsplash.com/photo-1493857671505-72967e2e2760?w=800",
      "priceRange": "€€€",
      "isFavorite": false,
    },
    {
      "name": "Urban Roast",
      "location": "789 Bean Avenue, Amsterdam",
      "distance": "0.8 km",
      "rating": 4.9,
      "reviews": 312,
      "openTime": "8:00 AM - 11:00 PM",
      "isOpen": true,
      "contact": "+31 20 345 6789",
      "specialties": ["Single Origin", "Pour Over", "Vegan Options"],
      "image":
          "https://images.unsplash.com/photo-1445116572660-236099ec97a0?w=800",
      "priceRange": "€€",
      "isFavorite": true,
    },
    {
      "name": "Morning Bliss",
      "location": "321 Sunrise Road, Amsterdam",
      "distance": "2.1 km",
      "rating": 4.5,
      "reviews": 156,
      "openTime": "5:30 AM - 6:00 PM",
      "isOpen": false,
      "contact": "+31 20 456 7890",
      "specialties": ["Breakfast", "Americano", "Fresh Juice"],
      "image":
          "https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=800",
      "priceRange": "€",
      "isFavorite": false,
    },
  ];

  void determinePosition() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    geo.Position position = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
    );
    if (!mounted) return;
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    EasyLoading.showSuccess(
      ("${latitude!.toString()}, ${longitude!.toString()}"),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    determinePosition();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF8F5),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // Custom App Bar with Search
          SliverAppBar(
            expandedHeight: 200.h,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Color(0xFF5C4033),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF5C4033),
                      Color(0xFF8B6914),
                      Color(0xFFFAF8F5),
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),

                        // Header Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Explore Cafés",
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.location5,
                                      size: 14,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "Amsterdam, Netherlands",
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isMapView = !_isMapView;
                                    });
                                  },
                                  child: Container(
                                    height: 44.h,
                                    width: 44.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Icon(
                                      _isMapView ? Iconsax.menu_1 : Iconsax.map,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 44.h,
                                    width: 44.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Icon(
                                      Iconsax.filter,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Color(0xFF2D2D2D),
                            ),
                            decoration: InputDecoration(
                              hintText: "Search for cafés, coffee, location...",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.grey[400],
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(14),
                                child: Icon(
                                  Iconsax.search_normal,
                                  size: 22,
                                  color: Color(0xFF5C4033),
                                ),
                              ),
                              suffixIcon: Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF8B6914),
                                      Color(0xFF5C4033),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Iconsax.microphone,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: Container(
              height: 100.h,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.only(right: 12.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        gradient:
                            isSelected
                                ? LinearGradient(
                                  colors: [
                                    Color(0xFF8B6914),
                                    Color(0xFF5C4033),
                                  ],
                                )
                                : null,
                        color: isSelected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color:
                                isSelected
                                    ? Color(0xFF5C4033).withOpacity(0.3)
                                    : Colors.black.withOpacity(0.04),
                            blurRadius: isSelected ? 15 : 10,
                            offset: Offset(0, isSelected ? 6 : 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            categories[index]["icon"],
                            size: 20,
                            color:
                                isSelected ? Colors.white : Color(0xFF5C4033),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            categories[index]["label"],
                            style: GoogleFonts.roboto(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  isSelected ? Colors.white : Color(0xFF2D2D2D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Results Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF5C4033).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Iconsax.coffee,
                          size: 18,
                          color: Color(0xFF5C4033),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nearby Cafés",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          Text(
                            "${coffeeShops.length} places found",
                            style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.sort, size: 16, color: Color(0xFF5C4033)),
                        SizedBox(width: 6.w),
                        Text(
                          "Sort",
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5C4033),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Coffee Shop List
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final shop = coffeeShops[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: GestureDetector(
                  onTap: () {
                    _showCafeDetails(context, shop);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Image Section
                        Stack(
                          children: [
                            Container(
                              height: 180.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(shop["image"]),
                                ),
                              ),
                            ),

                            // Gradient Overlay
                            Container(
                              height: 180.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.4),
                                  ],
                                ),
                              ),
                            ),

                            // Top Badges
                            Positioned(
                              top: 16,
                              left: 16,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          shop["isOpen"]
                                              ? Color(0xFF4CAF50)
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        Text(
                                          shop["isOpen"]
                                              ? "Open Now"
                                              : "Closed",
                                          style: GoogleFonts.roboto(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      shop["priceRange"],
                                      style: GoogleFonts.roboto(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF5C4033),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Favorite Button
                            Positioned(
                              top: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    coffeeShops[index]["isFavorite"] =
                                        !shop["isFavorite"];
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    shop["isFavorite"]
                                        ? Iconsax.heart5
                                        : Iconsax.heart,
                                    size: 20,
                                    color:
                                        shop["isFavorite"]
                                            ? Colors.red
                                            : Color(0xFF5C4033),
                                  ),
                                ),
                              ),
                            ),

                            // Distance Badge
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Iconsax.location,
                                      size: 14,
                                      color: Color(0xFF5C4033),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      shop["distance"],
                                      style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D2D2D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Content Section
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name and Rating
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      shop["name"],
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2D2D2D),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFD700),
                                          Color(0xFFFF9800),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          shop["rating"].toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 12.h),

                              // Location
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE91E63).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Iconsax.location5,
                                      size: 14,
                                      color: Color(0xFFE91E63),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      shop["location"],
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        color: Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10.h),

                              // Time
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2196F3).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Iconsax.clock,
                                      size: 14,
                                      color: Color(0xFF2196F3),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    shop["openTime"],
                                    style: GoogleFonts.roboto(
                                      fontSize: 13.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    "•",
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "${shop["reviews"]} reviews",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16.h),

                              // Specialties
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.star,
                                        size: 14,
                                        color: Color(0xFF5C4033),
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        "Specialties",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF2D2D2D),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    children:
                                        (shop["specialties"] as List)
                                            .map(
                                              (specialty) => Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                  vertical: 8.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(
                                                        0xFF5C4033,
                                                      ).withOpacity(0.1),
                                                      Color(
                                                        0xFF8B6914,
                                                      ).withOpacity(0.1),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: Color(
                                                      0xFF5C4033,
                                                    ).withOpacity(0.2),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Iconsax.coffee,
                                                      size: 12,
                                                      color: Color(0xFF5C4033),
                                                    ),
                                                    SizedBox(width: 6.w),
                                                    Text(
                                                      specialty,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color(
                                                          0xFF5C4033,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.h),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 14.h,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF8B6914),
                                              Color(0xFF5C4033),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(
                                                0xFF5C4033,
                                              ).withOpacity(0.3),
                                              blurRadius: 12,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Iconsax.coffee,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "Order Now",
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF4CAF50,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Color(
                                            0xFF4CAF50,
                                          ).withOpacity(0.3),
                                        ),
                                      ),
                                      child: Icon(
                                        Iconsax.call,
                                        size: 20,
                                        color: Color(0xFF4CAF50),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF2196F3,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Color(
                                            0xFF2196F3,
                                          ).withOpacity(0.3),
                                        ),
                                      ),
                                      child: Icon(
                                        Iconsax.routing,
                                        size: 20,
                                        color: Color(0xFF2196F3),
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
                ),
              );
            }, childCount: coffeeShops.length),
          ),

          // Bottom Padding
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),

      // Floating Action Button for current location
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8B6914), Color(0xFF5C4033)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF5C4033).withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            determinePosition();
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: Icon(Iconsax.gps, color: Colors.white),
          label: Text(
            "Near Me",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showCafeDetails(BuildContext context, Map<String, dynamic> shop) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    // Handle
                    Container(
                      margin: EdgeInsets.only(top: 12.h),
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // Image
                    Container(
                      margin: EdgeInsets.all(20.w),
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(shop["image"]),
                        ),
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  shop["name"],
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D2D2D),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFD700),
                                      Color(0xFFFF9800),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      shop["rating"].toString(),
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

                          SizedBox(height: 8.h),

                          Text(
                            "${shop["reviews"]} reviews",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Colors.grey[500],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Info Cards
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoCard(
                                  icon: Iconsax.location,
                                  color: Color(0xFFE91E63),
                                  title: "Location",
                                  value: shop["distance"],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildInfoCard(
                                  icon: Iconsax.clock,
                                  color: Color(0xFF2196F3),
                                  title: "Hours",
                                  value: shop["isOpen"] ? "Open" : "Closed",
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildInfoCard(
                                  icon: Iconsax.wallet,
                                  color: Color(0xFF4CAF50),
                                  title: "Price",
                                  value: shop["priceRange"],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          // Description
                          Text(
                            "About",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "A cozy café known for its exceptional coffee and warm atmosphere. Perfect for work, meetings, or simply enjoying a peaceful moment with your favorite brew.",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              height: 1.6,
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Contact
                          Text(
                            "Contact",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAF8F5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF4CAF50,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Iconsax.call,
                                        size: 18,
                                        color: Color(0xFF4CAF50),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      shop["contact"],
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        color: Color(0xFF2D2D2D),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFFE91E63,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Iconsax.location,
                                        size: 18,
                                        color: Color(0xFFE91E63),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        shop["location"],
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          color: Color(0xFF2D2D2D),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Action Button
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF8B6914),
                                    Color(0xFF5C4033),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF5C4033).withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.coffee, color: Colors.white),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "Order Now",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: color),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: GoogleFonts.roboto(fontSize: 11.sp, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
