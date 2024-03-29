
import 'package:pujapurohit/Utils/Imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../profile.dart';
class AddressPage extends StatefulWidget{

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  LocationController locationController = Get.find();
  //_______________________________Maps Code ___________________________________//
  GoogleMapController? googleMapController;
  BitmapDescriptor? mapMarker;
  String addresss = "Open Map";
  String? alternate_no;
  String? name;
  String? lati;
  String? long;
  List<Marker> myMarker =[];
  void customMarker()async{
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(20, 20)),'assets/mark.png');
  }
  _handleTap(LatLng tappedPoint)async{
   String address = await AsistentMethod.searchCoordinateAddress(tappedPoint.latitude.toString(),tappedPoint.longitude.toString());

    setState(() {
      addresss = address;
      locationController.location.value.blat = tappedPoint.latitude;
      locationController.location.value.blng = tappedPoint.longitude;
      myMarker=[];
      myMarker.add(
          Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            icon: mapMarker!,
          )
      );
    });
    Get.back();
    Get.snackbar("Location Picked", "${addresss}",snackPosition: SnackPosition.BOTTOM,padding: EdgeInsets.all(30),backgroundColor: Colors.black54,colorText: Colors.white);
  }

  //____________________________________End Maps Code __________________________//
  DateTime _currentdate=DateTime.now().add(Duration(days: 2));
  DateTime dt=DateTime.now().add(Duration(days: 2));
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  Future time()async{
    TimeOfDay? newTime = await showRoundedTimePicker(
      theme: ThemeData(
          primaryColor: LightColors.kDarkYellow,
          primarySwatch: Colors.orange),

      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        dt = DateTime(
          dt.year,
          dt.month,
          dt.day,
          newTime.hour,
          newTime.minute,
        );
      });
    }
  }
  Future<DateTime?> datee()async{
    DateTime? newDateTime =await showRoundedDatePicker(context: context,
      listDateDisabled: [
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
        DateTime.now().subtract(Duration(days: 1)),
        DateTime.now().subtract(Duration(days: 2)),
        DateTime.now().subtract(Duration(days: 3)),
        DateTime.now().subtract(Duration(days: 4)),
        DateTime.now().subtract(Duration(days: 5)),
        DateTime.now().subtract(Duration(days: 6)),DateTime.now().subtract(Duration(days: 7)),
        DateTime.now().subtract(Duration(days: 8)),
        DateTime.now().subtract(Duration(days: 9)),
        DateTime.now().subtract(Duration(days: 10)),
        DateTime.now().subtract(Duration(days: 11)),
        DateTime.now().subtract(Duration(days: 12)),
        DateTime.now().subtract(Duration(days: 13)),
        DateTime.now().subtract(Duration(days: 14)),
        DateTime.now().subtract(Duration(days: 15)),
        DateTime.now().subtract(Duration(days: 16)),
        DateTime.now().subtract(Duration(days: 17)),
        DateTime.now().subtract(Duration(days: 18)),
        DateTime.now().subtract(Duration(days: 19)),
        DateTime.now().subtract(Duration(days: 20)),
        DateTime.now().subtract(Duration(days: 21)),
        DateTime.now().subtract(Duration(days: 22)),
        DateTime.now().subtract(Duration(days: 23)),
        DateTime.now().subtract(Duration(days: 24)),
        DateTime.now().subtract(Duration(days: 25,)),
      ],
      theme: ThemeData(
          primaryColor: LightColors.kDarkYellow,
          primarySwatch: Colors.orange),
      height: 300,
      initialDate: DateTime.now().add(Duration(days: 2)),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,

    );
    if(newDateTime!=null){
      setState(() {
        _currentdate=newDateTime;
      });
    }

  }
  @override
  void initState() {
    customMarker();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String _formatdate= DateFormat.yMMMd().format(_currentdate);
    String _timeformat=DateFormat.jm().format(dt);
   return Scaffold(
     key: _key,
     resizeToAvoidBottomInset: false,
     body: Stack(
       children: [
         GetX<LocationController>(
           init: Get.put<LocationController>(LocationController()),
           builder: (LocationController locationController){
             return SafeArea(
               child: Padding(
                 padding: EdgeInsets.only(left:25.0,right: 25,top: height*0.05),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       height:50,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(flex: 1,child: Text1(data: "Name:", max: 12, min: 11)),
                           Expanded(
                             flex: 2,
                             child: TextFormField(
                               style: GoogleFonts.aBeeZee(),
                               initialValue: authController.user!.displayName,

                               decoration: new InputDecoration(

                                 hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12,),
                                 hintText: "Your Name",
                               ),
                              onChanged: (value){
                                 setState(() {
                                   name = value;
                                 });
                              },
                              //controller: name,
                             ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       height:50,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(flex: 1,child: Text1(data: "Alternate No.:", max: 12, min: 11)),
                           Expanded(
                             flex: 2,
                             child: TextFormField(
                               keyboardType: TextInputType.number,
                               decoration: new InputDecoration(
                                 hintStyle: GoogleFonts.aBeeZee(color:Colors.black54,fontSize:12,),
                                 hintText: "+91",
                               ),
                              onChanged: (value){
                                 setState(() {
                                   alternate_no = value;
                                 });
                              },
                             ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       height:50,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(flex: 1,child: Text1(data: "Pick Booking Time: ", max: 12, min: 11)),
                           Expanded(
                             flex: 2,
                             child: Row(
                               children: [
                                 Text1(data: "${_timeformat}", max: 12, min: 11,clr: Colors.black54,),
                                 SizedBox(width: 5,),
                                 IconButton(onPressed: (){time();}, icon: Icon(Icons.watch_later_outlined),color: Colors.orangeAccent,iconSize: 16,)
                               ],
                             )
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       height:50,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(flex: 1,child: Text1(data: "Pick Booking Date: ", max: 12, min: 11)),
                           Expanded(
                               flex: 2,
                               child: Row(
                                 children: [
                                   Text1(data: "${_formatdate}", max: 12, min: 11,clr: Colors.black54,),
                                   SizedBox(width: 5,),
                                   IconButton(onPressed: (){datee();}, icon: Icon(CupertinoIcons.calendar_badge_plus),color: Colors.orangeAccent,iconSize: 16,)
                                 ],
                               )
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: 10,),
                     Container(
                       height: 60,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Expanded(flex: 1,child: Text1(data: "Pick Address: ", max: 12, min: 11)),
                           Expanded(
                               flex: 2,
                               child: InkWell(
                                 onTap: (){
                                   

                                  Get.bottomSheet(locationChnage(),enableDrag: false);
                                 },
                                 child: Row(
                                   children: [
                                     Expanded(
                                         flex:3,
                                         child: Text1(data: "${addresss}", max: 12, min: 11,clr: Colors.black54,)),
                                     SizedBox(width: 5,),
                                     Expanded(
                                       flex: 1,
                                         child: Icon(CupertinoIcons.map_pin,color: Colors.green,size:16,))
                                   ],
                                 ),
                               )
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
         Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Container(
               height: height*0.4,
               width: double.infinity,
               decoration: BoxDecoration(
                   image: DecorationImage(
                       image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/New%20App%2Faddress.png?alt=media&token=6f4a0150-3a42-49f4-b12b-b4cfd61450a2'),
                       fit: BoxFit.contain
                   )
               ),
             ),
             SizedBox(height:10),

           ],
         ),
         Positioned(
           right: 20,
           bottom: 20,
           child: FloatingActionButton(
               backgroundColor: Colors.orangeAccent,
               elevation: 0,
               onPressed:(){
                  FareBreakup fare = Get.put(FareBreakup());

                 if(addresss == "Open Map"){
                   Get.defaultDialog(title: "Address Error",middleText: "Please pick your address of booking");
                 }

                 else{
                   if(alternate_no == null){
                     Get.defaultDialog(title: "Number Missing",middleText: "Please add your alternate number");
                   }
                   else{
                     fare.address(locationController.location.value.blat,locationController.location.value.blat,addresss, _formatdate, _timeformat,name==null?authController.user!.displayName:name, authController.user!.photoURL, authController.user!.phoneNumber,alternate_no,authController.user!.uid);
                     Get.toNamed('/samagri?keyword=${Get.parameters['keyword']}');
                   }
                 }
               },
               child:Text('Next')
           ),
         ),
       ],
     ),
   );
  }
  Container locationChnage(){
    double height = Get.height;
    double width = Get.width;
    // void findPlace(String place)async{
    //   if(place.length>1){
    //     String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=delhi&key=AIzaSyCQYFsjixY_xVVx48e_iDVKmaPjhBD7Km8&sessiontoken=1234567890";
    //     var res = await RequestAssistent.getRequest(autoCompleteUrl);
    //     if(res == "failed"){
    //       return;
    //     }
    //     print("Places prediction respose:");
    //     print(res);
    //   }
    // }
   UserController userController = Get.put(UserController());
    return Container(
      width: Get.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Center(
                  child: Container(
                      width: width,
                      child:
                      GoogleMap(
                        onMapCreated: (controller) => googleMapController = controller,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(zoom: 14,target: LatLng(double.parse('${userController.userModel.value.lat}'),double.parse('${userController.userModel.value.lng}')),tilt: 50 ),
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: true,
                        markers:Set.from(myMarker),
                        onTap: _handleTap,
                      ),

                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class Samagri extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String keyword = '#${Get.parameters['keyword']}';
    final AuthController authController = Get.find();
    final LocationController locationController = Get.find();
    return Scaffold(
      body: SafeArea(
        child: GetX<SamagriController>(
          init: Get.put(SamagriController(lat: locationController.location.value.blat,lng: locationController.location.value.blng)),
          builder: (SamagriController samagriController){
           if(samagriController !=null && samagriController.pandits != null){
            return samagriController.select.value.yesSamagri?
             Stack(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: SingleChildScrollView(
                     scrollDirection: Axis.vertical,
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             ElevatedButton(onPressed: (){samagriController.select.value.vendorSelected?samagriController.vendor():samagriController.updateyes();}, child: Text1(data: samagriController.select.value.vendorSelected?"Change Vendor":"Remove Samagri",max: 12,min: 11,clr: Colors.grey,),style: ElevatedButton.styleFrom(
                                 shape: StadiumBorder(),primary: Colors.white,elevation: 0.5
                             ),),
                             SizedBox(width: 5,),
                             samagriController.select.value.vendorSelected?ElevatedButton(onPressed: (){samagriController.updateyes();}, child: Text1(data:"Remove Samagri",max: 12,min: 11,clr: Colors.grey,),style: ElevatedButton.styleFrom(
                                 shape: StadiumBorder(),primary: Colors.white,elevation: 0.5
                             ),):SizedBox(),

                           ],),
                       SizedBox(height: 15,),
                       samagriController.select.value.vendorSelected?
                       Container(
                         height: height*0.85,
                         child: SamagriCustomization(Vendoruid: samagriController.select.value.vendoruid!,Keyword: keyword,),
                       ):SizedBox(),
                         SizedBox(height: 20,),
                         samagriController.select.value.vendorSelected?SizedBox():Text1(data: "Available Vendors", max: 20, min: 18,clr: Colors.grey,weight: FontWeight.w600,),
                         SizedBox(height: 20,),
                        samagriController.select.value.vendorSelected?SizedBox():Container(
                           height: height*0.7,
                           child: ListView.builder(
                               scrollDirection: Axis.vertical,
                               shrinkWrap: true,
                               itemCount: samagriController.panditList.value!.length, itemBuilder: (BuildContext context, int index) {
                             return VendorsTile(samagriController.pandits![index],samagriController,authController);
                           }
                           ),
                         ),


                       ],
                     ),
                   ),
                 ),
                samagriController.select.value.vendorSelected?SizedBox():SizedBox(),
                 Padding(
                   padding: const EdgeInsets.only(left:20.0,top: 20),
                   child: Align(
                     alignment: Alignment.topLeft,
                     child: InkWell(
                       onTap: (){
                         Get.back();
                       },
                       child: Icon(Icons.arrow_back_ios,size: 25,color: Colors.grey,),
                     ),
                   ),
                 )
               ],
             )
                 :
             Stack(
               children: [
                 Column(
                   children: [
                     Container(
                       height: height*0.67,
                       width: double.infinity,
                       decoration: BoxDecoration(
                           image: DecorationImage(
                               image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter-bf503.appspot.com/o/New%20App%2Fsamagri.png?alt=media&token=9ae37aac-a527-44a8-bc26-4257152abdf4'),
                               fit: BoxFit.contain
                           )
                       ),
                     ),
                     SizedBox(height:10),
                     Padding(
                       padding: const EdgeInsets.only(left:12.0,right: 12),
                       child: samagriController.panditList.value!.isEmpty?
                       Text1(data: "Notice:\nBook your purohit and kindly arrange samgari by your own as listed in the samagri detail section.\n*Sorry for inconvenience no vendor is currently available in your locality, so you can not avail this facility as of now. We are working on it.\nTeam Puja Purohit\nClick on 'Skip' and continue your purohit booking.", max: 12, min: 11,clr: Colors.black54,)
                           :
                       Text1(data: "Don't waste your time on market to find samagri.\nWe are here to deliver it to your home.", max: 12, min: 11,clr: Colors.black54,),
                     ),
                     SizedBox(height:20),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         ElevatedButton(onPressed: (){
                           samagriController.panditList.value!.isEmpty?
                           Get.defaultDialog(title: "Notice",middleText: "Book your purohit and kindly arrange samgari by your own as listed in the samagri detail section.\n*Sorry for inconvenience no vendor is currently available in your locality, so you can not avail this facility as of now. We are working on it\nTeam Puja Purohit",
                               backgroundColor: Colors.white,titleStyle: GoogleFonts.aBeeZee(color: Colors.black87,fontSize: 15,wordSpacing: 2,),middleTextStyle:GoogleFonts.aBeeZee(color: Colors.black87,fontSize: 12,wordSpacing: 2,) )
                               :samagriController.updateyes();
                         }, child: Text1(data: samagriController.panditList.value!.isEmpty?"Request for vendor":"Add Samagri",max: 12,min: 11,clr: Colors.white,),style: ElevatedButton.styleFrom(
                             shape: StadiumBorder(),primary: Colors.green,elevation:0.0
                         ),)

                       ],
                     )
                   ],
                 ),
                 Positioned(
                   right: 20,
                   bottom: 20,
                   child: FloatingActionButton(
                     backgroundColor: Colors.orangeAccent,
                     elevation: 0,
                     onPressed:(){
                       Get.toNamed('/booking?samagri=false');},
                     child: Text('Skip')
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:20.0,top: 20),
                   child: Align(
                     alignment: Alignment.topLeft,
                     child: InkWell(
                       onTap: (){
                         Get.back();
                       },
                       child: Icon(Icons.arrow_back_ios,size: 25,color: Colors.grey,),
                     ),
                   ),
                 )
               ],
             );
           }
           else{
             return Center(child: Loader(),);
           }
          },
        ),
      )
    );
  }

  GetX<VendorController> SamagriCustomize(SamagriController samagriController) {
    return GetX<VendorController>(
                       init: Get.put(VendorController(uid: samagriController.select.value.vendoruid!)),
                       builder: (VendorController vendorController){
                         return Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Expanded(
                               flex: 3,
                               child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children:[
                                     Text1(data: "${vendorController.userModel.value.name}", max: 18, min: 16,weight: FontWeight.bold),
                                     SizedBox(height:5),
                                     Text1(data: "${vendorController.userModel.value.district}, ${vendorController.userModel.value.state}", max: 11, min: 10,),
                                     SizedBox(height:5),
                                     Text1(data: "Offering:${vendorController.userModel.value.userDiscount}", max: 11, min: 10,),
                                   ]
                               ),
                             ),
                             Expanded(
                               flex: 1,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   Container(
                                     height:50,width: 80,
                                     decoration: BoxDecoration(
                                         boxShadow: [BoxShadow(color: Colors.white,blurRadius: 20)],
                                         color: Colors.white,
                                         shape: BoxShape.rectangle,
                                         image: DecorationImage(
                                             image: NetworkImage('${vendorController.userModel.value.image}'),
                                             fit: BoxFit.fill
                                         )
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         );
                       },
                     );
  }

  Widget VendorsTile(VendorModal vendorModal,SamagriController samagriController,AuthController authController){
    String keyword = '#${Get.parameters['keyword']}';
    final UserController userController = Get.put(UserController());
    GeoPoint geoPoint = vendorModal.location!['geopoint'];
    double distanceInMeters = Geolocator.distanceBetween(double.parse('${userController.userModel.value.lat}'),double.parse('${userController.userModel.value.lng}'), geoPoint.latitude, geoPoint.longitude);
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Vendors/${vendorModal.uid}/services').doc('$keyword').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return Center(child: Text1(data: "Loading", max: 12, min: 11,clr: Colors.grey,),);
        }
        if(snapshot.data!.exists){
          var disc=snapshot.data!.get('userDiscount');
          var price = snapshot.data!.get('price');
          var discount_money = (price*disc)/100;
          double new_price = price - discount_money;
          return vendorModal.status?InkWell(
            onTap: ()async{
              await FirebaseFirestore.instance.collection("Vendors/${vendorModal.uid}/services/${keyword}/items").get().then((value){
                                  value.docs.forEach((element) {
                                    FirebaseFirestore.instance.collection("users/${authController.user!.uid}/temp_booking/${keyword}/items").doc(element.data()['id']).set({
                                      'num':element.data()['num'],
                                      'name':element.data()['name'],
                                      'price':element.data()['price'],
                                      'id':element.data()['id'],
                                      'more':element.data()['more'],
                                      'quantity':element.data()['quantity'],
                                      'vendor_price':element.data()['vendor_price'],
                                    });
                                  });
                }).whenComplete(() {

                samagriController.addVendorUid('${vendorModal.uid}');
                samagriController.vendor();
                FareBreakup fareBreakup  = Get.put(FareBreakup());
                fareBreakup.addVendor(vendorModal.uid!,vendorModal.name!,snapshot.data!.get('discount')!,snapshot.data!.get('userDiscount'),vendorModal.token!,3.4);
              });


            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ListTile(
                leading: Image.network('${vendorModal.image}', scale: 5,filterQuality: FilterQuality.high,),

                title: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text1(data: "${vendorModal.name}",max: 14,min: 11,clr: Colors.black54,weight: FontWeight.w600,),
                     SizedBox(width:10),
                    
                      Text1(max: 14, data: '${(distanceInMeters/1000).toStringAsFixed(2)} KM', min: 11,clr: Colors.black54,weight: FontWeight.w600,),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text1(data: "Offering ${snapshot.data!.get('userDiscount')}% discount in rates",max: 10,min: 9,clr: Colors.green,),
                    Text1(data: "Fully Customizable samagri",max: 10,min: 9,clr: Colors.black54,),
                  ],
                ),
                trailing: Column(
                  children: [
                    Text('\₹${snapshot.data!.get('price')}',style:GoogleFonts.aBeeZee(color:Colors.redAccent,fontSize:12,decoration: TextDecoration.lineThrough)),
                    Text1(data: "\₹${new_price.roundToDouble()}",max: 12,min: 11,clr: Colors.green,weight: FontWeight.bold,),
                  ],
                ),
              ),
            ),
          ):
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ListTile(
              leading: ColorFiltered(
                  colorFilter: ColorFilter.matrix([
                    0.2126,0.7152,0.0722,0,0,
                    0.2126,0.7152,0.0722,0,0,
                    0.2126,0.7152,0.0722,0,0,
                    0,0,0,1,0
                  ]),
                  child: Image.network('${vendorModal.image}', scale: 5,filterQuality: FilterQuality.high,)),

              title: Text1(data: "${vendorModal.name}",max: 14,min: 11,clr: Colors.grey,weight: FontWeight.w600,),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text1(data: "Offering ${vendorModal.userDiscount*10}% discount in rates",max: 10,min: 9,clr: Colors.grey,),
                  Text1(data: "Currently unavailable",max: 10,min: 9,clr: Colors.grey,),
                ],
              ),
              trailing: Column(
                children: [
                  Text('\₹0.0',style:GoogleFonts.aBeeZee(color:Colors.redAccent,fontSize:12,decoration: TextDecoration.lineThrough)),
                    Text1(data: "\₹ 0.0",max: 12,min: 11,clr: Colors.green,weight: FontWeight.bold,),
                ],
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ListTile(
            leading: ColorFiltered(
                colorFilter: ColorFilter.matrix([
                  0.2126,0.7152,0.0722,0,0,
                  0.2126,0.7152,0.0722,0,0,
                  0.2126,0.7152,0.0722,0,0,
                  0,0,0,1,0
                ]),
                child: Image.network('${vendorModal.image}', scale: 5,filterQuality: FilterQuality.high,)),
            title: Text1(data: "${vendorModal.name}",max: 14,min: 11,clr: Colors.grey,weight: FontWeight.w600,),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text1(data: "Offering ${vendorModal.userDiscount*10}% discount in rates",max: 10,min: 9,clr: Colors.grey,),
                Text1(data: "Not in Stock",max: 10,min: 9,clr: Colors.redAccent,),
              ],
            ),
            trailing: Column(
              children: [
                Text('\₹ 0.0',style:GoogleFonts.aBeeZee(color:Colors.redAccent,fontSize:12,decoration: TextDecoration.lineThrough)),
                    Text1(data: "\₹ 0.0",max: 12,min: 11,clr: Colors.green,weight: FontWeight.bold,),
              ],
            ),
          ),
        );

      }
    );
  }

}
class SamagriData {
  bool yesSamagri;
  bool vendorSelected;
  String? vendoruid;
  SamagriData({required this.yesSamagri,required this.vendorSelected,this.vendoruid});
}

