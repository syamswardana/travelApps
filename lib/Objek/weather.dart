class Weather {
  String lat;
  String lon;
  String country;
  String city;
  String temp;
  String icon;
  String weatherCode;
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
    return Weather(
        city: map["city_name"],
        country: map["country_code"],
        lon: map['lon'],
        lat: map["lat"],
        temp: map["temp"],
        icon: map["weather.icon"],
        weatherCode: map['weather.code'],
        weatherDesc: map["weather.description"]);
  }
}
