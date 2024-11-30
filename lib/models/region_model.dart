import 'dart:convert';

class Region {
  final String name;
  final String capital;
  final List<List<double>> coordinates;

  Region({
    required this.name,
    required this.capital,
    required this.coordinates,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      name: json['properties']['region'],
      capital: json['properties']['capital'],
      coordinates: List<List<double>>.from(
        json['geometry']['coordinates'][0].map(
          (coord) => List<double>.from(coord),
        ),
      ),
    );
  }
}

List<Region> parseRegions(String jsonString) {
  final Map<String, dynamic> data = jsonDecode(jsonString);
  return List<Region>.from(
    data['features'].map((feature) => Region.fromJson(feature)),
  );
}
