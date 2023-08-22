// class List {
//   late int dt;
//   late Main main;
//   late List<Weather> weather;
//   late Wind wind;
//   late int visibility;
//   late int pop;
//   late String dtTxt;
//
//   List(
//       {required this.dt,
//       required this.main,
//       required this.weather,
//       required this.wind,
//       required this.visibility,
//       required this.pop,
//       required this.dtTxt});
//
//   List.fromJson(Map<String, dynamic> json) {
//     dt = json['dt'];
//     main = (json['main'] != null ? new Main.fromJson(json['main']) : null)!;
//     if (json['weather'] != null) {
//       weather = List<Weather>();
//       json['weather'].forEach((v) {
//         weather.add(Weather.fromJson(v));
//       });
//     }
//
//     wind = (json['wind'] != null ? new Wind.fromJson(json['wind']) : null)!;
//     visibility = json['visibility'];
//     pop = json['pop'];
//
//     dtTxt = json['dt_txt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['dt'] = this.dt;
//     if (this.main != null) {
//       data['main'] = this.main.toJson();
//     }
//     if (this.weather != null) {
//       data['weather'] = this.weather.map((v) => v.toJson()).toList();
//     }
//
//     if (this.wind != null) {
//       data['wind'] = this.wind.toJson();
//     }
//     data['visibility'] = this.visibility;
//     data['pop'] = this.pop;
//
//     data['dt_txt'] = this.dtTxt;
//     return data;
//   }
// }
//
// class Main {
//   late double temp;
//   late double feelsLike;
//   late double tempMin;
//   late double tempMax;
//   late int pressure;
//   late int seaLevel;
//   late int grndLevel;
//   late int humidity;
//   late double tempKf;
//
//   Main(
//       {required this.temp,
//       required this.feelsLike,
//       required this.tempMin,
//       required this.tempMax,
//       required this.pressure,
//       required this.seaLevel,
//       required this.grndLevel,
//       required this.humidity,
//       required this.tempKf});
//
//   Main.fromJson(Map<String, dynamic> json) {
//     temp = json['temp'];
//     feelsLike = json['feels_like'];
//     tempMin = json['temp_min'];
//     tempMax = json['temp_max'];
//     pressure = json['pressure'];
//     seaLevel = json['sea_level'];
//     grndLevel = json['grnd_level'];
//     humidity = json['humidity'];
//     tempKf = json['temp_kf'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['temp'] = this.temp;
//     data['feels_like'] = this.feelsLike;
//     data['temp_min'] = this.tempMin;
//     data['temp_max'] = this.tempMax;
//     data['pressure'] = this.pressure;
//     data['sea_level'] = this.seaLevel;
//     data['grnd_level'] = this.grndLevel;
//     data['humidity'] = this.humidity;
//     data['temp_kf'] = this.tempKf;
//     return data;
//   }
// }
//
// class Weather {
//   late int id;
//   late String main;
//   late String description;
//   late String icon;
//
//   Weather(
//       {required this.id,
//       required this.main,
//       required this.description,
//       required this.icon});
//
//   Weather.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     main = json['main'];
//     description = json['description'];
//     icon = json['icon'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['main'] = this.main;
//     data['description'] = this.description;
//     data['icon'] = this.icon;
//     return data;
//   }
// }
//
// class Wind {
//   late double speed;
//   late int deg;
//   late double gust;
//
//   Wind({required this.speed, required this.deg, required this.gust});
//
//   Wind.fromJson(Map<String, dynamic> json) {
//     speed = json['speed'];
//     deg = json['deg'];
//     gust = json['gust'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['speed'] = this.speed;
//     data['deg'] = this.deg;
//     data['gust'] = this.gust;
//     return data;
//   }
// }

// class ForecastModel {
//   late Main main;
//   late List<Weather> weather;
//   late Wind wind;
//   late String dtTxt ;
//
//   ForecastModel({
//     required this.main,
//     required this.weather,
//     required this.wind,
//     required this.dtTxt,
//   });
//
//   factory ForecastModel.fromJson(Map<String, dynamic> json) {
//     return ForecastModel(
//       main: Main.fromJson(json['main'] as Map<String, dynamic>),
//       weather: (json['weather'] as List<dynamic>)
//           .map((e) => Weather.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
//       dtTxt: json['dt_txt'] as String,
//     );
//   }
// }
//
// class Main {
//   late double temp;
//   late double feelsLike;
//   late double tempMin;
//   late double tempMax;
//   late int pressure;
//   late int humidity;
//
//   Main({
//     required this.temp,
//     required this.feelsLike,
//     required this.tempMin,
//     required this.tempMax,
//     required this.pressure,
//     required this.humidity,
//   });
//
//   factory Main.fromJson(Map<String, dynamic> json) {
//     return Main(
//       temp: json['temp'] as double,
//       feelsLike: json['feels_like'] as double,
//       tempMin: json['temp_min'] as double,
//       tempMax: json['temp_max'] as double,
//       pressure: json['pressure'] as int,
//       humidity: json['humidity'] as int,
//     );
//   }
// }
//
// class Weather {
//   late int id;
//   late String main;
//   late String description;
//   late String icon;
//
//   Weather({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });
//
//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       id: json['id'] as int,
//       main: json['main'] as String,
//       description: json['description'] as String,
//       icon: json['icon'] as String,
//     );
//   }
// }
//
// class Wind {
//   late double speed;
//   late int deg;
//
//   Wind({
//     required this.speed,
//     required this.deg,
//   });
//
//   factory Wind.fromJson(Map<String, dynamic> json) {
//     return Wind(
//       speed: json['speed'] as double,
//       deg: json['deg'] as int,
//     );
//   }
// }

class Forecast {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late int pop;
  late Sys sys;
  late String dtTxt;

  Forecast(
      {required this.dt,
      required this.main,
      required this.weather,
      required this.clouds,
      required this.wind,
      required this.visibility,
      required this.pop,
      required this.sys,
      required this.dtTxt});

  Forecast.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = (json['main'] != null ? Main.fromJson(json['main']) : null)!;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    clouds = (json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null)!;
    wind = (json['wind'] != null ? Wind.fromJson(json['wind']) : null)!;
    visibility = json['visibility'];
    pop = json['pop'];
    sys = (json['sys'] != null ? Sys.fromJson(json['sys']) : null)!;
    dtTxt = json['dt_txt'];
  }
}

class Main {
  late double temp;
  late double feelsLike;
  late double tempMin;
  late double tempMax;
  late int pressure;
  late int seaLevel;
  late int grndLevel;
  late int humidity;
  late double tempKf;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity,
      required this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'].toDouble();
  }
}

class Weather {
  late int id;
  late String main;
  late String description;
  late String icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Clouds {
  late int all;

  Clouds({required this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class Wind {
  late double speed;
  late int deg;
  late double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }
}

class Sys {
  late String pod;

  Sys({required this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }
}

class City {
  late int id;
  late String name;
  late Coord coord;
  late String country;
  late int population;
  late int timezone;
  late int sunrise;
  late int sunset;

  City(
      {required this.id,
      required this.name,
      required this.coord,
      required this.country,
      required this.population,
      required this.timezone,
      required this.sunrise,
      required this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = (json['coord'] != null ? Coord.fromJson(json['coord']) : null)!;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

class Coord {
  late double lat;
  late double lon;

  Coord({required this.lat, required this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }
}
