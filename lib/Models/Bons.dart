import 'dart:convert';

import 'package:suiviventes/Gasoil/GenererBonGasoil.dart';
import 'package:suiviventes/Models/vehicule.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'Engins.dart';
import 'api_response.dart';

String? pdfURLL;
class Bons{
  String? id;
  String? date;
  String? type;
  Vehicule? vehicule;
  List<Engins>? engins;
  String? kilometrage;
  String? justifUrl;
  String? location;
  double? montant;
  String? pdfUrl;


  Bons.partVehicule(this.date, this.type, this.vehicule, this.kilometrage, this.montant);

  Bons.autresVehicule(this.date, this.type, this.vehicule, this.kilometrage,
      this.justifUrl, this.location, this.montant);

  Bons.partEngins(this.date, this.type, this.engins, this.montant);

  Bons.autresEngins(this.date, this.type, this.engins, this.justifUrl,
      this.location, this.montant);


  Bons(this.id, this.date, this.type, this.vehicule, this.engins, this.kilometrage,
      this.justifUrl, this.location, this.montant, this.pdfUrl);

  Bons.pdfURL(this.pdfUrl);

  @override
  String toString() {
    return 'Bons{date: $date, type: $type, vehicule: $vehicule, engins: $engins, justifUrl: $justifUrl, location: $location, montant: $montant}';
  }

  Map<String, dynamic> toJson() {
    List? engins =
    this.engins != null ? this.engins!.map((i) => i.toJson()).toList() : null;
    // Vehicule vehicule = this.vehicule!=null ? this.vehicule!.toJson() : null;
    return {
      'date': this.date,
      'type': this.type,
      'vehicule': this.vehicule,
      'engins': this.engins,
      'kilometrage': this.kilometrage,
      'justifUrl': this.justifUrl,
      'location': this.location,
      'montant': this.montant,

    };
  }

  factory Bons.fromJson(dynamic json) {
    Bons client = Bons.pdfURL(
      json['pdfUrl'] as String,
    );
    return client;
  }

  factory Bons.AllfromJson(dynamic json) {


    List<Engins>? listEngins = [];
    try{
      List<dynamic> jsonOrdres = json['engins'];
      listEngins =  List<Engins>.from(jsonOrdres.map((i) => Engins.fromJson(i)));
    }catch(e){
    }

    Vehicule vehicule = new Vehicule("","","",0);
    try {
      vehicule = new Vehicule.fromJson(json['vehicule']);
    }catch(e){

    }

    String justifUrl = " ";
    try{
      justifUrl = json['justifUrl'] as String;
    }catch(e){

    }

    String location = " ";
    try{
      location = json['location'] as String;
    }catch(e){

    }
    String kilometrage = " ";
    try{
      kilometrage = json['kilometrage'] as String;
    }catch(e){

    }

    String pdfUrl = " ";
    try{
     pdfUrl =  json['pdfUrl'] as String;
    }catch(e){

    }

    double montant = 0;
    try{
      montant = (json['montant'] as num).toDouble();
    }catch(e){

    }

    Bons bon = Bons(
      json['_id'] as String,
        json['date'] as String,
        json['type'] as String,
        vehicule,
        listEngins,
        kilometrage,
        justifUrl,
        location,
        montant,
        pdfUrl,
    );
    return bon;
  }

  Future<APIResponse<bool>> createBon(Bons bon) {
    return http.post(Uri.parse("${urlApi}/bons"), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    }, body: json.encode(bon.toJson())).then((data) async {
      if (data.statusCode == 201) {
        print("bien fait");
        var jsonData = jsonDecode(data.body);
        Bons bon = new Bons.AllfromJson(jsonData);
        GenererBonGasoil.pdfSetUrl(bon.pdfUrl!);
        return APIResponse<bool>(data: true, errorMessage: "");
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occured', data: false);
    })
        .catchError((_) =>
        APIResponse<bool>(
            error: true, errorMessage: 'An error occured', data: false));
  }

  static Future<List<Bons>> getBons() async {
    final url = Uri.parse('${urlApi}/bons/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List bons = json.decode(response.body);
      List<Bons> listMapped =[];

      listMapped = bons.map((json) =>
          Bons.AllfromJson(json)).toList();
      return listMapped;
    } else {
      throw Exception();
    }
  }

  static Future<Bons> getBonById(String? id) async {
    final url = Uri.parse('${urlApi}/bons/byId/$id');
    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Bons bon = new Bons.AllfromJson(jsonData);
      return bon;

    } else {
      throw Exception();
    }
  }


  static String? getPdfUrl(){
    return pdfURLL;
  }

}