import 'dart:convert';

import 'package:suiviventes/AjoutCommande/SuiviDesCommandes.dart';
import 'package:suiviventes/Models/Article.dart';
import 'package:suiviventes/Models/Client.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'api_response.dart';

String? commandePDFF;
class Commande{
  String? id;
  List<Article>? articles;
  Client? client;
  String? date;
  double? prixTotal;
  String? commandePDF;
  String? status;

  Commande(this.id,this.articles, this.client, this.date, this.prixTotal,this.status,this.commandePDF);
  Commande.pdf(this.commandePDF);

  @override
  String toString() {
    return 'Commande{articles: $articles, client: $client, date: $date, prixTotal: $prixTotal}';
  }

  Map<String, dynamic> toJson() {
    List? articles =
    this.articles != null ? this.articles!.map((i) => i.toJson()).toList() : null;
    return {
      'articles': this.articles,
      'client': this.client,
      'date': this.date,
      'prixTotal': this.prixTotal,
      'status':this.status,
    };
  }

  factory Commande.PdfFromJson(dynamic json) {
    Commande commande = Commande.pdf(
      json['commandePDF'] as String,
    );
    return commande;
  }

   factory Commande.fromJson(dynamic json) {
     List<dynamic> parsedListJson = json['articles'];
        List<Article>? articlesList = List<Article>.from(parsedListJson.map((i) => Article.fromJson(i)));
     Client client = new Client.fromJson(json['client']);
    Commande commande = Commande(
        json['_id'] as String,
        articlesList ,
        client,
        json['date'] as String,
        (json['prixTotal'] as num).toDouble(),
    json['status'] as String,
    json['commandePDF'] as String);
    return commande;
  }

 static Future<APIResponse<bool>> createCommande(Commande commande) {
    return http.post(Uri.parse("http://$urlApi:3000/commandes"), headers: {
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
    final url = Uri.parse('http://$urlApi:3000/commandes/filter?s=$s');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List commandes = json.decode(response.body);
      List<Commande> listMapped =  commandes.map((json) => Commande.fromJson(json)).toList();
      return listMapped;

    } else {
      throw Exception();
    }
  }

  static String? getPdfUrl(){
    print(commandePDFF);
    return commandePDFF;
  }

}