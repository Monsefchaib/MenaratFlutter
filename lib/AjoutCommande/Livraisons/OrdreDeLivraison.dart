
import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/Livraisons/AfficherLivraisons.dart';
import 'package:suiviventes/AjoutCommande/Livraisons/AjouterLivraison.dart';
import 'package:suiviventes/AjoutCommande/Livraisons/AjouterOrdreDeLivraison.dart';
import 'package:suiviventes/Models/Commande.dart';
import 'package:suiviventes/Models/Livraison.dart';
import 'package:suiviventes/Models/Ordre.dart';
import 'package:suiviventes/Models/OrdreItems.dart';

class OrdreDeLivraison extends StatefulWidget {
  Commande? commande;
  OrdreDeLivraison(this.commande);

  @override
  _OrdreDeLivraisonState createState() => _OrdreDeLivraisonState(this.commande);
}

class _OrdreDeLivraisonState extends State<OrdreDeLivraison> {
  Ordre ordre = new Ordre.vide();
  List<Ordre> listRestes = [];
  bool stop = false;
  var reste = List.generate(50, (i) => List.filled(50, 0, growable: true), growable: true);
  var totalLivraisons = List.generate(50, (i) => List.filled(50, 0, growable: true), growable: true);
  //
  // List<int>? totalLivraisons = List.generate(
  //     2, (i) => 0,growable: true);
  Commande? commande;
  _OrdreDeLivraisonState(this.commande);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Commande.getCommandeById(commande!.id!),
        builder: (context, AsyncSnapshot<Commande> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
        appBar: AppBar(
          title: Text("Livraison"),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.white,
              child:
                  Row(
                    children: <Widget>[
                      Spacer(),
                      ElevatedButton(onPressed: (){
                       Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AddOrdreDeLivraison(snapshot.data!))).then((value) => setState(() {}));
                      }, child: Text("Ajouter un ordre de livraison")),
                    ],
                  ),
            ),
            SizedBox(height: 10,),
                  ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.listOrdres!.length,
                      itemBuilder: (BuildContext context,int index){
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        calculResteLivraison(snapshot.data!.listOrdres!);
                        return    Container(
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                        ),
                            ),
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text("Article", style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,)),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.listOrdres![index].itemsToOrder!.length,
                                  itemBuilder: (BuildContext context,int i){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Row(
                                          children: <Widget>[
                                            Text(snapshot.data!.listOrdres![index].itemsToOrder![i].variete!,style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold,)),
                                            Spacer(),
                                            Text("Nombre à livrer : " + "${
                                                snapshot.data!.listOrdres![index].itemsToOrder![i]
                                                  .nombreALivrer!
                                            }",style: TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                                            Spacer(),

                                            Text("Reste à livrer : " + "${
                                                reste[index][i]
                                            }"
                                                ,style: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),

                                          ],
                                        ),

                                      ],
                                    );
                                  }
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  ElevatedButton(onPressed: ()  async { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AfficherLivraison(snapshot.data!.listOrdres![index].livraisons)));},
                                    child: Text("Historique des livraisons"), style: ElevatedButton.styleFrom(
                                      primary: Colors.indigo, // This is what you need!
                                    ), ),
                                  Spacer(),
                                  ElevatedButton(onPressed: ()  async { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AjouterLivraison(snapshot.data!.listOrdres![index],snapshot.data!,index,reste[index]))).then((value) => setState(() {}));},
                                    child: Text("Livrer"), style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // This is what you need!
                                    ), ),
                                ],
                              ),

                              SizedBox(height: 10,),
                            ],
                          ),
                        );
                      }
                  ),
          ],
        ),
      );
  }
    );
  }


  calculResteLivraison(List<Ordre> listOrders ) {
    if (!stop) {
      for (int i = 0; i < listOrders.length; i++) {
        for(int j=0;j<listOrders[i].itemsToOrder!.length;j++){
          reste[i][j] = listOrders[i].itemsToOrder![j].nombreALivrer!;
        }
      }
      for (int i = 0; i < listOrders.length; i++) {
        for (int j = 0; j < listOrders[i].livraisons!.length; j++) {
          for(int k=0;k<listOrders[i].livraisons![j].articlesLivree!.length;k++){
            totalLivraisons[i][k]+= listOrders[i].livraisons![j].articlesLivree![k].nombreALivrer!;
          }
        }
      }
      for(int i=0;i<reste.length;i++){
        for(int j=0;j<reste.length;j++){
          reste[i][j]=reste[i][j]-totalLivraisons[i][j];
        }

      }


      stop = true;
    }


  }

}
