import 'package:suiviventes/Models/Lots.dart';

class Article{
  Lots? lot;
  double? prixUnitaire;
  int? quantite;

  Article(this.lot,this.prixUnitaire,
      this.quantite);

  @override
  String toString() {
    return 'Article{articles: $lot, prixUnitaire: $prixUnitaire, quantite: $quantite}';
  }

  Map<String, dynamic> toJson() {
    Map? lot = this.lot!=null ? this.lot!.toJson() : null;

    return {
      'lot': this.lot,
      'prixUnitaire': this.prixUnitaire,
      'quantite': this.quantite,
    };
  }
 factory Article.fromJson(dynamic json) {
   Article article = Article(

      Lots.fromJson(json['lot']),
     (json['prixUnitaire'] as num).toDouble(),
     (json['quantite'] as num).toInt(),
   );
    return article;
  }



}