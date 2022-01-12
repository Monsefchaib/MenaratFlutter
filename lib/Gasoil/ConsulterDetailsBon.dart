import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suiviventes/Gasoil/AfficherJustificatif.dart';
import 'package:suiviventes/Models/Bons.dart';
import 'package:suiviventes/Models/PDFApi.dart';

import 'GetBonGenere.dart';

class ConsulterDetailsBon extends StatefulWidget {
  Bons bon;
  ConsulterDetailsBon(this.bon);

  @override
  _ConsulterDetailsBonState createState() => _ConsulterDetailsBonState(this.bon);
}

class _ConsulterDetailsBonState extends State<ConsulterDetailsBon> {
  Bons bon;
  _ConsulterDetailsBonState(this.bon);
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: Bons.getBonById(bon.id!),
        builder: (context, AsyncSnapshot<Bons> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          print(snapshot.data!.vehicule);
          return  Scaffold(
            appBar: AppBar(title: Text("Details du bon")
            ,
            backgroundColor: Colors.red,),
            body:ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 100,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(snapshot.data!.id!, style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,)),
                            Spacer(),
                            Text(snapshot.data!.date! ,style: TextStyle(
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
                            Text("Nom du beneficiaire",
                              style: TextStyle(fontSize: 13),),
                            Spacer(),
                            Text("Montant Total: " + "${snapshot.data!.montant!}",style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,))
                          ],
                        ),
                        SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.all(1.0),
                            color: Colors.blue,
                            child: Text(snapshot.data!.type!,style: TextStyle(
                            fontSize: 14, color: Colors.white)),
                          ),
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
                      Divider(thickness: 1,),
                      ListView.builder(  itemCount: snapshot.data!.engins!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(snapshot.data!.engins![index].nom+ " : ",style: TextStyle(
                                          fontSize: 14)),
                                      Spacer(),
                                      Text("Montant : "+
                                          "${snapshot.data!.engins![index].montant} Dhs",style: TextStyle(
                                          fontSize: 14 , fontWeight: FontWeight.bold,))
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
              snapshot.data!.vehicule!.nomVehicule !=""? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(snapshot.data!.vehicule!.nomVehicule + "  ",style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold,)),
                          Spacer(),
                          Text("Matricule : "+
                              "${snapshot.data!.vehicule!.immatricule} ",style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold,))
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("Kilometrage : "),
                          Text("${snapshot.data!.vehicule!.kilometrage}"+ " KM ",style: TextStyle(
                              fontSize: 14)),
                          Spacer(),
                          Text("Montant : "+
                              "${snapshot.data!.montant} Dhs",style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold,))
                        ],
                      ),
                      SizedBox(height: 8,),
                      Divider(thickness: 1,),
                    ]
                ),
              ):Container(),
                SizedBox(height: 10,),
                snapshot.data!.location !=" "?  new Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Localisation :",style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,) ),
                        SizedBox(height: 5,),
                        Text(snapshot.data!.location!),
                      ],
                    ),
                  ),
                ):Container(),
                SizedBox(height: 10,),
                Container(
                  color: Colors.grey[100],
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      ListTile(
                        onTap: () async{
                          showAlertDialog(context);
                          final file = await PDFApi.loadBonCarburant(snapshot.data!.pdfUrl!);
                          Navigator.pop(context);
                          openPDF(context, file);
                        },
                        leading:
                        Text("Bon du carburant",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        subtitle: Text("Voir le bon du       carburant     ",style: TextStyle(color: Colors.grey),),
                        trailing:
                        Icon(Icons.keyboard_arrow_right),
                      )

                  ),
                ),
                SizedBox(height: 10,),
               snapshot.data!.justifUrl != " " ? new Container(
                 color: Colors.grey[100],
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      ListTile(
                        onTap: () async{
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AfficherJustificatif(snapshot.data!)));
                        },
                        leading:
                        Text("Justificatif ",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        subtitle: Text(" Voir le                                         justificatif",style: TextStyle(color: Colors.grey),),
                        trailing:
                        Icon(Icons.keyboard_arrow_right),
                      )

                  ),
                ) : Container(),
              ],
            ),
          );
        }
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
