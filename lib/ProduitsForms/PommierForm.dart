import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Produits.dart';

class PommierForm extends StatefulWidget {
  @override
  _PommierFormState createState() => _PommierFormState();
}

class _PommierFormState extends State<PommierForm> {
  var _locations = [
    '',
    'DOUKKALI',
    'GOLDEN',
    'GRANNY SMITH',
  ];
  String selectedLocation = '';
  // String _porteGreffeValue='';
  // var porteGreffe = ['','M 106','M 111'];
  final FnbrPlantes = TextEditingController();
  final FprixUnitaire = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        children: <Widget>[
          InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Variété',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            child: DropdownButtonHideUnderline(
              child:
              DropdownButton<String>(
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
                      (index) =>
                      DropdownMenuItem(
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
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          TextFormField(
            controller: FnbrPlantes,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Nombre de plantes',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (String? value){
              print(value);
            },
          ),
          Divider(thickness: 1,),
          SizedBox(height: 10,),
          TextFormField(
            controller: FprixUnitaire,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15.0),
              labelText: 'Prix Unitaire',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            onChanged: (String? value){
              print(value);
            },
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            Produit produit = Produit("Pommier",selectedLocation," "," ",int.parse(FnbrPlantes.text),double.parse(FprixUnitaire.text)," ");
            Navigator.pop(context, produit);
          },
            child: Text('Ajouter'),
          ),
        ],
      ),
    );
  }
}
