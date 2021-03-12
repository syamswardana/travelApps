import 'package:flutter/material.dart';
import 'package:travelApps/API/place_api.dart';
import 'package:travelApps/API/weather_api.dart';
import 'package:travelApps/Objek/place.dart';
import 'package:travelApps/UI/detination_page.dart';

class DestinationType extends StatefulWidget {
  final String type;
  DestinationType({@required this.type});
  @override
  _DestinationTypeState createState() => _DestinationTypeState(type: type);
}

class _DestinationTypeState extends State<DestinationType> {
  String type;
  List<Place> place = [];
  _DestinationTypeState({this.type});

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  void _refresh() {
    String paramType = type.replaceAll(new RegExp(' '), '_').toLowerCase();
    print(paramType);
    WeatherApi.determinePosition().then((value) async {
      place = await PlaceApi.getPopularPlaces(
          lat: value.latitude, long: value.longitude, type: paramType);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          type != null ? type : "Destinations",
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: place.length ?? 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                PlaceApi.getPlaceDetails(place[index].placeId).then((place) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DestinationPage(
                      place: place,
                    );
                  }));
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: PlaceApi.getImage(place[index].photoReferences),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment(0.0, 1),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.black.withOpacity(0.4)),
                    height: 80,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                place[index].name ?? "Alun-alun",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "DancingScript",
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                place[index].vicinity ?? "Jalan PB Sudirman",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              place[index].rating.toString() + "  ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 15,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
