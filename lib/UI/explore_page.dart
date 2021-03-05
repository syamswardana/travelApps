import 'package:flutter/material.dart';

class ExplorePage {
  static appbar() {
    return AppBar(
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
    );
  }

  static body() {
    return ListView(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40))),
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
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 25),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.bottomCenter,
                  width: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/lighthouse.jpg"),
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
                          Text(
                            "Bali, Indonesia",
                            style: TextStyle(
                                fontFamily: "DancingScript",
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "from \$497",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            "4,8 ",
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
                );
              }),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Text(
            "Browse by activity",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 250,
          margin: EdgeInsets.only(left: 20, top: 20),
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(right: 25),
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomCenter,
                    width: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/lighthouse.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chillout",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "23 locations",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ));
              }),
        ),
      ],
    );
  }
}
