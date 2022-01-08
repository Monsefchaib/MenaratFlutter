import 'package:suiviventes/Models/OrdreItems.dart';

import 'Article.dart';

class Livraison{
  String? date;
  List<OrderItem>? articlesLivree;

  Livraison(this.date, this.articlesLivree);

  Map<String, dynamic> toJson() {
    List? articlesLivree =
    this.articlesLivree != null ? this.articlesLivree!.map((i) => i.toJson()).toList() : null;

    return {
      'date': this.date,
      'articlesLivree': this.articlesLivree,
    };
  }

  factory Livraison.fromJson(dynamic json) {
    List<dynamic> jsonArticles = json['articlesLivree'];
    List<OrderItem>? itemsToOrder = List<OrderItem>.from(jsonArticles.map((i) => OrderItem.fromJson(i)));
    Livraison livraison = Livraison(
      json['date'] as String,
      itemsToOrder,
    );
    return livraison;
  }

}