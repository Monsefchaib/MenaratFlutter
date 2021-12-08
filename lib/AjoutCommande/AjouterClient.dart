import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Client.dart';

class AjouterClient extends StatefulWidget {
  @override
  _AjouterClientState createState() => _AjouterClientState();
}

class _AjouterClientState extends State<AjouterClient> {
  TextEditingController nomClient = new TextEditingController();
  TextEditingController prenomClient = new TextEditingController();
  TextEditingController telephoneClient = new TextEditingController();
  TextEditingController adresseClient = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un client"),
      ),
      body: SingleChildScrollView(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10,),
            TextFormField(
              controller: nomClient,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Nom',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Divider(thickness: 1,),
            SizedBox(height: 10,),
            TextFormField(
              controller: prenomClient,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Prénom',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Divider(thickness: 1,),
            SizedBox(height: 10,),
            TextFormField(
              controller: adresseClient,
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Adresse',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            Divider(thickness: 1,),
            SizedBox(height: 10,),
            TextFormField(
              controller: telephoneClient,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                hintText: "+2126112223334",
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                labelText: 'Telephone',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {
              Client client = new Client(nomClient.text,prenomClient.text,telephoneClient.text,adresseClient.text);
              print(client.toString());
              final result = await client.createClient(client);
              final title = 'Done';
              final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Votre Client a été ajouté';

              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(title),
                    content: Text(text),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )
              )
                  .then((data) {
                if (result.data) {
                  Navigator.of(context).pop();
                }
              });
            },
              child: Text('Ajouter le client'),
            ),

          ],
        ),
      ),
    );
  }
}