class SamagriController extends GetxController{
  final double lat;
  final double lng;
  SamagriController({required this.lat,required this.lng});
  Geoflutterfire geo = Geoflutterfire();

  double radius = 15;
  String field = 'location';
  var select = SamagriData(yesSamagri: false,vendorSelected: false).obs;
  var items = 0.obs;
  Rxn<List<VendorModal>> panditList = Rxn<List<VendorModal>>();

  List<VendorModal>? get pandits => panditList.value;
  @override
  void onInit(){
    panditList.bindStream(VendorStream());
    super.onInit();
  }
  Stream<List<VendorModal>> VendorStream() {
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
    final reference = FirebaseFirestore.instance.collection('Vendors');
    final stream = geo.collection(collectionRef: reference).within(center: center, radius: radius, field: field);

    return stream
        .map((query) {

      List<VendorModal> retVal = [];
      query.forEach((element) {
        retVal.add(VendorModal.fromSnapshot(element));
      });
      return retVal..shuffle();
    });
  }

  updateyes(){
    select.update((val) {
      val!.yesSamagri = val.yesSamagri?false:true;
    });

  }
  vendor(){
    select.update((val) {
      val!.vendorSelected = val.vendorSelected?false:true;
    });

  }
  addVendorUid(String vendorUid){
    select.update((val) {
      val!.vendoruid = vendorUid;
    });
    print(vendorUid);
  }

