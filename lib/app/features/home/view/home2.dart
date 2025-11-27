import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/features/home/controller/home_contoller.dart';

class Home2 extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {

    // getting current hour for Day and time
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5494b2).withOpacity(1),
              Color(0xFF7da8be).withOpacity(0.6),// light sky blue
              Color(0xFFa6bdca).withOpacity(0.3),   // deep blue
            ],
          ),
        ),

        child: SafeArea(
          child: Obx(() {
            final state = controller.state.value;

            if (state == WeatherState.LOADING) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if(state == WeatherState.ERROR){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text( controller.errorMessage.value,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                        hintText: 'search city',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        ),
                        prefixIcon: Icon(Icons.search_outlined,color: Colors.white,)
                    ),
                    onSubmitted: (_){
                      controller.loadCityWeather();
                    },
                  )

                ],
              );
            }

            return buildWeatherScreen(
              context,
              searchController: controller.searchController,
              currentHour: currentHour,
            );
          }),
        ),
      ),
    );

  }

  // ----------------- WEATHER SCREEN -------------------------------------
  Widget buildWeatherScreen(
    BuildContext context ,{
    required TextEditingController searchController,
    required int currentHour,
  }){
    final weather = controller.currentWeather.value!;
    final size = MediaQuery.of(context).size;
    final h = size.height / 100;
    final w = size.width /100;
    return Padding(
              padding: EdgeInsets.only(left: 5 * w, top: 5 * h, right: 5 * w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CITY + Date
                          Obx((){
                            return Text(
                              controller.currentWeather.value!.cityName,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5
                              ),
                            );
                          }),

                          Text(
                            date(),
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 10 * w,),

                      //------------  Search Field  -------------
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2 * h),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'search city',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(Icons.search_outlined,color: Colors.white,),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onSubmitted: (_){
                              controller.loadCityWeather();
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          )
                        ),
                      )

                    ],
                  ),

                  SizedBox(height: 4 * h,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        flex: 4,
                        child: Image.asset(
                          (currentHour >= 6 && currentHour < 18) ? 'assets/weather/01d.png' : 'assets/weather/01n.png',
                          width: 10 * w,
                          height: 10 * h,
                        ),
                      ),


                      Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(top: 2 * h, left: 2* w),
                          height: 8 * h,
                          width: 0.7 * w,
                          color: Colors.grey.shade200,
                        ),
                      ),

                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(top: 3 * h, left: 12 * w),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: weather.temperature.toString(),
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                    )
                                ), // The main string
                                WidgetSpan(
                                  child: Transform.translate(
                                    offset: const Offset(0, -20), // Adjust offset for desired position
                                    child: Text(
                                      'o', // The superscript string
                                      textScaleFactor: 0.7, // Make superscript smaller
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5 * h,),

                  SizedBox(
                    height: 12 * h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [

                        weatherInfoCard(
                            iconPath: 'assets/icons/windspeed.png',
                            value: weather.windSpeed.toString()+' km/h',
                            textPadding: 1,
                          h: h,
                          w: w,
                        ),
                        SizedBox(width: 6 * w,),
                        weatherInfoCard(
                          iconPath: 'assets/icons/clouds.png',
                          value: weather.cloudiness.toString()+'%',
                          textPadding: 6,
                          h: h,
                          w: w,
                        ),
                        SizedBox(width: 6 * w,),
                        weatherInfoCard(
                          iconPath: 'assets/icons/humidity.png',
                          value: weather.humidity.toString()+'%',
                          textPadding: 6,
                          h: h,
                          w: w,
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 3 * h,),
                  // slick_slider
                  // --- Circular Humidity Slider ---
                  Padding(
                    padding: EdgeInsets.only(left: 20 * w),
                    child: SleekCircularSlider(
                      min: 0,
                      max: 100,
                      initialValue: weather.humidity.toDouble(),
                      appearance: CircularSliderAppearance(
                        size: 20 * h,
                        customWidths: CustomSliderWidths(
                          trackWidth: 10,
                          progressBarWidth: 12,
                          handlerSize: 0,
                        ),
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.blue.shade200,
                          trackColor: Colors.white,
                          shadowColor: Colors.black12,
                          shadowMaxOpacity: 0.4,
                        ),
                        infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          modifier: (value) =>
                          "${value.toInt()}% Humidity",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 3 * h,),

                  // rowwww
                  SizedBox(
                    height: 10 * h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5 * w),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _statCard(
                            title: "Pressure",
                            value: "${weather.pressure} hPa",
                            h: h,
                            w:w,
                          ),
                          SizedBox(width: 3 * w,),
                          _statCard(
                            title: "Visibility",
                            value: "${(weather.visibility / 1000).toStringAsFixed(1)} km",
                            h: h,
                            w:w,
                          ),
                          SizedBox(width: 3 * w,),
                          _statCard(
                            title: "Min/Max",
                            value:
                            "${weather.minTemp.toStringAsFixed(0)}/${weather.maxTemp.toStringAsFixed(0)}°",
                            h: h,
                            w:w,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
    );
  }

  String date(){
   final now =  DateTime.now();
   return DateFormat('MMMM d, yyyy').format(now);
  }

  Widget weatherInfoCard({
    required final String iconPath,
    required final String value,
    required final textPadding,
    required final double h,
    required final double w,

}){
    return Container(
      margin: EdgeInsets.only(left: 5 * w),
      height: 12 * h,
      width: 20 * w,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [
              Container(
                height: 8 * h,
                width: 18 * w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFFf1eff3),
                ),
              ),

              Positioned(
                  left: 4 * w,
                  top: 0 * h,
                  bottom: 0.1 * h,
                  child: Image.asset(
                    iconPath,
                    height: 10 * h,
                    width: 10 * w,
                  )),
            ],
          ),

          SizedBox(height: 1 * h,),

          Padding(
            padding:  EdgeInsets.only(left: textPadding * w),
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400
              ),
            ),
          )
        ],
      ),
    );
}

  // ---------- STAT CARD WIDGET ----------
  Widget _statCard({required String title, required String value, required double h, required double w }) {
    return Container(
      width: 25 * w,
      padding: EdgeInsets.only(left: 0 * w, right: 0 * w, top: 2 * h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: Colors.white.withOpacity(0.5),
          blurRadius: 5,
          spreadRadius: 0,
        )]
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 0.5 * h),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

}
