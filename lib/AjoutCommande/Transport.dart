
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Transport.dart';

class TransportPage extends StatefulWidget {
  @override
  _TransportPageState createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  TextEditingController nomChauffeur = new TextEditingController();
  TextEditingController numTelephone = new TextEditingController();
  TextEditingController immVehicule = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Methode de transport'),

      ),
      body: SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10,),
            Divider(),
            Text("Nom du chauffeur :",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            TextFormField(
             controller: nomChauffeur,
              decoration: InputDecoration(
                labelText: 'Nom du chauffeur',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            Divider(),
            Text("Numéro de téléphone du chauffeur :",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.number,
            controller: numTelephone,
              decoration: InputDecoration(
                hintText: "+212611222333",
                labelText: 'Numéro de téléphone du chauffeur',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            Divider(),
            Text("Immatriculation de véhicule :",style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            TextFormField(
              controller: immVehicule,
              decoration: InputDecoration(
                hintText: "99999-B-1",
                labelText: 'Immatriculation de véhicule',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              Transport transport = new Transport(nomChauffeur.text, numTelephone.text, immVehicule.text);
              print(transport.toString());
              Navigator.pop(context, transport);
            },
              child: Text('Ajouter la méthode de transport'),

            ),
          ],
        ),
      ),
    );
  }
}
