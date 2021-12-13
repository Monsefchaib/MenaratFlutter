import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:suiviventes/AjoutCommande/AjouterClient.dart';
import 'package:suiviventes/Models/Client.dart';
import 'package:suiviventes/Models/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:suiviventes/ProduitsForms/OlivierForm.dart';
import 'package:suiviventes/components/showUserInfos.dart';
bool showInfos = false;
class AddClients extends StatefulWidget {
  @override
  _AddClientsState createState() => _AddClientsState();
}

class _AddClientsState extends State<AddClients> {
  final formKey = GlobalKey<FormState>();
  final controllerCity = TextEditingController();
  final controllerFood = TextEditingController();
  String? selectedCity;
  String? selectedFood;
  Client clientToShow = Client(" "," "," "," ");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un client"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(

                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(onPressed: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AjouterClient()),) },
                        child:
                    Text("Créer un nouveau client")),
                  ),
                  SizedBox(height:10),
                  Divider(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Chercher un client existant :")),
                  SizedBox(height: 10,),
                  searchClient(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchClient() =>
      Column(
        children: [
          TypeAheadFormField<Client?>(
            debounceDuration: Duration(milliseconds: 500),
            textFieldConfiguration: TextFieldConfiguration(
              controller: controllerCity,
              decoration: InputDecoration(
                labelText: 'Client',
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: Client.getClientSuggestions,
            itemBuilder: (context, Client? suggestions){
              final client=suggestions!;
              return ListTile(
                title: Text(client.nom +" "+ client.prenom),
              );
            },
            noItemsFoundBuilder: (context)=>Container(
              height: 100,
              child: Center(
                child: Text("Aucun client n'est trouvé", style: TextStyle(fontSize: 24),),
              ),
            ),
            onSuggestionSelected: (Client ? suggestion) {
              clientToShow=suggestion!;
              Navigator.pop(context, suggestion);
            },
          ),
          if (showInfos = true) ...[

          ],
    ]

      );

Widget ShowUser(Client client)=>
    Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text("Nom :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            Text(client.nom),
            Text("Prenom :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            Text(client.prenom),
            Text("Telephone :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            Text(client.telephone),
            Text("Adresse :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            Text(client.adresse),
          ],

        ),
      );

// Widget Show() =>
//     Container(child: Card(
//       child: FutureBuilder(
//         future: getItemData(),
//         builder: (context, snapshot){
//           if(snapshot.data == null){
//             return Container(child: Center(
//               child: Text('Loading'),
//             ));
//           } else return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 5.0,
//                 mainAxisSpacing: 5.0,
//               ),
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, i){
//                 var imageUrl;
//                 return InkWell(
//                   onTap: ()=> {},
//                   child: GridTile(
//                       child: Text(''),
//                       header: Container(child: Image.network(snapshot.data!.imageUrl)),
//                       footer: Container(
//                         color: Colors.white70,
//                         child: ListTile(
//                           leading: Padding(
//                             padding: const EdgeInsets.all(1.0),
//
//                             child: Column(
//                               children: <Widget>[
//                                 Text("Nom :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
//                                 Text(snapshot.data!.nom),
//                                 Text("Prenom :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
//                                 Text(snapshot.data!.prenom),
//                                 Text("Telephone :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
//                                 Text(client.telephone),
//                                 Text("Adresse :", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
//                                 Text(client.adresse),
//
//                               ],
//                             ),
//
//                           ),
//                         ),
//                       )),
//                 );
//
//               });
//         },
//       ),
//     ),)
}



