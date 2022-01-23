import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Vehicule{
  String id;
  String nomVehicule;
  String immatricule;
  int kilometrage;

  Vehicule(this.id,this.nomVehicule, this.immatricule, this.kilometrage);


  @override
  String toString() {
    return 'Vehicule{id: $id, nomVehicule: $nomVehicule, immatricule: $immatricule, kilometrage: $kilometrage}';
  }

  static Future<List<Vehicule>> getVehicules() async {
    final url = Uri.parse('${urlApi}/vehicules');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List vehicules = json.decode(response.body);
      List<Vehicule> listMapped =  vehicules.map((json) => Vehicule.fromJson(json)).toList();
      return listMapped;

    } else {
      throw Exception();
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'id':this.id,
        'nomVehicule': this.nomVehicule,
        'immatricule': this.immatricule,
        'kilometrage': this.kilometrage,

      };

  factory Vehicule.fromJson(dynamic json) {
    String? id="";
    try {
      id = json['id'] as String;
    }catch(e){
      id= json['_id'] as String;
    }
    Vehicule vehicule = Vehicule(
      id,
      json['nomVehicule'] as String,
      json['immatricule'] as String,
      (json['kilometrage'] as num).toInt(),
    );
    return vehicule;
  }

 static NetworkImage getImage(String imageName){
    String url = "${urlApi}/media/${imageName}";
    return NetworkImage(url);
  }

 static Future<String> uploadImage(filename, url) async {
    print("send image");
    var request = http.MultipartRequest('POST', Uri.parse("${urlApi}/vehicules/image/"));
    request.files.add(await http.MultipartFile.fromPath('image', filename));
    var res = await request.send();
    // var response = await http.Response.fromStream(res);
    var responseString = await res.stream.bytesToString();
    var imageName = json.decode(responseString);
    print(imageName.map((m)=>m['filename']));
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