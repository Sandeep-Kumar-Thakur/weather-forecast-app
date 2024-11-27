class PlacesModel {
  List<Places>? places;

  PlacesModel({this.places});

  PlacesModel.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(Places.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (places != null) {
      data['places'] = places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Places {
  int? id;
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? url;

  Places(
      {this.id,
        this.name,
        this.region,
        this.country,
        this.lat,
        this.lon,
        this.url});

  Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['region'] = region;
    data['country'] = country;
    data['lat'] = lat;
    data['lon'] = lon;
    data['url'] = url;
    return data;
  }
}