  updateItems(var item){
    items.value = item;
  }

}

class VendorController extends GetxController{
  final String uid;
  VendorController({required this.uid});
  Rx<VendorModal> userModel = VendorModal(status: false).obs;
  @override
  void onInit(){
    initializeVendorModel();
    super.onInit();
  }
  initializeVendorModel()  async{
    userModel.value =await FirebaseFirestore.instance
        .collection('Vendors')
        .doc('$uid')
        .get()
        .then((doc) => VendorModal.fromSnapshot(doc));
  }
}
class ItemsController extends GetxController{
 final String? Vendoruid;
 final String? keyword;
 ItemsController({this.Vendoruid,this.keyword});
  var samagri_total = 0.0.obs;
  Rxn<List<ItemsModel>> itemsList = Rxn<List<ItemsModel>>();
  final AuthController authController = Get.find();
  List<ItemsModel>? get items => itemsList.value;

  total(var total_price){
    samagri_total.update((val) {
      val = total_price;
    });
  }
  @override
  void onInit(){
    itemsList.bindStream(itemsStream());
    super.onInit();
  }
  Stream<List<ItemsModel>> itemsStream() {
    return FirebaseFirestore.instance
        .collection("Vendors")
        .doc("$Vendoruid")
        .collection("services").doc('$keyword').collection("user").doc('${authController.user!.uid}').collection('items').orderBy("num",descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ItemsModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(ItemsModel.fromSnapshot(element));
      });
      return retVal;
    });
  }

}

