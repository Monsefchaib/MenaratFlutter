import 'dart:convert';

import 'package:suiviventes/AjoutCommande/SuiviDesCommandes.dart';
import 'package:suiviventes/Models/Article.dart';
import 'package:suiviventes/Models/Client.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'api_response.dart';

String? commandePDFF;
class Commande{
  List<Article>? articles;
  Client? client;
  String? date;
  double? prixTotal;
  String? commandePDF;

  Commande(this.articles, this.client, this.date, this.prixTotal);
  Commande.pdf(this.commandePDF);

  @override
  String toString() {
    return 'Commande{articles: $articles, client: $client, date: $date, prixTotal: $prixTotal}';
  }

  Map<String, dynamic> toJson() {
    List? articles =
    this.articles != null ? this.articles!.map((i) => i.toJson()).toList() : null;
    // Vehicule vehicule = this.vehicule!=null ? this.vehicule!.toJson() : null;
    return {
      'articles': this.articles,
      'client': this.client,
      'date': this.date,
      'prixTotal': this.prixTotal,
    };
  }

  factory Commande.fromJson(dynamic json) {
    Commande commande = Commande.pdf(
      json['commandePDF'] as String,
    );
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
        Commande commande = new Commande.fromJson(jsonData);
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


  static String? getPdfUrl(){
    print(commandePDFF);
    return commandePDFF;
  }

}