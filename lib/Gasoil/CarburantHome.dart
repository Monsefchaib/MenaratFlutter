
import 'package:flutter/material.dart';
import 'package:suiviventes/Gasoil/ConsulterLesBonsDeCarburant.dart';

import 'GenererBonGasoil.dart';

class CarburantHome extends StatefulWidget {
  @override
  _CarburantHomeState createState() => _CarburantHomeState();
}

class _CarburantHomeState extends State<CarburantHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Suivi Consommation Carburant"),
      ),
      body:  GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            child: InkWell(
              onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ConsulterLesBonsDeCarburant()),) },
              child: GridTile(
                  child: Image.asset('assets/images/track.png',fit: BoxFit.fill,),
                  // header: Container(child: Image.network('https://cdn-icons.flaticon.com/png/512/4862/premium/4862389.png?token=exp=1638558488~hmac=380e232ba8604e14729be05e6d36d408')),
                  footer: Container(
                    color: Colors.white70,
                    child:
                            Text("Consulter les bons de carburant",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),

                    ),
                  )
              ),
            ),
          Card(
            child: InkWell(
              onTap: ()=> {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new GenererBonGasoil()),) },
              child: GridTile(
                  child:Image.asset('assets/images/gasoline.png',fit: BoxFit.fill,),
                  footer: Container(
                    color: Colors.white70,
                           child: Text("Générer un bon de Carburant",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),

              ),
            ),
          ),

        ],
      ),
    );
  }
}
