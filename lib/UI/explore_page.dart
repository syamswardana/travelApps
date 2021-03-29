import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:travelApps/API/place_api.dart';
import 'package:travelApps/Objek/place.dart';
import 'package:travelApps/UI/destination_type.dart';
import 'package:travelApps/UI/detination_page.dart';

class ExplorePage extends StatelessWidget {
  final List<Place> places;
  ExplorePage({this.places});
  final List<String> typeDestination = [
    "Amusement Park",
    "Restaurant",
    "Tourist Attraction"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Find your trip",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                "Explore destinations",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40))),
              ),
              suggestionsCallback: (input) async {
                return await PlaceApi.getPredictions(input);
              },
              itemBuilder: (context, suggestion) {
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Row(
                    children: [
                      Icon(Icons.near_me),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              suggestion.description,
                              style: TextStyle(fontSize: 14),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(suggestion.distance ?? "00",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w200))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                PlaceApi.getPlaceDetails(suggestion.placeId).then((place) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DestinationPage(
                            place: place,
                          )));
                });
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              "Popular Locations",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.only(left: 20, top: 20),
            child: ListView.builder(
                itemCount: places.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Place place = places[index];
                  return InkWell(
                    onTap: () {
                      PlaceApi.getPlaceDetails(places[index].placeId)
                          .then((value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DestinationPage(place: value);
                        }));
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 25),
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.bottomCenter,
                      width: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: PlaceApi.getImage(place.photoReferences),
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(7)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  place.name,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: "DancingScript",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  place.vicinity,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Text(
                                place.rating.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Text(
              "Browse by type",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 250,
            margin: EdgeInsets.only(left: 20, top: 20),
            child: ListView.builder(
                itemCount: typeDestination.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DestinationType(
                            type: (index == 0)
                                ? "Amusement Park"
                                : (index == 1)
                                    ? "Restaurant"
                                    : "Tourist Attraction");
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 25),
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomCenter,
                      width: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage((index == 0)
                                  ? "assets/amusement_park.jpg"
                                  : (index == 1)
                                      ? "assets/restaurant.jpeg"
                                      : "assets/bali.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken)),
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        typeDestination[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
