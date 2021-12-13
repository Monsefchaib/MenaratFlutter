import 'dart:convert';

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

}