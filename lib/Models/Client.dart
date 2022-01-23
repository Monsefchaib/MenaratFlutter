import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'api_response.dart';

class Client {
  late String nom;
  late String prenom;
  late String telephone;
  late String adresse;

  Client(this.nom, this.prenom, this.telephone, this.adresse);

  Client.vide();

  @override
  String toString() {
    return 'Client{nom: $nom, prenom: $prenom, telephone: $telephone, adresse: $adresse}';
  }

  Client.name({required this.nom});

  Map<String, dynamic> toJson() =>
      {
        'nom': this.nom,
        'prenom': this.prenom,
        'telephone': this.telephone,
        'adresse': this.adresse,
      };

  static Future<List<Client>> getClientSuggestions(String query) async {
    final url = Uri.parse('${urlApi}/clients');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List clients = json.decode(response.body);
        print(clients);
      return clients.map((json) => Client.fromJson(json)).where((user) {
        final nameLower = user.nom.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();

    } else {
      throw Exception();
    }
  }

  Future<APIResponse<bool>> createClient(Client client) {
    print("ana hna");
    String API = "http://172.20.10.2:3000";
    return http.post(Uri.parse("${urlApi}/clients"), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    }, body: json.encode(client.toJson())).then((data) {
      if (data.statusCode == 201) {
        print("bien fait");
        return APIResponse<bool>(data: true, errorMessage: "");
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occured', data: false);
    })
        .catchError((_) =>
        APIResponse<bool>(
            error: true, errorMessage: 'An error occured', data: false));
  }

  getAllClients() async {
    print("my clients");
    String url = "${urlApi}/clients";
    var response = await http.get(Uri.parse(url));
    var jsonData = (jsonDecode(response.body) as List);
    print(jsonData);
  }


  factory Client.fromJson(dynamic json) {
    Client client = Client(
      json['nom'] as String,
      json['prenom'] as String,
      json['telephone'] as String,
      json['adresse'] as String,
    );
    return client;
  }
  static Client frommJson(Map<String, dynamic> json) => Client.name(nom: json['nom']);



}



