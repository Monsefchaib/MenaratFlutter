import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/ReserverCommande/ReserverCommande.dart';
import 'package:suiviventes/Gasoil/GetBonGenere.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/PDFApi.dart';

class ResumeDeLaCommande extends StatefulWidget {
  Commande? commande;
  bool? isCompleted;
  ResumeDeLaCommande(this.commande,this.isCompleted);

  @override
  _ResumeDeLaCommandeState createState() => _ResumeDeLaCommandeState(this.commande,this.isCompleted);
}

class _ResumeDeLaCommandeState extends State<ResumeDeLaCommande> {
  Commande? commande;
 bool? isCompleted;
 _ResumeDeLaCommandeState(this.commande,this.isCompleted);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details de la commande")),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 60,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(commande!.id!, style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold,)),
                      Spacer(),
                      Text(commande!.date! ,style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold,))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/user.png', height: 15,
                        width: 15,
                        fit: BoxFit.cover,),
                      SizedBox(width: 5), // give it width
                      Text(commande!.client!.nom + " " + commande!.client!.prenom,
                        style: TextStyle(fontSize: 13),),
                    ],
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListView.builder(  itemCount: commande!.articles!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            children: [
                              Text(commande!.articles![index].lot!.espece! + " : " + commande!.articles![index].lot!.variete!,style: TextStyle(
                                  fontSize: 14)),
                              Spacer(),
                              Text("Quantité : "+
                                  "${commande!.articles![index].quantite}",style: TextStyle(
                                fontSize: 14))
                            ],
                          ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Spacer(),
                                Text("Prix : " +
                                    "${commande!.articles![index].quantite!*commande!.articles![index].prixUnitaire!}" + "Dh",style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold,))
                              ],
                            ),
                            SizedBox(height: 8,),
                            Divider(thickness: 1,),

                          ]
                      ),
                    );
                  },)
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  ListTile(
                    onTap: () async{
                      showAlertDialog(context);
                      final file = await PDFApi.loadCommande(commande!.commandePDF!);
                      Navigator.pop(context);
                      openPDF(context, file);
                    },
                    leading:
                        Text("Bon de la commande",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),

                    subtitle: Text("Voir le bon de la commande",style: TextStyle(color: Colors.grey),),
                    trailing:
                        Icon(Icons.keyboard_arrow_right),
                  )

            ),
          )


        ],
      ),
       bottomNavigationBar: !isCompleted!? new BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(right:8.0,left: 8.0),
          child: Row(
            children: <Widget>[
              Spacer(),
              Text("Prix restent : ",style: TextStyle(
                  fontSize: 14)),
              Text("${commande!.prixTotal}"+" Dh",style: TextStyle(
                  fontSize: 14,fontWeight: FontWeight.bold)),
              SizedBox(width: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // This is what you need!
                ),
                  onPressed: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ReserverCommande(commande!)));},
                child: Text("Réserver la commande"),
              )
            ],
          ),
        ),
      ): Row() ,
    );
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
