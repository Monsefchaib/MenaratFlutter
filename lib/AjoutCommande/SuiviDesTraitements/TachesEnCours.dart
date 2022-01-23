
import 'package:flutter/material.dart';
import 'package:suiviventes/AjoutCommande/SuiviDesTraitements/DetailsTache.dart';

class TachesEnCours extends StatefulWidget {
  @override
  _TachesEnCoursState createState() => _TachesEnCoursState();
}

class _TachesEnCoursState extends State<TachesEnCours> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
                Column(
                children: <Widget>[
                    InkWell(
                    onTap: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new DetailsTache())).then((value) => setState(() {}));},
                child: Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
                child: Container(
                height: 120,
                width: double.infinity,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text("Titre Tache", style: TextStyle(
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
                Text("Responsable Tache",
                style: TextStyle(fontSize: 13),),
                ],
                ),
                ),
                Spacer(),
                Container(padding: const EdgeInsets.all(1.0),
                child: Text("En cours", style: TextStyle(
                fontSize: 13, color: Colors.white)),
                color:Colors.orange,),
                ],
                ),
                SizedBox(height: 5,), // <-- Spacer// <-- Spacer
                Row(
                children: [
                Text("Zone"+ " Site", style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold,)),
                Spacer(),
                Text("Type", style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold,))
                ],
                ),
                Spacer(),
                Divider(thickness: 2,),
                Row(
                children: [
                Text("Date", style: TextStyle(
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
    ),
      ],
    );
  }
}
