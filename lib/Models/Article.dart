import 'package:suiviventes/Models/Lots.dart';

class Article{
  Lots? lot;
  String? substrat;
  String? conteneur;
  double? prixUnitaire;
  double? quantite;

  Article(this.lot, this.substrat, this.conteneur, this.prixUnitaire,
      this.quantite);

  @override
  String toString() {
    return 'Article{articles: $lot, substrat: $substrat, conteneur: $conteneur, prixUnitaire: $prixUnitaire, quantite: $quantite}';
  }

  Map<String, dynamic> toJson() {
    Map? lot = this.lot!=null ? this.lot!.toJson() : null;

    return {
      'lot': this.lot,
      'substrat': this.substrat,
      'conteneur': this.conteneur,
      'prixUnitaire': this.prixUnitaire,
      'quantite': this.quantite,
    };
  }
  factory Article.fromJson(dynamic json) {
    Article article = Article(
      json['lot'] as Lots,
      json['substrat'] as String,
      json['conteneur'] as String,
      json['prixUnitaire'] as double,
      json['quantite'] as double,
    );
    return article;
  }



}