
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/AddEspeces.dart';
import 'package:suiviventes/AjoutCommande/SearchLots.dart';
import 'package:suiviventes/Gasoil/GetBonGenere.dart';
import 'package:suiviventes/Models/Article.dart';
import 'package:suiviventes/Models/Client.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/Lots.dart';
import 'package:suiviventes/Models/PDFApi.dart';
import 'package:suiviventes/Models/Produits.dart';
import 'package:suiviventes/Models/Transport.dart';

import '../Home.dart';
import 'Clients.dart';
import 'SearchLots2.dart';
import 'SearchLots3.dart';
String? pdfURL;
final TextEditingController _controller = TextEditingController();
class SuiviDesCommandes extends StatefulWidget {
  static void pdfSetUrl(String url){
    pdfURL = url;
  }
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


class MyCustomFormState extends State<MyCustomForm> with InputValidationMixin{
  bool _isClient = false;
  bool _isProduit = false;
  double prixTotal = 0;
  DateTime now = new DateTime.now();
  Lots lot = Lots(" "," ", " ", " ", " ", 0, 0);
  List listArticles = [];
  Client client = Client(" "," "," "," ");
  bool trans=false;
  Article article = Article(Lots(" "," ", " ", " ", " ", 0, 0),"","",0,0);
  bool isProduits=false;
  bool isArticles=false;
  Transport transport = new Transport("","","");
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017),
      lastDate: DateTime.now(),
      helpText: "Date de l'opération",
    );
    if (newDate != null) {
      // _controller.text=newDate as String;
      setState(() {
        _date = newDate;
        _controller.text = "${_date.day}-${_date.month}-${_date.year}";

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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text("Ajouter une commande :",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (date) {
                    if (isDateValid(date!)) return null;
                    else
                      return 'Entrez une date valide';
                  },
                  readOnly: true,
                  showCursor: false,
                  enableInteractiveSelection: true,
                  controller: _controller,
                  decoration: InputDecoration(

                    suffixIcon:  IconButton(icon: Icon(Icons.calendar_today), onPressed:_selectDate,),
                    labelText: 'Date de commande',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(thickness: 1,),
                InkWell(
                  onTap: () async { article = await Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AddEspeces()));
                  setState(() {
                       article = article;
                       listArticles.add(article);
                        isArticles=true;
                      });
                   },
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
                if(isArticles==true)...[
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: listArticles.length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(

                            leading: Icon(Icons.check),
                            trailing: Text("${listArticles[index].quantite}",
                              style: TextStyle(
                                  color: Colors.green,fontSize: 15),),
                            title:Text("${listArticles[index].lot!.variete}"),
                        );
                      }
                  ),
                ],
                Divider(thickness: 1,),
                InkWell(
                  onTap: () async {
                    client = await Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AddClients()));
                    setState(() {
                      trans=true;
                    client=client;
                    });
                    },


                  child: ListTile(
                    title: Text('Client',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                    subtitle: Text("Ajouter la commande"),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        Icon(Icons.add),
                        // icon-2
                      ],
                    ),
                  ),
                ),
              if(trans==true)...[
                Container(
                  padding: EdgeInsets.only(left: 16.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("Nom :  ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Text(client.nom),

                        ],
                      ),
                      Row(
                        children: [
                          Text("Prenom :  ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Text(client.prenom),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Telephone :  ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Text(client.telephone),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Adresse :  ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                          Text(client.adresse),
                        ],
                      ),
                    ],

                  ),
                ),
                ],
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
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _isProduit == false ? new Text("* Chosissez les produits a vendre",style: TextStyle(fontSize: 12,color: Colors.red)): Container(),
                      _isClient == false ? Text("* Choisissez un client",style: TextStyle(fontSize: 12,color:Colors.red)): Container(),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          // if (_formKey.currentState!.validate()) {
                                          //   // If the form is valid, display a snackbar. In the real world,
                                          //   // you'd often call a server or save the information in a database.

                                          // }
                                          if(_formKey.currentState!.validate()){
                                            if(client.prenom!=" " && listArticles!= []){
                                              _isClient=true;
                                              _isProduit=true;
                                              showAlertDialog(context);
                                              await createCommande();
                                              final url = await Commande.getPdfUrl();
                                              final file = await PDFApi.loadCommande(pdfURL!);
                                              openPDF(context, file);
                                            }else{
                                              if(client.nom!=" "){
                                                _isClient=true;
                                                setState(() {

                                                });
                                              }
                                              if(listArticles==[]){
                                                _isProduit=true;
                                                setState(() {

                                                });
                                              }

                                            };

                                          };
    },
                                        child: const Text('Ajouter la commande'),
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
    );
  }
  Future<String> createCommande() async {
    List<Article> listArticlesToSend = List<Article>.from(listArticles);
    prixTotal=0;
    for(Article article in listArticlesToSend){
      prixTotal+=article.prixUnitaire!*article.quantite!;
    }
    print(listArticles);
    Commande commande = Commande.Noid(List<Article>.from(listArticles),client,_controller.text,prixTotal,"","");
    final result = await Commande.createCommande(commande);
    final title = 'Done';
    final text = result.error ? (result.errorMessage) : 'La commande a été ajoutée';

    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
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
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Home()));
      }
    },

    );
     return "";
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => GetBonGenere(file: file)),
  );

  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 8),child:Text("Chargement ..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
mixin InputValidationMixin {
  bool isDateValid(String date) => date.isNotEmpty && date!='';
  bool isSelectionValid(String selection) => selection.isNotEmpty && selection!='' && _controller.text!='';
  bool isMontantValid(int montant)=> montant>0;
  bool isLocalisationValide(String localisation)=> localisation.isNotEmpty && localisation!='Aucune localisation detectee';
  bool isJustifValid(String justif)=>justif.isNotEmpty && justif!='Aucun fichier choisi';
}