

import 'package:flutter/material.dart';
import 'package:suiviventes/ProduitsForms/FiguierForm.dart';
import 'package:suiviventes/ProduitsForms/OlivierForm.dart';
import 'package:suiviventes/ProduitsForms/PommierForm.dart';

import '../ProduitsForms/AmandierForm.dart';
import '../ProduitsForms/ArganierForm.dart';
import '../ProduitsForms/CaroubierForm.dart';
import '../ProduitsForms/VigneForm.dart';

class AddEspeces extends StatefulWidget {
  @override
  _AddEspecesState createState() => _AddEspecesState();
}

class _AddEspecesState extends State<AddEspeces> {
  var _locations = ['Olivier', 'Amandier', 'Arganier', 'Figuier',"Pommier","Caroubier","Vigne"];
  String selectedLocation = 'Olivier';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter les especes"),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
              children: [
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                 InputDecorator(
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
                  labelText: 'Espèce',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                    value: selectedLocation,
                    icon: const Icon(Icons.arrow_circle_down),
                    iconSize: 20,
                    elevation: 16,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                        print(selectedLocation);
                      });
                    },
                    items: List.generate(
                      _locations.length,
                          (index) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              _locations[index]
                          ),
                        ),
                        value: _locations[index],
                      ),
                    ),
            ),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                if (selectedLocation == "Olivier") ...[
                  OlivierForm(),
                ],
                if(selectedLocation == "Caroubier")...[
                  CaroubierForm(),
                ],
                if(selectedLocation == "Amandier")...[
                  AmandierForm(),
                ],
                if(selectedLocation == "Arganier")...[
                  ArganierForm(),
                ],
                if (selectedLocation == "Figuier") ...[
                 FiguierForm(),
                ],
                if (selectedLocation == "Pommier") ...[
                  PommierForm(),
                ],
                if (selectedLocation == "Vigne") ...[
                  VigneForm(),
                ],
              ],
      ),
    );
  }
}
