import 'dart:convert';

import 'package:suiviventes/AjoutCommande/SuiviDesCommandes.dart';
import 'package:suiviventes/Models/Article.dart';
import 'package:suiviventes/Models/Avance.dart';
import 'package:suiviventes/Models/Client.dart';
import 'package:http/http.dart' as http;
import 'package:suiviventes/Models/Ordre.dart';
import 'package:json_annotation/json_annotation.dart';
import '../constants.dart';
import 'api_response.dart';
String? commandePDFF;
@JsonSerializable(nullable: true)
class Commande{
  String? id;
  List<Article>? articles;
  Client? client;
  String? date;
  double? prixTotal;
  String? commandePDF;
  String? status;
  List<Ordre>? listOrdres;
  String? lienSuiviPDF;
  List<Avance>? listAvances;
  Commande.Noid(this.articles, this.client, this.date, this.prixTotal,this.status,this.commandePDF);
  Commande(this.id,this.articles, this.client, this.date, this.prixTotal,this.status,this.commandePDF,this.listOrdres,
      this.listAvances,
      this.lienSuiviPDF);
  Commande.pdf(this.commandePDF);


  @override
  String toString() {
    return 'Commande{id: $id, articles: $articles, client: $client, date: $date, prixTotal: $prixTotal, commandePDF: $commandePDF, status: $status, listOrdres: $listOrdres}';
  }

  Map<String, dynamic> toJson() {
    List? articles =
    this.articles != null ? this.articles!.map((i) => i.toJson()).toList() : null;
    List? listOrders =
    this.listOrdres != null ? this.listOrdres!.map((i) => i.toJson()).toList() : null;
    List? listAvances =
    this.listAvances != null ? this.listAvances!.map((i) => i.toJson()).toList() : null;
    return {
      'articles': this.articles,
      'client': this.client,
      'date': this.date,
      'prixTotal': this.prixTotal,
      'status':this.status,
      'listOrdres':this.listOrdres,
      'listAvances':this.listAvances
    };
  }

  factory Commande.PdfFromJson(dynamic json) {
    Commande commande = Commande.pdf(
      json['commandePDF'] as String,
    );
    return commande;
  }

   factory Commande.fromJson(dynamic json) {
    List<Ordre>? ordresList = [];
     try{
     List<dynamic> jsonOrdres = json['listOrdres'];
      ordresList = List<Ordre>.from(jsonOrdres.map((i) => Ordre.fromJson(i)));
     }catch(e){
     }

    List<dynamic> jsonArticles = json['articles'];
     List<Article>? articlesList = [];
     try{
       articlesList  = List<Article>.from(jsonArticles.map((i) => Article.fromJson(i)));
     }catch(e){
     }
    List<Avance>? listAvances = [];
    try{
      List<dynamic> jsonOrdres = json['listAvances'];
      listAvances =  List<Avance>.from(jsonOrdres.map((i) => Avance.fromJson(i)));
    }catch(e){
    }

    Client client = new Client("","","","");
    try {
      client = new Client.fromJson(json['client']);
    }catch(e){

    }
    String lienSuiviPdf= " ";
    try{
      lienSuiviPdf=json['lienSuiviPDF'] as String;
    }catch(e){

    }


    Commande commande = Commande(
        json['_id'] as String,
        articlesList ,
        client,
        json['date'] as String,
        (json['prixTotal'] as num).toDouble(),
        json['status'] as String,
         json['commandePDF'] as String,
        ordresList,
        listAvances,
        lienSuiviPdf,
    );
    return commande;
  }

 static Future<APIResponse<bool>> createCommande(Commande commande) {
    return http.post(Uri.parse("${urlApi}/commandes"), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    }, body: json.encode(commande.toJson())).then((data) {
      if (data.statusCode == 201) {
        print("La commande est ajoutée");
        var jsonData = jsonDecode(data.body);
        Commande commande = new Commande.PdfFromJson(jsonData);
        SuiviDesCommandes.pdfSetUrl(commande.commandePDF!);
        return APIResponse<bool>(data: true, errorMessage: "");
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occured', data: false);
    })
        .catchError((_) =>
        APIResponse<bool>(
            error: true, errorMessage: 'An error occured', data: false));
  }

  static Future<List<Commande>> getCommandes(String? s) async {
    final url = Uri.parse('${urlApi}/commandes/filter?s=$s');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List commandes = json.decode(response.body);
      List<Commande> listMapped =[];

        listMapped = commandes.map((json) =>
            Commande.fromJson(json)).toList();

      return listMapped;
    } else {
      throw Exception();
    }
  }

  static Future<APIResponse<bool>> updateCommande(Commande commande) {
    return http.patch(Uri.parse("${urlApi}/commandes/${commande.id}"), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    }, body: json.encode(commande.toJson())).then((data) {
      if (data.statusCode == 201) {
        print("La commande est ajoutée");
        var jsonData = jsonDecode(data.body);
        Commande commande = new Commande.PdfFromJson(jsonData);
        SuiviDesCommandes.pdfSetUrl(commande.commandePDF!);
        return APIResponse<bool>(data: true, errorMessage: "");
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occured', data: false);
    })
        .catchError((_) =>
        APIResponse<bool>(
            error: true, errorMessage: 'An error occured', data: false));
  }

  static Future<Commande> getCommandeById(String? id) async {
    final url = Uri.parse('${urlApi}/commandes/byId/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Commande commande = new Commande.fromJson(jsonData);
      return commande;
    } else {
      throw Exception();
    }
  }


  static String? getPdfUrl(){
    print(commandePDFF);
    return commandePDFF;
  }

}