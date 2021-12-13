import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Vehicule{
  String nomVehicule;
  String immatricule;
  String kilometrage;

  Vehicule(this.nomVehicule, this.immatricule, this.kilometrage);

  @override
  String toString() {
    return 'Vehicule{nomVehicule: $nomVehicule, immatricule: $immatricule, kilometrage: $kilometrage}';
  }

  static Future<List<Vehicule>> getVehicules() async {
    final url = Uri.parse('http://$urlApi:3000/vehicules');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List vehicules = json.decode(response.body);
      List<Vehicule> listMapped =  vehicules.map((json) => Vehicule.fromJson(json)).toList();
      return listMapped;

    } else {
      throw Exception();
    }
  }


  factory Vehicule.fromJson(dynamic json) {
    Vehicule vehicule = Vehicule(
      json['nomVehicule'] as String,
      json['immatricule'] as String,
      json['kilometrage'] as String,
    );
    return vehicule;
  }

 static NetworkImage getImage(String imageName){
    String url = "http://192.168.1.4:3000/vehicules/image/763c7e2c2d05ee7c5576dd7bb2fb7fee";
    return NetworkImage(url);
  }

 static Future<String> uploadImage(filename, url) async {
    print("send image");
    var request = http.MultipartRequest('POST', Uri.parse("http://192.168.1.4:3000/vehicules/image/"));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    var res = await request.send();
    print(res);
    return res.reasonPhrase!;
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}