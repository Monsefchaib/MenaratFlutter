
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Avance.dart';

class AfficherAvances extends StatefulWidget {
  List<Avance>? listAvances;
  AfficherAvances(this.listAvances);


  @override
  _AfficherAvancesState createState() => _AfficherAvancesState(this.listAvances);
}

class _AfficherAvancesState extends State<AfficherAvances> {
  List<Avance>? listAvances;
  _AfficherAvancesState(this.listAvances);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Les avances"),
        ),
      body:Column(
        children: [
          Text("Historique des avances",style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Montant",style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Mode de paiement",style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Localisation",style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold))
            ],

          ),
          SizedBox(height:20),
          Container(
            margin: const EdgeInsets.only(left:10,right: 10),
            width: double.infinity,
            color: Colors.white,
            child:    ListView.builder(
              itemCount: listAvances!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text("${listAvances![index].montant}",style: TextStyle(
                                  fontSize: 14)),
                            ),
                            Expanded(
                              child: Text("${listAvances![index].modePaiement}",style: TextStyle(
                                  fontSize: 14)),
                            ),
                            Expanded(
                              child: Text("${listAvances![index].location}",style: TextStyle(
                                  fontSize: 14)),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        SizedBox(height: 8,),
                        Divider(thickness: 1,),

                      ]
                  ),
                );
              },),
          ),
        ],
      )
    );
  }
}
