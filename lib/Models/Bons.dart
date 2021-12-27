import 'dart:convert';

import 'package:suiviventes/Gasoil/GenererBonGasoil.dart';
import 'package:suiviventes/Models/vehicule.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'Engins.dart';
import 'api_response.dart';

String? pdfURLL;
class Bons{
  String? date;
  String? type;
  Vehicule? vehicule;
  List<Engins>? engins;
  String? kilometrage;
  String? justifUrl;
  String? location;
  String? montant;
  String? pdfUrl;


  Bons.partVehicule(this.date, this.type, this.vehicule, this.kilometrage, this.montant);

  Bons.autresVehicule(this.date, this.type, this.vehicule, this.kilometrage,
      this.justifUrl, this.location, this.montant);

  Bons.partEngins(this.date, this.type, this.engins, this.montant);

  Bons.autresEngins(this.date, this.type, this.engins, this.justifUrl,
      this.location, this.montant);

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

  Future<APIResponse<bool>> createBon(Bons bon) {
    return http.post(Uri.parse("http://$urlApi:3000/bons"), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    }, body: json.encode(bon.toJson())).then((data) async {
      if (data.statusCode == 201) {
        print("bien fait");
        var jsonData = jsonDecode(data.body);
        Bons bon = new Bons.fromJson(jsonData);
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

  static String? getPdfUrl(){
    print(pdfURLL);
    return pdfURLL;
  }

}