class SamagriCustomization extends StatelessWidget{
  final String Vendoruid;
  final String Keyword;
  SamagriCustomization({required this.Vendoruid,required this.Keyword});

  AuthController authController = Get.find();
  //FareBreakup fareBreakup = Get.put(FareBreakup());
  var price_samagri = 0.0.obs;
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    FareBreakup fareBreakup  = Get.put(FareBreakup());
    return Scaffold(
      body: GetX<VendorController>(
        init: Get.put(VendorController(uid: Vendoruid)),
        builder: (VendorController vendorController){
          AuthController authController = Get.find();
        if(vendorController.userModel.value.image==null){
          return Center(child: Loader(),);
        }
          return Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text1(data: "${vendorController.userModel.value.name}", max: 18, min: 16,weight: FontWeight.bold),
                              SizedBox(height:5),
                              Text1(data: "${vendorController.userModel.value.district}, ${vendorController.userModel.value.state}", max: 11, min: 10,),
                              SizedBox(height:5),
                              Text1(data: "Offering:${fareBreakup.fare_data.value.userDiscount}% dicount", max: 11, min: 10,),
                            ]
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height:50,width: 80,
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.white,blurRadius: 20)],
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: NetworkImage('${vendorController.userModel.value.image}'),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 2.0,
                    dashColor: Colors.grey,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text1(data: "Fare breakup :", max: 14, min: 12,clr: Colors.grey,weight: FontWeight.bold,),
                          SizedBox(height: 15,),
                          Text1(data: "Note: Swipe left to remove any samagri", max: 11, min: 10,clr: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      ElevatedButton.icon(onPressed: (){
                        FirebaseFirestore.instance.collection("Vendors/${Vendoruid}/services/${Keyword}/items").get().then((value){
                          value.docs.forEach((element) {
                            FirebaseFirestore.instance.collection("users/${authController.user!.uid}/temp_booking/${Keyword}/items").doc(element.data()['id']).set({
                              'num':element.data()['num'],
                              'name':element.data()['name'],
                              'price':element.data()['price'],
                              'id':element.data()['id'],
                              'more':element.data()['more'],
                              'quantity':element.data()['quantity'],
                              'vendor_price':element.data()['vendor_price'],
                            });
                          });
                        });
                      }, icon: Icon(Icons.refresh,size: 10,color: Colors.grey,), label: Text1(data: "Refresh list", max: 10, min: 9,clr: Colors.grey,),
                        style: ElevatedButton.styleFrom(primary: Colors.white,shape: StadiumBorder()),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(

                    child: samagrilist()
                  ),
                ],
              ),

            ],
          );
        },
      )
    );
  }
  Widget samagrilist(){
   // FareBreakup fareBreakup = Get.put(FareBreakup());
    double height = Get.height;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users/${authController.user!.uid}/temp_booking/${Keyword}/items").orderBy('num').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        final services =snapshot.data!.docs;
        final doclength=snapshot.data!.docs.length;
        var sum=[];
        var vendorsum =[];
        for(var i in snapshot.data!.docs){
          final price=i.get('price');
          final vendor_price=i.get('vendor_price');
          sum.add(price);
          vendorsum.add(vendor_price);
        }
        num sam = 0;
        num vendorsam = 0;
        for (num e in sum) {
          sam += e;
        }
        for (num e in vendorsum) {
          vendorsam += e;
        }

        List<Widget> serviceWidgets=[];
        for(var mess in services){
          final name=mess.get('name');
          final price=mess.get('price');
          final doc=mess.get('id');
          final more=mess.get('more');
          final quantity=mess.get('quantity');
          final samagriwidget= samagritile(name, price, more,doc,doclength,sum,quantity
              ,sam,vendorsam);
          serviceWidgets.add(samagriwidget);
        }
        return Stack(
          children: [
            ListView(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: serviceWidgets
            ),

           Padding(
             padding:EdgeInsets.only(top:height*0.56),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text1(data: "Samagri Total : \₹$sam-/", max: 14, min: 12,clr: Colors.black54,weight: FontWeight.w600,),
                   ],
                 ),
               ],
             ),
           ),
            Positioned(
              right: 20,
              bottom: 0,
              child: InkWell(
                onTap: (){
                  Get.toNamed('/booking?samagri=true&price=$sam&vendor_price=$vendorsam');
                },
                child: CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    radius: 20,
                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget samagritile(String name,double price,String more,String doc,int docLength,List stota,String quantity,num sam,num vendorsam){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Remove',

          color: Colors.transparent,
          iconWidget: Icon(Icons.remove,color: Colors.redAccent,),
          onTap: (){
            print(sam);
            if(docLength<=1){
              Get.defaultDialog(title: "Warning",middleText: "At least 5 articles are required minimum in your samagri list.");
            }
            if(sam<10){
              Get.defaultDialog(title: "Warning",middleText: "The sum total of your samagri price can not be less than \₹200.");
            }
            else{
              FirebaseFirestore.instance.collection("users/${authController.user!.uid}/temp_booking/${Keyword}/items").doc(doc).delete();
            }
          },
        ),
      ],
      child:  ListTile(
        onTap: (){

        },
        title: Text1(data: "${name}", max: 12, min: 11,clr: Colors.black54,),
        subtitle: Row(
          children: [
            Text1(data: "${quantity}", max: 12, min: 11,clr: Colors.black54,),
            SizedBox(width: 5,),
            Icon(Icons.circle,size: 5,color: Colors.grey,),
            SizedBox(width: 5,),
            Text1(data: "${more}", max: 12, min: 11,clr: Colors.black54,),
          ],
        ),
        trailing: Text1(data: "\₹ ${price}-/", max: 12, min: 11,clr: Colors.black54,),
      ),
    );
  }

}

