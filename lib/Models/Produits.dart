import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Produit {
  late String espece;
  List<String>?varietee;
  late String variete;
  late String substrat;
  late String conteneur;
  late int nbrPlantes;
  late double prixUnitaire;
  late String porteGreffe;
  List<String>? porteGreffee;

  Produit(this.espece, this.variete, this.substrat, this.conteneur,
      this.nbrPlantes, this.prixUnitaire, this.porteGreffe);


  Produit.Espece(this.espece,this.varietee,this.porteGreffee);

  Produit.vide();

  Map<String, dynamic> VFromJson() =>
      {

        'variete': this.varietee,

      };


  @override
  String toString() {
    return 'Produit{espece: $espece, varietee: $varietee, porteGreffee : $porteGreffee}';
  } // Map<String, dynamic> toJson() {
  //   List? variete = this.varietee != null ? this.varietee!.map((i) => i.varieteToJson()).toList() : null;
  //   // Vehicule vehicule = this.vehicule!=null ? this.vehicule!.toJson() : null;
  //   return {
  //     'espece': this.espece,
  //     'variete':this.varietee
  //
  //   };
  // }

      factory Produit.fromJson(dynamic json) {
        List<String>? variete = json['variete'] != null ? List.from(json['variete']) : null;
        List<String>? porteGreffe = json['porteGreffe'] != null ? List.from(json['porteGreffe']) : null;

        Produit lot = Produit.Espece(
      json['espece'] as String,
      variete,
            porteGreffe
      );
      return lot;
      }

  static Future<List<Produit>> getProduits() async {
    final url = Uri.parse('http://$urlApi:3000/produits/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List lots = json.decode(response.body);
      List<Produit> listMapped =  lots.map((json) => Produit.fromJson(json)).toList();
      return listMapped;

    } else {
      throw Exception();
    }
  }

}