import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Lots{
  String? id;
  String? code;
  String? date;
  String? region;
  String? pepiniere;
  String? espece;
  String? variete;
  String? num_ordre;
  double? superficie;
  String? substrat;
  String? conteneur;
  String? type;
  String? porteGreffe;
  int? quantite;


  Lots(
      this.id,
      this.code,
      this.date,
      this.region,
      this.pepiniere,
      this.espece,
      this.variete,
      this.num_ordre,
      this.superficie,
      this.substrat,
      this.conteneur,
      this.type,
      this.porteGreffe,
      this.quantite);


  @override
  String toString() {
    return 'Lots{id: $id, code: $code, date: $date, region: $region, pepiniere: $pepiniere, espece: $espece, variete: $variete, num_ordre: $num_ordre, superficie: $superficie, substrat: $substrat, conteneur: $conteneur, type: $type, porteGreffe: $porteGreffe, quantite: $quantite}';
  }

  Map toJson() {

    return {
      'id':this.id,
      'code':this.code,
      'date':this.date,
      'region':this.region,
      'pepiniere':this.pepiniere,
      'espece': this.espece,
      'variete': this.variete,
      'num_ordre':this.num_ordre,
      'superficie':this.superficie,
      'substrat':this.substrat,
      'conteneur':this.conteneur,
      'type':this.type,
      'porteGreffe':this.porteGreffe,
      'quantite': this.quantite,

    };
  }
  factory Lots.fromJson(dynamic json) {
    String? id="";
    try {id = json['id'] as String;}catch(e){id= json['_id'] as String;}
    String? code="";
    try {code = json['code'] as String;}catch(e){print(e);}
    String? date="";
    try {date = json['date'] as String;}catch(e){print(e);}
    String? pepiniere="";
    try {pepiniere = json['pepiniere'] as String;}catch(e){print(e);}
    String? espece="";
    try {espece = json['espece'] as String;}catch(e){print(e);}
    String? variete="";
    try {variete = json['variete'] as String;}catch(e){print(e);}
    String? num_ordre="";
    try {num_ordre = json['num_ordre'] as String;}catch(e){print(e);}
    double? superficie=0;
    try {superficie = (json['superficie'] as num).toDouble();}catch(e){print(e);}
    String? substrat="";
    try {substrat = json['substrat'] as String;}catch(e){print(e);}
    String? conteneur="";
    try {conteneur = json['conteneur'] as String;}catch(e){print(e);}
    String? type="";
    try {type = json['type'] as String;}catch(e){print(e);}
    String? porteGreffe="";
    try {porteGreffe = json['porteGreffe'] as String;}catch(e){print(e);}
    int? quantite=0;
    try {quantite = (json['quantite'] as num).toInt();}catch(e){print(e);}
    String? region="";
    try {region = json['region'] as String;}catch(e){print(e);}


    Lots lot = Lots(
      id,
      code,
      date,
      region,
      pepiniere,
      espece,
      variete,
      num_ordre,
      superficie,
      substrat,
      conteneur,
      type,
      porteGreffe,
      quantite,
    );
    return lot;
  }

  static Future<List<Lots>> getLots(String? s,String? sort) async {
    final url = Uri.parse('${urlApi}/lots/filter/?s=$s&sort=$sort');
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