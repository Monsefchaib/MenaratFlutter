import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Lots{
  String id;
  String? site;
  String? zone;
  String? espece;
  String? variete;
  int? quantite;
  int? quantiteReservee;

  Lots(this.id,this.site, this.zone, this.espece, this.variete, this.quantite,
      this.quantiteReservee);


  @override
  String toString() {
    return 'Lots{id: $id, site: $site, zone: $zone, espece: $espece, variete: $variete, quantite: $quantite, quantiteReservee: $quantiteReservee}';
  }


  Map toJson() {

    return {
      'id':this.id,
      'site': this.site,
      'zone': this.zone,
      'espece': this.espece,
      'variete': this.variete,
      'quantite': this.quantite,
      'quantiteReservee': this.quantiteReservee,

    };
  }
  factory Lots.fromJson(dynamic json) {
    String? id="";
    try {
      id = json['id'] as String;
    }catch(e){
      id= json['_id'] as String;
    }
    Lots lot = Lots(
      id,
      json['site'] as String,
      json['zone'] as String,
      json['espece'] as String,
      json['variete'] as String,
      json['quantite'] as int,
      json['quantiteReservee'] as int,

    );
    return lot;
  }

  static Future<List<Lots>> getLots(String? s,String? sort) async {
    final url = Uri.parse('http://$urlApi:3000/lots/filter/?s=$s&sort=$sort');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List lots = json.decode(response.body);
      List<Lots> listMapped =  lots.map((json) => Lots.fromJson(json)).toList();
      return listMapped;

    } else {
      throw Exception();
    }
  }
}