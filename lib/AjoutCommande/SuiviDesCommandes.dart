
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:suiviventes/AjoutCommande/AddEspeces.dart';
import 'package:suiviventes/AjoutCommande/AjouterClient.dart';
import 'package:suiviventes/Models/Transport.dart';

import 'Clients.dart';
import 'Transport.dart';

class SuiviDesCommandes extends StatefulWidget {
  @override
  _SuiviDesCommandesState createState() => _SuiviDesCommandesState();
}

class _SuiviDesCommandesState extends State<SuiviDesCommandes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une commande"),
        backgroundColor: Colors.green,
      ),
      body: const MyCustomForm(),

      );
  }
}
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<MyCustomForm> {
  bool trans=false;
  Transport transport = new Transport("","","");
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime(2020, 11, 17);
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      // _controller.text=newDate as String;
      setState(() {
        _date = newDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      children: [Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  suffixIcon:  IconButton(icon: Icon(Icons.calendar_today), onPressed:_selectDate,),
                  labelText: 'Date de livraison',
                  border: OutlineInputBorder(),
                ),
              ),
              Divider(thickness: 1,),
              InkWell(
                onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AddEspeces()))},
                child: ListTile(
                  title: Text('Produits',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                  subtitle: Text("Ajouter les produits à vendre"),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Icon(Icons.add),
                      // icon-2
                    ],
                  ),
                ),
              ),
              Divider(thickness: 1,),
              InkWell(
                onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AddClients()))},
                child: ListTile(
                  title: Text('Client',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                  subtitle: Text("Ajouter le client"),
                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      Icon(Icons.add),
                      // icon-2
                    ],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {transport = await Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new TransportPage())) ;
              //     if(transport != null){
              //       print(transport.nomChauffeur);
              //     }
              //     setState(() {
              //       transport=transport;
              //       trans=true;
              //     });
              //   },
              //   child: Column(
              //     children: [
              //       ListTile(
              //         title: Text("Transport",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
              //         subtitle: Text("Ajouter une methode de transport"),
              //         trailing: Wrap(
              //           spacing: 12, // space between two icons
              //           children: <Widget>[
              //             Icon(Icons.add),
              //             // icon-2
              //           ],
              //         ),
              //
              //       ),
              //         if(trans==true)...[
              //         Align(
              //           alignment: Alignment.centerLeft,
              //           child: Container(
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: <Widget>[
              //                     Text("Chauffeur :",style: TextStyle(fontWeight: FontWeight.bold)),
              //                     Text(transport.nomChauffeur),
              //                     Text("Numéro de télephone :",style: TextStyle(fontWeight: FontWeight.bold)),
              //                     Text(transport.numTelephone),
              //                     Text("Immatriculation de son véhicule :",style: TextStyle(fontWeight: FontWeight.bold)),
              //                     Text(transport.immVehicule),
              //                   ],
              //                 ),
              //             ),
              //         ),
              //           ],
              //     ],
              //   ),
              // ),
              Divider(thickness: 1,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    );
  }
}
