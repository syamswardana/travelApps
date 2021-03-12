class Weather {
  double lat;
  double lon;
  String country;
  String city;
  double temp;
  String icon;
  int weatherCode;
  String weatherDesc;
  Weather({
    this.lat,
    this.lon,
    this.country,
    this.city,
    this.temp,
    this.icon,
    this.weatherCode,
    this.weatherDesc,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    List<dynamic> data = map['data'];
    Map<String, dynamic> weather = data[0];
    Map<String, dynamic> icon = weather["weather"];
    return Weather(
        city: weather["city_name"],
        country: weather["country_code"],
        lon: weather['lon'],
        lat: weather["lat"],
        temp: weather["temp"] is int
            ? weather["temp"].roundToDouble()
            : weather["temp"],
        icon: icon["icon"],
        weatherCode: icon['code'],
        weatherDesc: icon["description"]);
  }
}
