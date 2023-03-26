import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:weather/models/weathermodel.dart';
import 'package:weather/service/weatherservice.dart';

class WeatherScreen extends StatefulWidget {
  final String location;
  const WeatherScreen({Key? key, required this.location}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  dynamic weatherData = {};
  // String temp = '';
  Main? main;

  wetherDatareturn() async {
    EasyLoading.show(status: "Loading...");
    var res = await WeatherRepo().fetchWeather(widget.location);
    EasyLoading.dismiss();
    if (res != false) {
      weatherData = res;
      main = res.main;
      print(main!.temp);
      print(weatherData.name);
      setState(() {});
    }

    // print(res.main[0].temp);
  }

  @override
  void initState() {
    print(widget.location);
    wetherDatareturn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: weatherData == null
            ? Container()
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/weather_background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  // child:
                  // Container(
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.white)),
                  //   height: 200,
                  //   width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Colors.blueAccent, width: 2)),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "City : ${weatherData.name}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Temperature : ${main!.temp}°C",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Visibility : ${weatherData.visibility}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // ),
                ),
              ));
  }
}
