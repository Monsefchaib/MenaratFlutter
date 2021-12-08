import 'package:flutter/material.dart';

import 'Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Login()),) },
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
            onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Login()),) },
            child: GridTile(
                child:Image.asset('assets/images/gasoline.png',fit: BoxFit.fill,),
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: <Widget>[
                          Text("Suivi Consommation Gasoil",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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
              onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new Login()),) },
              child: GridTile(
                  child:Image.asset('assets/images/leaf.png',fit: BoxFit.fill,),
                  // header: Container(child: Image.network('https://cdn-icons.flaticon.com/png/512/4862/premium/4862389.png?token=exp=1638558488~hmac=380e232ba8604e14729be05e6d36d408')),
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          children: <Widget>[
                            Text("Suivi des traitements",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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



