
import 'package:suiviventes/Models/Livraison.dart';
import 'package:suiviventes/Models/OrdreItems.dart';

class Ordre{
  List<OrderItem>? itemsToOrder;
  List<Livraison> ? livraisons;

  Ordre(this.itemsToOrder,this.livraisons);
  Ordre.vide();
  @override
  String toString() {
    return 'Ordre{itemsToOrder: $itemsToOrder, livraisons: $livraisons}';
  }



  Map<String, dynamic> toJson() {
    List? itemsToOrder =
    this.itemsToOrder != null ? this.itemsToOrder!.map((i) => i.toJson()).toList() : null;
    List? livraisons =
    this.livraisons != null ? this.livraisons!.map((i) => i.toJson()).toList() : null;
    return {
      'itemsToOrder': this.itemsToOrder,
      'livraisons': this.livraisons,
    };
  }

  factory Ordre.fromJson(dynamic json) {

    List<Livraison>? livraisons = [];
    try{
       List<dynamic> jsonOrdres = json['livraisons'];
       livraisons =  List<Livraison>.from(jsonOrdres.map((i) => Livraison.fromJson(i)));
    }catch(e){
    }
    List<dynamic> jsonArticles = json['itemsToOrder'];
    List<OrderItem>? itemsToOrder = List<OrderItem>.from(jsonArticles.map((i) => OrderItem.fromJson(i)));

    Ordre ordre = Ordre(
      itemsToOrder,
      livraisons
      );
    return ordre;
  }

}