class FareBreakup extends GetxController{
  var fare_data = FareBreakupData(loader: false).obs;
  addVendor(String vendor,String name,var discount,var userDiscount,String token,double distance){
    fare_data.update((val) {
      val!.vendorUid =  vendor;
      val.vendor_name =name;
      val.discount = discount;
      val.userDiscount = userDiscount;
      val.vendor_token = token;
      val.vdistance = distance;
    });
  }
  updateLoader(){
    fare_data.update((val) {
      val!.loader= fare_data.value.loader?false:true;
    });
  }
  pandit(String panditpic,String panditName,String panditcontact,String pandittoken,String panditId,double distance){
    fare_data.update((val) {
      val!.panditPic = panditpic;
      val.panditName = panditName;
      val.panditContact = panditcontact;
      val.panditToken = pandittoken;
      val.panditId = panditId;
      val.pdistance = distance;
    });
  }
  service(double service_cahrge,String serviceId,String service,String image,var np){
    fare_data.update((val) {
      val!.service_cahrge = service_cahrge;
      val.service = service;
      val.service_id = service;
      val.service_image = image;
      val.np = np;
    });
  }
  address(double? lat, double? lng,String? booking_address, String? date,String? time,String? Username,String? Userpic,String? UserContact,String? UserAContact,String? UserId){
    fare_data.update((val) {
      val!.booking_address = booking_address;
      val.time = time;
      val.date = date;
      val.Username = Username;
      val.Userpic = Userpic;
      val.UserContact = UserContact;
      val.UserAContact = UserAContact;
      val.UserId = UserId;
      val.lat = lat;
      val.lng = lng;

    });
  }
}

