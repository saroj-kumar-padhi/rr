import 'package:pujapurohit/Utils/Imports.dart';
import '../../top_bar.dart';
import '../Controllers/EventController.dart';


class Events extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(width,height*0.099,),
          child:TopTabs()


      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left:ResponsiveWidget.isSmallScreen(context)? 0.0:25.0),
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.doc("PujaPurohitFiles/events").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.data==null){
                      return Center(child: Loader(),);
                    }
                    List <dynamic> events = snapshot.data!.get("events");
                    Map<int, dynamic> map = events.asMap();
                    final EventController  eventController= Get.put(EventController());
                    List<dynamic> sliders = snapshot.data!.get("sliders");
                    List<Widget> slides = [];
                    for(var i in sliders){
                      var link=i;
                      final sliderWidget = Container(

                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage("$link"),
                                fit: BoxFit.contain
                            )
                        ),
                        padding:EdgeInsets.only(left: 30,right: 30),

                      );
                      slides.add(sliderWidget);
                    }
                    return Column(
                      children: [
                        SizedBox(height: 20,),
                        ImageSlideshow(
                          width:width*0.9,
                          height: height*0.45,
                          initialPage: 0,
                          indicatorColor: Colors.orangeAccent,
                          indicatorBackgroundColor: Colors.grey,
                          children:slides,
                          onPageChanged: (value) {
                            print('Page changed: $value');
                          },
                          autoPlayInterval: 5000,
                          isLoop: true,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: events.length,
                            itemBuilder:(_,index) {
                              if(map[index]["status"]=="upcoming"){
                                return  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,),
                                    customHeading(context,"Upcoming","Event"),
                                    SizedBox(height: 20,),
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: (){

                                        eventController.updateupcoming(map[index]["bigS"],map[index]["youtube"],map[index]["puja"],map[index]["price"],map[index]["note"],map[index]["age"],map[index]["gender"], map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"],map[index]["participants"],map[index]["terms"]);
                                        Get.toNamed('/eventDetail?event=$index');
                                      },
                                      child: Row(
                                        mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: height*0.55,
                                            width:ResponsiveWidget.isSmallScreen(context)? width*0.95:width*0.8,
                                            child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                            padding: EdgeInsets.all(20) ,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                              if(map[index]["status"]=="live"){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,),
                                    customHeading(context,"Live","Event"),
                                    SizedBox(height: 20,),
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap:(){
                                        eventController.updatelive(map[index]["bigS"],map[index]["youtube"],map[index]["price"],map[index]["note"],map[index]["age"],map[index]["gender"], map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"],map[index]["participants"],map[index]["terms"]);
                                        Get.toNamed('/eventDetail?event=$index');
                                      },
                                      child: Row(
                                        mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: height*0.55,

                                            child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                            padding: EdgeInsets.all(20) ,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  customHeading(context,"Previous","Event"),
                                  SizedBox(height: 20,),
                                  InkWell(
                                    hoverColor: Colors.transparent,
                                    onTap:(){
                                      eventController.updatePrevious(map[index]["bigS"],map[index]["youtube"],map[index]["place"],map[index]["status"],map[index]["image"], map[index]["name"], map[index]["about"], map[index]["duration"], map[index]["total_days"], map[index]["top3"],map[index]["participants"]);
                                      Get.toNamed('/eventDetail?event=$index');
                                    },
                                    child: Row(
                                      mainAxisAlignment:ResponsiveWidget.isSmallScreen(context)? MainAxisAlignment.start:MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: height*0.55,
                                          width: width*0.8,
                                          child:ResponsiveWidget.isSmallScreen(context)? Image.network(map[index]["image"]):Image.network(map[index]["bigS"]),
                                          padding: EdgeInsets.all(20) ,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                      ],
                    );
                  }
              ),
            ),


          ],
        ),
      ),
    );
  }
  Padding customHeading(BuildContext context,String txt1,String txt2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        text: TextSpan(
          style: Theme
              .of(context)
              .textTheme
              .headline4,
          children: [
            TextSpan(text: "$txt1\n",),
            TextSpan(
                text: "$txt2",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }}
 






