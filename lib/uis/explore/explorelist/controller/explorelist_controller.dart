import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/explorelist/model/home_page_model.dart';
import 'package:plusone/uis/explore/map/model/mapmodel.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import 'dart:ui' as ui;


class ExploreListController extends GetxController {


  /// for map in home page
  GoogleMapController? mapController;
  Rxn<loc.LocationData> currentLocation = Rxn<loc.LocationData>();
  final LatLng initialPosition = LatLng(52.3731, 4.8922);
  PanelController panelController = PanelController();
  var bottomBarOffset = 0.99.obs;
  var scrollUpCount = 0.obs;
  var isTop = true.obs;
  double calculateBottomBarOffset({String? from}) {
    String fr = from ?? '';
    const maxOffset = 50.0;
    return ( (fr == 'FAB' ? (bottomBarOffset.value > 0.0 ? 1 : 1.2) : 1) - bottomBarOffset.value) * maxOffset;
  }

  void handleScroll() {

    print('scroll position == ${scrollController.position.pixels}   ${scrollController.position.minScrollExtent}  ${scrollController.position.userScrollDirection}');
    if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent || scrollController.position.pixels <=
        scrollController.position.minScrollExtent ) {
      print('c');

      if(scrollController.position.pixels ==
          scrollController.position.minScrollExtent){
        Future.delayed(const Duration(seconds: 1),() => isTop.value = true);
      }

      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        print('here');
        scrollUpCount.value++;
        print('scroll value == ${scrollUpCount.value}');

        if (scrollUpCount.value == 2) {

          panelController.animatePanelToPosition(0,duration: Duration(milliseconds: 500));
          scrollUpCount.value = 0;
          isTop.value = false;
        }
      }
    } else {
      isTop.value = false;
      scrollUpCount.value = 0;
    }
  }


  Future<void> getUserLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final userLocation = await location.getLocation();
    currentLocation.value = userLocation;

    // Move the camera to the user's location
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userLocation.latitude!, userLocation.longitude!),
          zoom: 15,
        ),
      ),
    );
  }


  var mapData = MapModel().obs;
  Future<void> getMap() async{
    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };
    try{
      final response = await api.get(EndPoints.mapicons,headers: header);
      print(response.body);
      if(response.statusCode == 200){
        mapData.value = MapModel.fromJson(response.body);
        print('map == ${mapData.value}');
        // await addMarkers();
      }else{
      }
    }catch(e){
      print('map error == ${e.toString()}');
    }
  }


  Set<Marker> markers = <Marker>{}.obs;

  Future<void> addMarkers() async {
    final List<Activity>? results = homeData.value.result?.activities;
    if (results != null) {
      markers.clear();
      for (var i in results) {
        print('lat == ${i.latitude} long == ${i.longitude}');
        final latitude = double.tryParse(i.latitude ?? '');
        final longitude = double.tryParse(i.longitude ?? '');

        if (latitude != null && longitude != null) {
          final icon = await getCustomIcon(i.subcategoryIcon ?? '');
          final marker = Marker(
            markerId: MarkerId(i.id.toString()),
            position: LatLng(latitude, longitude),
            icon: icon,
            infoWindow: InfoWindow(title: i.name),
            onTap: () {
              print('id == ${i.id}    ${i.hostId}');
              if(i.hostId.toString() == LocalStorage.getUid()){
                Get.toNamed(Routes.hostUpcommingActiview, arguments: i.id.toString());
              }else {
                Get.toNamed(
                    Routes
                        .exploreView,
                    arguments: i.id.toString()
                );
              }
            },
          );
          markers.add(marker);
        }
      }
      update();
    }
  }

  Future<BitmapDescriptor> getCustomIcon(String iconUrl) async {
    try {
      final ByteData byteData = await NetworkAssetBundle(Uri.parse(iconUrl)).load("");
      final Uint8List bytes = byteData.buffer.asUint8List();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ui.Image image = frameInfo.image;

      final double size = 100.0;
      final double circleRadius = size / 2;
      final double whiteCircleRadius = circleRadius * 0.9;
      final double imageSize = whiteCircleRadius;

      final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);
      final Paint yellowPaint = Paint()..color = clrYellow;
      final Paint whitePaint = Paint()..color = Colors.white;

      canvas.drawCircle(Offset(circleRadius, circleRadius), circleRadius, yellowPaint);

      canvas.drawCircle(Offset(circleRadius, circleRadius), whiteCircleRadius, whitePaint);

      final ui.Rect imageRect = Rect.fromLTWH(
        (size - imageSize) / 2,
        (size - imageSize) / 2,
        imageSize,
        imageSize,
      );
      final ui.Paint imagePaint = Paint()..filterQuality = ui.FilterQuality.high;
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        imageRect,
        imagePaint,
      );

      final ui.Image img = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
      final ByteData? byteDataPng = await img.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List uint8List = byteDataPng!.buffer.asUint8List();

      return BitmapDescriptor.fromBytes(uint8List);
    } catch (e) {
      log('Error fetching icon: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }


  /// map home page



  ScrollController scrollController = ScrollController();
  RxBool showRefreshIndicator = true.obs;

  @override
  void onInit() {
    super.onInit();
    homePageApi();
    // scrollController.addListener(handleScroll);
    getMap();
    getUserLocation();
    api.tt();
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);
  RefreshController refreshController1 = RefreshController(initialRefresh: false);

  final api = ApiServices();
  var homePageLoading = false.obs;
  var homeData = HomePageModal().obs;
  var homeError = ''.obs;
  Rx<String?> categoryID = Rx<String?>(null);

  var selectedIndex = 0.obs;

  var allLoading = false.obs;

  Future<void> homePageApi() async{

    Map body = {
      'category_id': categoryID.value,
      'user_id': LocalStorage.getUid(),
    };

    print(body);
    print(EndPoints.homePage);
    print(LocalStorage.getToken());

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    homePageLoading.value = true;

    try{
      final response = await api.post(EndPoints.homePage, body,headers: header);
      print(response.statusCode);
      if(response.statusCode == 200){
        homeError.value = '';
        print('home data == ${response.body}');
        homeData.value = HomePageModal.fromJson(response.body);
        addMarkers();
      } else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        // showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('error == ${response.body}');
        homeError.value = 'ERROR';
        homeData.value = HomePageModal();
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      homeError.value = e.toString();
      homeData.value = HomePageModal();
    }

    homePageLoading.value = false;

  }


  RxList<Widget> wrapWidList = <Widget>[].obs;

  RxList<Map> categoryFilter = [
    {
      "img": "assets/icons/sportsicon.png",
      "lable": "Sports",
      "isChecked": 0,
      "value": ""
    },
    {
      "img": "assets/icons/artsicon.png",
      "lable": "Arts",
      "isChecked": 0,
      "value": ""
    },
  ].obs;

  RxInt isReqSent = 0.obs;

  changeReqSent(intval) {
    isReqSent.value = intval;
  }


  bool? isFavs = false;

  Future<bool?> changeFavApi(String? id) async{

    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };


    try{
      final response = await api.post(EndPoints.changeFavurl, body,headers: header);
      if(response.statusCode == 200){
        isFavs = true;
        print('change data == ${response.body}');
        log(isFavs.toString());
        return isFavs;
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('error == ${response.body}');
        return false;
      }
    }catch(e){
      print('changeFav api error == ${e.toString()}');
      return false;

    }
     

  }

  changeIndicator(index, currentIndex) {
    homeData.value.result!.activities?[index].circleIndex?.value = currentIndex;
  }

  showHomePop() async {
    Future.delayed(Duration.zero, () {
      return Get.dialog(AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          contentPadding:
              const EdgeInsets.only(left: 18,right: 18, top: 20,bottom: 30),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                    )),
                Center(
                  child: Image.asset(
                    "assets/icons/hifyicon.png",
                    height: 49,
                    width: 90,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Center(
                    child: Text(
                  "Welcome! Let’s get started",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
                SizedBox(
                  height: Get.height * 0.012,
                ),
                const Center(
                  child: Text(
                    "To join activities, please become a PlusOnes member and complete your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Nunito'),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                GestureDetector(
                  onTap: () {
                    if(homeData.value.result?.membershipStatus == true){

                    }else {
                      Get.toNamed(Routes.mymembershipProUi)?.then((value) {
                        homePageApi();
                      },);
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:  homeData.value.result?.membershipStatus == true ? Border.all(
                          color: clrGreyLight
                        ) : null,
                        color:  homeData.value.result?.membershipStatus == true ? clrWhite :clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/tajicon.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text(
                                "Become a member",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                              )),
                              homeData.value.result?.membershipStatus == true ? Image.asset('assets/images/check.png',height: 20) : Image.asset('assets/icons/arrow right.png',height: 14,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    if(homeData.value.result?.profileComplete == true){

                    }else {
                      Get.toNamed(Routes.myprofileInnUi)?.then((value) {
                        homePageApi();
                      },);
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                      border: homeData.value.result?.profileComplete == true ? Border.all(
                        color: clrGreyLight
                      ) : null,
                        borderRadius: BorderRadius.circular(50),
                        color: homeData.value.result?.profileComplete == true ? clrWhite : clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/person.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text("Complete profile",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
                              homeData.value.result?.profileComplete == true ? Image.asset('assets/images/check.png',height: 20) : Image.asset('assets/icons/arrow right.png',height: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
    });
  }

//******************************--- explore filter ----*************
  Rx<String> filterDateStart = "".obs;
  Rx<String> filterDateCalenderStart = "".obs;

  Rx<String> filterDateEnd = "".obs;
  Rx<String> filterDateCalenderEnd = "".obs;

  changeFilterDate(DateTimeRange newDob) {
    log("gk newDob=${newDob}");
    filterDateStart.value = DateFormat("dd/MM/yyyy").format(newDob.start);
    filterDateCalenderStart.value =
        DateFormat("yyyy-MM-dd").format(newDob.start);

    filterDateEnd.value = DateFormat("dd/MM/yyyy").format(newDob.end);
    filterDateCalenderEnd.value = DateFormat("yyyy-MM-dd").format(newDob.end);
  }

  RxBool hideWaitListAct = false.obs;

  changeHideWaitListAct() {
    hideWaitListAct.value = !hideWaitListAct.value;
  }

  RxInt groupSize = 1.obs;

  incGroupSize() {
    if (groupSize.value < 10) {
      groupSize.value += 1;
    }
  }

  decGroupSize() {
    if (groupSize.value > 1) {
      groupSize.value -= 1;
    }
  }

  RxList categryList = [
    {
      "id": 0,
      'image': "assets/icons/sportsicon.png",
      'lbl': "Sports",
      'isSelected': false,
    },
    {
      "id": 1,
      'image': "assets/icons/artsicon.png",
      'lbl': "Arts",
      'isSelected': false,
    },
    {
      "id": 2,
      'image': "assets/icons/learningicon.png",
      'lbl': "Learning",
      'isSelected': false,
    },
    {
      "id": 3,
      'image': "assets/icons/mp3icon.png",
      'lbl': "Entertainment",
      'isSelected': false,
    },
    {
      "id": 4,
      'image': "assets/icons/eatdrinkicon.png",
      'lbl': "Eats & drinks",
      'isSelected': false,
    },
    {
      "id": 5,
      'image': "assets/icons/eatdrinkicon.png",
      'lbl': "Eats & drinks",
      'isSelected': false,
    },
    {
      "id": 6,
      'image': null,
      'lbl': "All",
      'isSelected': false,
    }
  ].obs;

  selectCategory(id) {
    print("id=$id)");
    for (int i = 0; i < categryList.value.length; i++) {
      if (categryList.value[i]['id'] == id) {
        categryList.value[i]['isSelected'] =
            !categryList.value[i]['isSelected'];
      }
    }
    categryList.refresh();
  }

  RxMap dateFilter = {
    "pickRange": false,
    "today": false,
    "tomorrow": false,
    "week": false,
    "weekend": false,
  }.obs;

  changeDateFilter(name) {
    dateFilter.value[name] = !dateFilter.value[name];
    dateFilter.refresh();
  }

  RxInt timeFilter = 0.obs;

  changeTimeFilter(val) {
    timeFilter.value = val;
  }

  RxInt genderFilter = 0.obs;

  changeGenderFilter(val) {
    genderFilter.value = val;
  }

  //******************************--- clear filter ----*************
  resetForm() {
    categryList.value = <Map<String, Object?>>[
      {
        "id": 0,
        'image': "assets/icons/sportsicon.png",
        'lbl': "Sports",
        'isSelected': false,
      },
      {
        "id": 1,
        'image': "assets/icons/artsicon.png",
        'lbl': "Arts",
        'isSelected': false,
      },
      {
        "id": 2,
        'image': "assets/icons/learningicon.png",
        'lbl': "Learning",
        'isSelected': false,
      },
      {
        "id": 3,
        'image': "assets/icons/mp3icon.png",
        'lbl': "Entertainment",
        'isSelected': false,
      },
      {
        "id": 4,
        'image': "assets/icons/eatdrinkicon.png",
        'lbl': "Eats & drinks",
        'isSelected': false,
      },
      {
        "id": 5,
        'image': "assets/icons/eatdrinkicon.png",
        'lbl': "Eats & drinks",
        'isSelected': false,
      },
      {
        "id": 6,
        'image': null,
        'lbl': "All",
        'isSelected': false,
      }
    ];
    dateFilter.value = <String, bool>{
      "pickRange": false,
      "today": false,
      "tomorrow": false,
      "week": false,
      "weekend": false,
    };
    groupSize.value = 1;
    timeFilter.value = 0;
    genderFilter.value = 0;
    hideWaitListAct.value = false;
    filterDateStart.value = "";
    filterDateCalenderStart.value = "";
    filterDateEnd.value = "";
    filterDateCalenderEnd.value = "";
  }
}
