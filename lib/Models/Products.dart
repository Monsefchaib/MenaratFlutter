import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Product{
  String? id;
  String? nom_commercial;
  String? categorie;
  String? matiere_active;

  Product(this.id, this.nom_commercial, this.categorie, this.matiere_active);

  @override
  String toString() {
    return 'Product{id: $id, nom_commercial: $nom_commercial, categorie: $categorie, matiere_active: $matiere_active}';
  }

  Map toJson() {
    return {
      'id':this.id,
      'nom_commercial':this.nom_commercial,
      'categorie':this.categorie,
      'matiere_active':this.matiere_active,
    };
  }

  factory Product.fromJson(dynamic json) {
    String? id="";
    try {id = json['id'] as String;}catch(e){id= json['_id'] as String;}
    String? nom_commercial="";
    try {nom_commercial = json['nom_commercial'] as String;}catch(e){print(e);}
    String? categorie="";
    try {categorie = json['categorie'] as String;}catch(e){print(e);}
    String? matiere_active="";
    try {matiere_active = json['matiere_active'] as String;}catch(e){print(e);}

    Product product = Product(
      id,
      nom_commercial,
      categorie,
      matiere_active,
    );
    return product;
  }

  static Future<List<Product>> getProducts(String query) async {
    final url = Uri.parse('${urlApi}/products/');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List products = json.decode(response.body);
      return products.map((json) => Product.fromJson(json)).where((product) {
        final nameLower = product.nom_commercial!.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();

    } else {
      throw Exception();
    }
  }
}