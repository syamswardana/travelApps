import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelApps/API/place_api.dart';
import 'package:travelApps/Objek/place.dart';

class DestinationPage extends StatefulWidget {
  Place place;
  DestinationPage({this.place});
  @override
  _DestinationPageState createState() => _DestinationPageState(place: place);
}

class _DestinationPageState extends State<DestinationPage> {
  Place place;
  _DestinationPageState({this.place});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: PlaceApi.getImage(place.photoReferences),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        place.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "DancingScript",
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        place.formattedAddress ?? place.vicinity,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: place.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 18.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                place.rating.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                place.reviews.length.toString() + " Reviews",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                          // Text(
                          //   "See reviews",
                          //   style: TextStyle(color: Colors.white, fontSize: 12),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)),
                            color: Colors.grey[800].withOpacity(0.65),
                            minWidth: 155,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                "Photos",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)),
                            color: Colors.white,
                            minWidth: 155,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text("See Reviews",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
