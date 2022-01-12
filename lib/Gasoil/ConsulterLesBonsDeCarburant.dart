
import 'package:flutter/material.dart';
import 'package:suiviventes/Gasoil/ConsulterDetailsBon.dart';
import 'package:suiviventes/Models/Bons.dart';

class ConsulterLesBonsDeCarburant extends StatefulWidget {
  @override
  _ConsulterLesBonsDeCarburantState createState() => _ConsulterLesBonsDeCarburantState();
}

class _ConsulterLesBonsDeCarburantState extends State<ConsulterLesBonsDeCarburant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulter les bons de carburant"),
        backgroundColor: Colors.red,
      ),
      body:  Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FutureBuilder(
            future: Bons.getBons(),
            builder: (context, AsyncSnapshot<List<Bons>> snapshot) {
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
                            onTap: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ConsulterDetailsBon(snapshot.data![i]))).then((value) => setState(() {}));},
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
                                                Text(" Nom du bénéficiaire" ,
                                                  style: TextStyle(fontSize: 13,color: Colors.grey),),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(padding: const EdgeInsets.all(1.0),
                                            child: Text(snapshot.data![i].type!, style: TextStyle(
                                                fontSize: 13, color: Colors.white)),
                                            color:  Colors.blue,),
                                        ],
                                      ),
                                      SizedBox(height: 5,), // <-- Spacer
                                      Text("- Véhicule :"),
                                      SizedBox(height: 5,), // <-- Spacer
                                      Container(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/drive.png', height: 15,
                                              width: 15,
                                              fit: BoxFit.cover,),
                                            SizedBox(width: 5), // give it width
                                            snapshot.data![i].vehicule!.nomVehicule != "" ? new Text(snapshot.data![i].vehicule!.nomVehicule +" "+ snapshot.data![i].vehicule!.immatricule,
                                              style: TextStyle(fontSize: 13,color: Colors.grey),): new Text("Engins ... ",
                                              style: TextStyle(fontSize: 13,color: Colors.grey),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,), // <-- Spacer
                                      Row(
                                        children: [
                                          Spacer(),
                                            Text("${snapshot.data![i].montant}"+" DH", style: TextStyle(
                                            fontSize: 13, fontWeight: FontWeight.bold,)),
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
        ),
      ),
    );
  }
}
