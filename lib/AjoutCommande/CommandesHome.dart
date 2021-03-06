import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/AfficherCommandes/AfficherCommandes.dart';

import 'SuiviDesCommandes.dart';

class CommandesHome extends StatefulWidget {
  @override
  _CommandesHomeState createState() => _CommandesHomeState();
}

class _CommandesHomeState extends State<CommandesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menarat Al Houz Travaux"),
          backgroundColor: Colors.green,
          elevation: 1,
        ),
        body:
        GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              child: InkWell(
                onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SuiviDesCommandes()),) },
                child: GridTile(
                    child: Image.asset('assets/images/track.png',fit: BoxFit.fill,),
                    // header: Container(child: Image.network('https://cdn-icons.flaticon.com/png/512/4862/premium/4862389.png?token=exp=1638558488~hmac=380e232ba8604e14729be05e6d36d408')),
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            children: <Widget>[
                              Text("Ajouter une commande",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new AfficherCommandes()),) },
                child: GridTile(
                    child:Image.asset('assets/images/clipboard.png',fit: BoxFit.fill,),
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            children: <Widget>[
                              Text("Les commandes",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SuiviDesCommandes()),) },
                child: GridTile(
                    child:Image.asset('assets/images/gasoline.png',fit: BoxFit.fill,),
                    footer: Container(
                      color: Colors.white70,
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            children: <Widget>[
                              Text("Afficher les commandes",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              ),
            ),
          ],
        )
    );
  }
}