class FareBreakupData{
  String? panditPic;
  String? panditName;
  String? panditContact;
  String? panditToken;
  String? panditId;
  double? pdistance;

  double? service_cahrge;
  var np;
  String? service_id;
  String? service;
  String? service_image;

  String? vendorUid;
  String? vendor_name;
  String? vendor_token;
  double? vdistance;
  var discount;
  var userDiscount;

  String? booking_address;
  double? lat;
  double? lng;
  String? date;
  String? time;
  String? Username;
  String? Userpic;
  String? UserContact;
  String? UserAContact;
  String? UserId;

  bool loader;
  FareBreakupData({required this.loader,this.vendor_token,this.panditId,this.panditPic,this.panditName,this.panditContact,this.panditToken,this.service_cahrge,this.service_id,this.service,this.service_image,this.vendorUid});
}

class BookingFinish extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String samagri = Get.parameters['samagri']!;
    double samagri_price = samagri=='true'?double.parse('${Get.parameters['price']}'):0.0;
    double vendor_price = samagri=='true'?double.parse('${Get.parameters['vendor_price']}'):0.0;
    final code = OTP.generateTOTPCodeString('JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
    double height = MediaQuery.of(context).size.height;
    double width = Get.width;
    Random random = new Random();
    int randomNumber = random.nextInt(1000000);
    final UserController userController = Get.put(UserController());
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: (){Get.back();},
            child: Icon(Icons.arrow_back_ios,color:Colors.black54,size: 18,)),
      ),
      body: GetX<FareBreakup>(
        init: Get.put(FareBreakup()),
        builder: (FareBreakup farebreakup){
          //____________________________ Without Samagri Calculation ____________________//
          double convineance_fee = farebreakup.fare_data.value.service_cahrge!*0.05;
          double total_no_samagri = farebreakup.fare_data.value.service_cahrge!+convineance_fee;
          // double ntransaction = total_no_samagri *0.0225;
          // double nbenefit_online = convineance_fee - ntransaction;
          // double ncompany_benefit = nbenefit_online*0.2;
          // double npandit_benefit = nbenefit_online*0.8;

          //____________________________  Samagri Calculation ____________________//
          var userDiscount = samagri=="true"?farebreakup.fare_data.value.userDiscount:0;
          var discount = samagri=="true"?farebreakup.fare_data.value.discount:0;
          var give_discount =samagri=="true"?samagri_price*userDiscount/100:0.0;
          var give_vdiscount =samagri=="true"?vendor_price*userDiscount/100:0.0;
          var samagri_after_dicount = samagri=="true"?samagri_price-give_discount:0.0;
          var vendor_after_dicount = samagri=="true"?vendor_price-give_vdiscount:0.0;
          var total_with_samagri = farebreakup.fare_data.value.service_cahrge!+samagri_after_dicount;
         // var transaction = total_with_samagri*0.0225;



          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text1(data: "Confirm Booking", max: 18, min: 16,weight: FontWeight.bold),
                                SizedBox(height:5),
                                Text1(data: "Service: ${farebreakup.fare_data.value.service}", max: 11, min: 10,),
                                SizedBox(height:5),
                                Text1(data: "By: ${farebreakup.fare_data.value.panditName}", max: 11, min: 10,),
                              ]
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height:80,width: 80,
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.white,blurRadius: 20)],
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: NetworkImage('${farebreakup.fare_data.value.service_image}'),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          flex:2,
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 2.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text1(data: "Booking Info", max: 11, min: 10,clr: Colors.grey,),),
                        Expanded(
                          flex:2,
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 2.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:MiniBox(icon: true, FirstText: 'Date', SecondText: "${farebreakup.fare_data.value.date}",iconData: CupertinoIcons.calendar_badge_plus,)),
                          Expanded(
                              flex: 1,
                              child: MiniBox(icon: true, FirstText: "Time", SecondText: "${farebreakup.fare_data.value.time}",iconData: Icons.watch_later_outlined,)),
                          Expanded(
                              flex: 1,
                              child: MiniBox(icon: true, FirstText: "Samagri", SecondText: "${samagri=='true'?"Yes":"No"}",iconData: Icons.shopping_bag_outlined,)),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:20,right: 20,top:5),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:MiniBox(icon: true, FirstText: 'Location', SecondText: "${farebreakup.fare_data.value.booking_address}",iconData: CupertinoIcons.home,)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex:2,
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 2.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text1(data: "Fare Breakup", max: 11, min: 10,clr: Colors.grey,),),
                        Expanded(
                          flex:2,
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 2.0,
                            dashColor: Colors.grey,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text1(data: "Normal Rate", max: 12, min: 11,clr: Colors.grey,),
                            SizedBox(height: 10,),
                            Text1(data: "Puja Purohit Special Rate", max: 12, min: 11,clr: Colors.grey,),
                            SizedBox(height: 10,),
                            samagri=='true'?SizedBox(height: 0.0,):Text1(data: "Convenience Fee", max: 12, min: 11,clr: Colors.grey,),
                            SizedBox(height: 10,),
                            samagri=='true'?Text1(data: "Samagri Charge", max: 12, min: 11,clr: Colors.grey,):SizedBox(),
                            SizedBox(height: 3,),
                            samagri=='true'?Text1(data: "Applied ${farebreakup.fare_data.value.userDiscount}% discount", max: 8, min: 7,clr: Colors.redAccent,):SizedBox(),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("\₹ ${farebreakup.fare_data.value.np!.roundToDouble().toStringAsFixed(2)}",style: GoogleFonts.aBeeZee(fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                            SizedBox(height: 10,),
                            Text1(data: "\₹ ${farebreakup.fare_data.value.service_cahrge!.roundToDouble().toStringAsFixed(2)}", max: 12, min: 11,clr: Colors.grey,),
                            SizedBox(height: 10,),
                            samagri=='true'?SizedBox(height: 0.0,):Text1(data: "\₹ ${convineance_fee.roundToDouble().toStringAsFixed(2)}", max: 12, min: 11,clr: Colors.grey,),
                            SizedBox(height: 10,),
                            samagri=='true'?Column(
                              children: [
                                Text1(data: "\₹ ${samagri_after_dicount.roundToDouble().toStringAsFixed(2)}", max: 12, min: 11,clr: Colors.grey,),
                                Text("\₹ ${samagri_price.roundToDouble().toStringAsFixed(2)}",style: GoogleFonts.aBeeZee(fontSize: 9,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                              ],
                            ):SizedBox(),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 1.0,
                      dashLength: 2.0,
                      dashColor: Colors.grey,
                      dashRadius: 0.0,
                      dashGapLength: 4.0,
                      dashGapColor: Colors.transparent,
                      dashGapRadius: 0.0,
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text1(data: "Total", max: 12, min: 11,clr: Colors.grey,weight: FontWeight.bold,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text1(data: samagri=="true"?"\₹ ${total_with_samagri.roundToDouble().toStringAsFixed(2)}": "\₹ ${total_no_samagri.roundToDouble().toStringAsFixed(2)}", max: 12, min: 11,clr: Colors.grey,weight: FontWeight.bold,),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text1(data: "Note>\nHere you are requesting booking according to our purohit availability he will accept your booking within 30 min.", max: 11, min: 11,clr: Colors.black54,)
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: ()async{
                       farebreakup.updateLoader();
                        await FirebaseFirestore.instance.doc('punditUsers/${farebreakup.fare_data.value.panditId}/notification/$randomNumber').set({
                          'token':farebreakup.fare_data.value.panditToken,
                          'utoken':'${userController.userModel.value.token}',
                          'clientuid':'${userController.userModel.value.id}',
                          'sender':"Booking Request by ${userController.userModel.value.name}",
                          'image':'${userController.userModel.value.photo}',
                          'content':"Booking for ${farebreakup.fare_data.value.service}",
                        });
                        await FirebaseFirestore.instance.doc('punditUsers/${farebreakup.fare_data.value.panditId}/bookingrequest/$randomNumber').set({
                          'pdistance':farebreakup.fare_data.value.pdistance,
                          'vdistance':farebreakup.fare_data.value.vdistance,
                          'discount':samagri=='true'?farebreakup.fare_data.value.userDiscount:0.0,
                          'companybenefit':0.0,
                          'panditbenefit':0.0,
                          'refundmoney':0.0,
                          'refunded':false,
                          'refund':false,
                          'deliver':false,
                          'samagri_price':samagri_after_dicount.roundToDouble(),
                          'vendor_price':samagri=="true"?vendor_after_dicount.roundToDouble():0.0,
                          'benefit':0.0,
                          'panditpic':farebreakup.fare_data.value.panditPic,
                          'timestrap':FieldValue.serverTimestamp(),
                          'dt':FieldValue.serverTimestamp(),
                          'date':farebreakup.fare_data.value.date,
                          'time':farebreakup.fare_data.value.time,
                          'transaction':0.0,
                          'puja_charge':farebreakup.fare_data.value.service_cahrge!.roundToDouble(),
                          'contact':userController.userModel.value.phone,
                          'alternate_contact':farebreakup.fare_data.value.UserAContact,
                          'samagri':samagri=="true"?true:false,
                          'otp':code,
                          'pandituid':farebreakup.fare_data.value.panditId,
                          'serviceId':farebreakup.fare_data.value.service_id,
                          'service_image':farebreakup.fare_data.value.service_image,
                          'btoken':farebreakup.fare_data.value.panditToken,
                          'utoken':userController.userModel.value.token,
                          'clientuid':userController.userModel.value.id,
                          'Location':farebreakup.fare_data.value.booking_address,
                          'lat':"",
                          'lng':"",
                          'client':userController.userModel.value.name,
                          'email':userController.userModel.value.email,
                          'Link':'selectedPlace.url',
                          'pic':userController.userModel.value.photo ,
                          'service':farebreakup.fare_data.value.service,
                          'bookingId':randomNumber,
                          'pandit':farebreakup.fare_data.value.panditName,
                          'Due':samagri=="true"?total_with_samagri.roundToDouble():total_no_samagri.roundToDouble(),
                          'convineancefee':samagri=="true"?0.0:convineance_fee.roundToDouble(),
                          'cancel':false,
                          'cod':false,
                          'request':false,
                          'rejected':false,
                          'payment':false,
                          'online':false,
                          'puja_status':false,
                          'rating':false,
                          'swastik':0.0,
                          'status':'Requested',
                          'vendor_uid':samagri=='true'?farebreakup.fare_data.value.vendorUid:'',
                          'vendor_token':samagri=='true'?farebreakup.fare_data.value.vendorUid:'',
                        });
                        await FirebaseFirestore.instance.doc('users/${farebreakup.fare_data.value.UserId}/bookings/$randomNumber').set({
                          'pdistance':farebreakup.fare_data.value.pdistance,
                          'vdistance':farebreakup.fare_data.value.vdistance,
                          'discount':samagri=='true'?farebreakup.fare_data.value.userDiscount:0.0,
                          'companybenefit':0.0,
                          'panditbenefit':0.0,
                          'refundmoney':0.0,
                          'refunded':false,
                          'refund':false,
                          'deliver':false,
                          'samagri_price':samagri_after_dicount.roundToDouble(),
                          'vendor_price':samagri=="true"?vendor_after_dicount.roundToDouble():0.0,
                          'benefit':0.0,
                          'panditpic':farebreakup.fare_data.value.panditPic,
                          'timestrap':FieldValue.serverTimestamp(),
                          'dt':FieldValue.serverTimestamp(),
                          'date':farebreakup.fare_data.value.date,
                          'time':farebreakup.fare_data.value.time,
                          'transaction':0.0,
                          'puja_charge':farebreakup.fare_data.value.service_cahrge!.roundToDouble(),
                          'contact':userController.userModel.value.phone,
                          'alternate_contact':farebreakup.fare_data.value.UserAContact,
                          'samagri':samagri=="true"?true:false,
                          'otp':code,
                          'pandituid':farebreakup.fare_data.value.panditId,
                          'serviceId':farebreakup.fare_data.value.service_id,
                          'service_image':farebreakup.fare_data.value.service_image,
                          'btoken':farebreakup.fare_data.value.panditToken,
                          'utoken':userController.userModel.value.token,
                          'clientuid':userController.userModel.value.id,
                          'Location':farebreakup.fare_data.value.booking_address,
                          'lat':"",
                          'lng':"",
                          'client':userController.userModel.value.name,
                          'email':userController.userModel.value.email,
                         'Link':'selectedPlace.url',
                          'pic':userController.userModel.value.photo ,
                          'service':farebreakup.fare_data.value.service,
                          'bookingId':randomNumber,
                          'pandit':farebreakup.fare_data.value.panditName,
                          'Due':samagri=="true"?total_with_samagri.roundToDouble():total_no_samagri.roundToDouble(),
                          'convineancefee':samagri=="true"?0.0:convineance_fee.roundToDouble(),
                          'cancel':false,
                          'cod':false,
                          'request':false,
                          'rejected':false,
                          'payment':false,
                          'online':false,
                          'puja_status':false,
                          'rating':false,
                          'swastik':0.0,
                          'status':'Requested',
                          'vendor_uid':samagri=='true'?farebreakup.fare_data.value.vendorUid:'',
                          'vendor_token':samagri=='true'?farebreakup.fare_data.value.vendorUid:''
                        });
                        await FirebaseFirestore.instance.doc('RBOOKING/$randomNumber').set({
                          'pdistance':farebreakup.fare_data.value.pdistance,
                          'vdistance':farebreakup.fare_data.value.vdistance,
                          'discount':samagri=='true'?farebreakup.fare_data.value.userDiscount:0.0,
                          'companybenefit':0.0,
                          'panditbenefit':0.0,
                          'refundmoney':0.0,
                          'refunded':false,
                          'refund':false,
                          'deliver':false,
                          'samagri_price':samagri_after_dicount.roundToDouble(),
                          'vendor_price':samagri=="true"?vendor_after_dicount.roundToDouble():0.0,
                          'benefit':0.0,
                          'panditpic':farebreakup.fare_data.value.panditPic,
                          'timestrap':FieldValue.serverTimestamp(),
                          'date':farebreakup.fare_data.value.date,
                          'time':farebreakup.fare_data.value.time,
                          'transaction':0.0,
                          'puja_charge':farebreakup.fare_data.value.service_cahrge!.roundToDouble(),
                          'contact':userController.userModel.value.phone,
                          'alternate_contact':farebreakup.fare_data.value.UserAContact,
                          'samagri':samagri=="true"?true:false,
                          'otp':code,
                          'pandituid':farebreakup.fare_data.value.panditId,
                          'serviceId':farebreakup.fare_data.value.service_id,
                          'service_image':farebreakup.fare_data.value.service_image,
                          'btoken':farebreakup.fare_data.value.panditToken,
                          'utoken':userController.userModel.value.token,
                          'clientuid':userController.userModel.value.id,
                          'Location':farebreakup.fare_data.value.booking_address,
                          'lat':"",
                          'lng':"",
                          'client':userController.userModel.value.name,
                          'email':userController.userModel.value.email,
                         'Link':'selectedPlace.url',
                          'pic':userController.userModel.value.photo ,
                          'service':farebreakup.fare_data.value.service,
                          'bookingId':randomNumber,
                          'pandit':farebreakup.fare_data.value.panditName,
                          'Due':samagri=="true"?total_with_samagri.roundToDouble():total_no_samagri.roundToDouble(),
                          'convineancefee':samagri=="true"?0.0:convineance_fee.roundToDouble(),
                          'cancel':false,
                          'cod':false,
                          'request':false,
                          'rejected':false,
                          'payment':false,
                          'online':false,
                          'puja_status':false,
                          'rating':false,
                          'swastik':0.0,
                          'status':'Requested',
                          'vendor_uid':samagri=='true'?farebreakup.fare_data.value.vendorUid:'',
                          'vendor_token':samagri=='true'?farebreakup.fare_data.value.vendorUid:''
                        }).whenComplete(() {
                          farebreakup.updateLoader();
                          Get.back();
                          Get.back();
                          Get.back();
                        }).whenComplete(() => Get.snackbar("Booking", "Booking successfully requested"));
                      }, child:Text1(data: "Request Booking", max: 12, min: 11,clr: Colors.white,),style: ElevatedButton.styleFrom(shape: StadiumBorder(),primary: Colors.orangeAccent),),
                      SizedBox(width: 15,),
                      ElevatedButton(onPressed: (){
                        Get.back();
                        Get.back();
                        Get.back();
                      }, child:Text1(data: "Cancel", max: 12, min: 11),style: ElevatedButton.styleFrom(shape: StadiumBorder(),primary: Colors.black54),),
                    ],
                  )
                ],
              ),
              farebreakup.fare_data.value.loader?Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                height: height,
                width: double.infinity,
                child: Container(
                  height: 80,width: 80,
                  child: Loader(),
                ),
              ):SizedBox()
            ],
          );
        },
      ),
    );
  }



}