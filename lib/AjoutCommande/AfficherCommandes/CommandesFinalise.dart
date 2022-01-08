
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Commande.dart';

import 'ResumeDeLaCommande.dart';

class CommandesFinalise extends StatefulWidget {
  @override
  _CommandesFinaliseState createState() => _CommandesFinaliseState();
}

class _CommandesFinaliseState extends State<CommandesFinalise> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Commande.getCommandes("Complété"),
        builder: (context, AsyncSnapshot<List<Commande>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return
                  Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ResumeDeLaCommande(snapshot.data![i],true)));},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snapshot.data![i].id!, style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold,)),
                                  SizedBox(height: 5,), // <-- Spacer
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/user.png', height: 15,
                                              width: 15,
                                              fit: BoxFit.cover,),
                                            SizedBox(width: 5), // give it width
                                            Text(snapshot.data![i].client!.nom + " " + snapshot.data![i].client!.prenom,
                                              style: TextStyle(fontSize: 13),),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(padding: const EdgeInsets.all(1.0),
                                        child: Text(snapshot.data![i].status!, style: TextStyle(
                                            fontSize: 13, color: Colors.white)),
                                        color: Colors.green,),
                                    ],
                                  ),
                                  SizedBox(height: 5,), // <-- Spacer
                                  Text("- Les articles :"),
                                  SizedBox(height: 5,), // <-- Spacer
                                  Row(
                                    children: [
                                      Text(snapshot.data![i].articles![0].lot!.variete!+ " ... ",
                                          style: TextStyle(color: Colors.grey)),
                                      Spacer(),
                                      Text("${snapshot.data![i].prixTotal} DH", style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.bold,))
                                    ],
                                  ),
                                  Spacer(),
                                  Divider(thickness: 2,),
                                  Row(
                                    children: [
                                      Text(snapshot.data![i].date!, style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.bold,)),
                                      Spacer(),
                                      Text("...", style: TextStyle(fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  );

              }
          );
        }
    );
  }
}
