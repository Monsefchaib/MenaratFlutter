import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'api_response.dart';

class Client{
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

  Map<String, dynamic> toJson() => {
    'nom': this.nom,
    'prenom': this.prenom,
    'telephone': this.telephone,
    'adresse': this.adresse,
  };

  Future<APIResponse<bool>> createClient(Client client) {
    print("ana hna");
    String API = "http://172.20.10.2:3000";
    return http.post(Uri.parse("http://172.20.10.2:3000/clients"), headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    }, body: json.encode(client.toJson())).then((data) {
      if (data.statusCode == 201) {
        print("bien fait");
        return APIResponse<bool>(data: true,errorMessage: "");
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured',data: false);
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured',data: false));
  }

  getAllClients() async {
    print("my clients");
    String url = "http://192.168.1.166:3000/clients";
    var response = await http.get(Uri.parse(url));
    var jsonData = (jsonDecode(response.body) as List);
    print(jsonData);
  }


  factory Client.fromJson(dynamic json) {
    return Client(
      json['nom'] as String,
      json['prenom'] as String,
      json['telephone'] as String,
      json['address'] as String,
    );
  }


}

