
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Livraison.dart';

class AfficherLivraison extends StatefulWidget {
  List<Livraison>? livraisons;
  AfficherLivraison(this.livraisons);

  @override
  _AfficherLivraisonState createState() => _AfficherLivraisonState(this.livraisons);
}

class _AfficherLivraisonState extends State<AfficherLivraison> {
  List<Livraison>? livraisons;
  _AfficherLivraisonState(this.livraisons);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Livraisons"),
      ),
      body: Column(
        children: [
          Text("Historique des livraisons",style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
              itemCount: livraisons!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return  Column(
                  children: [
                    Text(livraisons![index].date!,style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                    ListView.builder(
                    itemCount: livraisons![index].articlesLivree!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [
                                  Text(livraisons![index].articlesLivree![i].espece! + " : " + livraisons![index].articlesLivree![i].variete!,style: TextStyle(
                                      fontSize: 14)),
                                  Spacer(),
                                  Text("Quantité livrée : "+
                                      "${livraisons![index].articlesLivree![i].nombreALivrer}",style: TextStyle(
                                      fontSize: 14))
                                ],
                              ),
                              SizedBox(height: 5,),
                              SizedBox(height: 8,),
                              Divider(thickness: 1,),

                            ]
                        ),
                      );
                      },),
                  ],
                );

              },),
          ),
        ],
      )
    );
  }
}
