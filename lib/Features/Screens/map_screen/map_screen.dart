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

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapBoxController;
  double? latitude;
  double? longitude;
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/logo/logo_kivaloop.png", width: 120),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  // ShadInput(
                  //   leading: const Padding(
                  //     padding: EdgeInsets.all(4.0),
                  //     child: Icon(LucideIcons.coffee),
                  //   ),
                  //   decoration: ShadDecoration(
                  //     border: ShadBorder.all(color: Colors.black),
                  //   ),
                  //   placeholder: Text('Search Coffee shop'),
                  //   keyboardType: TextInputType.emailAddress,
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      child: Column(
                        spacing: 8.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150.h,
                            width: double.infinity,
                            color: Colors.grey.shade400,
                          ),

                          Text(
                            "Name of the Cafe",
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Iconsax.location),
                              Text(
                                "Cafe location",
                                style: GoogleFonts.roboto(fontSize: 12.sp),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Iconsax.watch),
                              Text(
                                "Time of cafe openning",
                                style: GoogleFonts.roboto(fontSize: 12.sp),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Icon(Iconsax.mobile),
                              Text(
                                "Contact No of the cafe",
                                style: GoogleFonts.roboto(fontSize: 12.sp),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sppecialities",
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Wrap(
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    Container(
                                      margin: EdgeInsets.only(right: 5.w),
                                      color: Colors.grey.shade400,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Special item 1",
                                          style: GoogleFonts.roboto(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),

                          ElevatedButton(
                            child: Row(
                              spacing: 15.w,
                              children: [
                                Icon(Iconsax.coffee),
                                Text(
                                  'Order Now',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Expanded(
            //   child:
            //       (latitude != null && longitude != null)
            //           ? MapWidget(
            //             styleUri: MapboxStyles.DARK,
            //             key: const ValueKey("mapWidget"),
            //             cameraOptions: CameraOptions(
            //               center: Point(
            //                 coordinates: Position(latitude!, longitude!),
            //               ),
            //               zoom: 14.0,
            //             ),
            //             onMapCreated: (MapboxMap controller) {
            //               setState(() {
            //                 mapBoxController = controller;
            //               });
            //               // You can store the mapboxMap reference if needed for later use
            //               mapBoxController?.location.updateSettings(
            //                 LocationComponentSettings(
            //                   enabled: true,
            //                   pulsingEnabled: true,
            //                 ),
            //               );
            //             },
            //           )
            //           : Center(child: CircularProgressIndicator()),
            // ),
          ],
        ),
      ),
    );
  }
}
