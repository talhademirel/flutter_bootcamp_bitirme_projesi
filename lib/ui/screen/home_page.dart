import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitirme_projesi/constant/colors.dart';
import 'package:flutter_bitirme_projesi/ui/cubit/home_page_cubit.dart';
import 'package:flutter_bitirme_projesi/ui/screen/foods_page.dart';
import 'package:flutter_bitirme_projesi/ui/screen/products_page.dart';
import 'package:flutter_bitirme_projesi/ui/widget/category_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' hide Marker;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> mapControl = Completer();
  LatLng? latLng;
  Placemark? address;

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    locationData = await location.getLocation();
    var latitude = locationData.latitude!;
    var longitude = locationData.longitude!;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    setState(() {
      latLng = LatLng(latitude, longitude);
      address = placemarks[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    context.read<HomePageCubit>().getCategorys();
  }

  var pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.purple,
        centerTitle: true,
        title: Text(
          "Getir",
          style: TextStyle(color: ColorConstant.yellow),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 55,
              width: double.infinity,
              color: ColorConstant.yellow,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorConstant.white,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ev, ",
                              style: TextStyle(
                                  color: ColorConstant.purple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          address == null
                              ?  Container(
                                  alignment: Alignment.center,
                                  child: Lottie.asset("assets/loading-dots.json"))
                              : Expanded(
                                  child: Text(
                                      "${address?.street}, ${address?.thoroughfare} No:${address?.subThoroughfare}, ${address?.subAdministrativeArea}/${address?.administrativeArea}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                ),
                          Align(child: IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down,color: ColorConstant.purple,))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Center(child: Text("9dk",style: TextStyle(color: ColorConstant.purple,fontSize: 20,fontWeight: FontWeight.bold),)))
                ],
              ),
            ),
            SizedBox(
                height: 200,
                child: latLng == null
                    ? Lottie.asset("assets/location-pointer.json")
                    : GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: latLng!, zoom: 15),
                        zoomControlsEnabled: false,
                        markers: {
                          Marker(
                            markerId: const MarkerId("currentLocation"),
                            position: latLng!,
                          ),
                        },
                        onMapCreated: (GoogleMapController controller) {
                          mapControl.complete(controller);
                        },
                      )),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Kategoriler",
                    style: TextStyle(
                        color: Color(0xFF292423),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            BlocBuilder<HomePageCubit, List<QueryDocumentSnapshot>>(
              builder: (context, categoryList) {
                if (categoryList.isNotEmpty) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, mainAxisSpacing: 12),
                    itemCount: categoryList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var category = categoryList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    if(int.parse(category.id) == 0){
                                      return FoodPage(id: category.id);
                                    }else{
                                      return ProductsPage(id:int.parse(category.id));
                                    }
                                  },));
                        },
                        child: CategoryCardWidget(
                          image_url: category["imageUrl"],
                          category_name: category["name"],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Nothing"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
