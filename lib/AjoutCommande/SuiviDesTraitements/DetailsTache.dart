

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:suiviventes/Models/Products.dart';
import 'SelectionnerLeLotTraitement.dart';

class DetailsTache extends StatefulWidget {
  @override
  _DetailsTacheState createState() => _DetailsTacheState();
}

class _DetailsTacheState extends State<DetailsTache> with InputValidationMixin{
  String _typeValue = '';
  var susbtrat=['','Traitement Phytosanitaire','Fertilisation'];
  String _motifValue = '';
  var motif=['','Maladie','Ennemi','Mauvaise Herbes','Qualité des plantes','Traitement Préventif'];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _timeStartController = TextEditingController();
  final TextEditingController _timeFinishController = TextEditingController();
  final TextEditingController controllerProduit = TextEditingController();
  final TextEditingController _dose = TextEditingController();
  final TextEditingController _typeProduit = TextEditingController();
  final TextEditingController _quantite = TextEditingController();
  final TextEditingController _observations = TextEditingController();
  final _nomCommercial = TextEditingController();
  final _matiereActive = TextEditingController();
  bool _edit = false;
  Product selectedProduct = new Product("", "", "", "");
  final TextEditingController _unite = TextEditingController();
  int numberOfProduits = 1;
  DateTime _date = DateTime.now();
  TimeOfDay selectedTimeStart = TimeOfDay.now();
  TimeOfDay selectedTimeFinish = TimeOfDay.now();
  final formGlobalKey = GlobalKey < FormState > ();

  void _selectTime(fromWhere) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedTimeStart,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      if(fromWhere == "finish") {
        setState(() {
          selectedTimeFinish = newTime;
          _timeFinishController.text = selectedTimeFinish.format(context).toString();
        });
      }
      if(fromWhere == "start") {
        setState(() {
          selectedTimeStart = newTime;
          _timeStartController.text = selectedTimeStart.format(context).toString();
        });
      }
    }
  }

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
      helpText: "Date de l'opération",
    );
    if (newDate != null) {
      // _controller.text=newDate as String;
      setState(() {
        _date = newDate;
        _controller.text = "${_date.day}-${_date.month}-${_date.year}";

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details de la tâche"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidate: true,
              key: formGlobalKey,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text("Ajouter une tâche : " , style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,)),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // This is what you need!
                          ),
                          onPressed: (){
                            setState(() {
                              _edit=true;
                            });
                          },
                          // onPressed: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ReserverCommande(snapshot.data!,resteAPayer))).then((value) => setState(() {this.calculReste();}));},
                          child: Text("Modifier la tâche"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      enabled: _edit ? true : false,
                      controller: _matiereActive,
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        labelText: 'Nom de la tâche',
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      onChanged: (String? value){
                        print(value);
                      },
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SelectionnerLotTraitement()));

                      },
                      leading:
                      Text("Selectionner les lots",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),

                      subtitle: Text("Emplacement de l'opération",style: TextStyle(color: Colors.grey),),
                      trailing:
                      Icon(Icons.keyboard_arrow_right),
                    ),
                    SizedBox(height: 20,),
                    InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        labelText: 'Type',
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child:DropdownButtonFormField<String>(
                        itemHeight: 48,
                        isDense: false,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent))),
                        validator: !_edit ? null : (selection) {
                          if (isSelectionValid(selection!))
                            return null;
                          else
                            return 'Selectionnez une valeur valide';
                        },
                        isExpanded: true,
                        value: _typeValue,
                        icon: const Icon(Icons.arrow_circle_down),
                        iconSize: 20,
                        elevation: 16,
                        onChanged: !_edit ? null : (String? newValue) {
                          setState(() {
                            _typeValue = newValue!;
                            print(_typeValue);
                          });
                        },
                        items: List.generate(
                          susbtrat.length,
                              (index) => DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  susbtrat[index]
                              ),
                            ),
                            value: susbtrat[index],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      enabled: _edit ? true : false,
                      validator: (date) {
                        if (isDateValid(date!)) return null;
                        else
                          return 'Entrez une date valide';
                      },
                      readOnly: true,
                      showCursor: false,
                      enableInteractiveSelection: true,
                      controller: _controller,
                      decoration: InputDecoration(

                        suffixIcon:  IconButton(icon: Icon(Icons.calendar_today), onPressed:_selectDate,),
                        labelText: 'Date de livraison',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 0.0),
                        labelText: "Motif de l'opération",
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child:DropdownButtonFormField<String>(
                        itemHeight: 48,
                        isDense: false,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent))),
                        validator: !_edit ? null : (selection) {
                          if (isSelectionValid(selection!))
                            return null;
                          else
                            return 'Selectionnez une valeur valide';
                        },
                        isExpanded: true,
                        value: _motifValue,
                        icon: const Icon(Icons.arrow_circle_down),
                        iconSize: 20,
                        elevation: 16,
                        onChanged: !_edit ? null :
                            (String? newValue) {
                          setState(() {
                            _motifValue = newValue!;
                            print(_motifValue);
                          });
                        },
                        items: List.generate(
                          motif.length,
                              (index) => DropdownMenuItem(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  motif[index]
                              ),
                            ),
                            value: motif[index],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    ListView.builder(
                      itemCount: numberOfProduits,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return  Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text("Produit ${index+1} : " , style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold,)),
                                        Spacer(),
                                        IconButton(
                                          iconSize:25,
                                          color: Colors.red,
                                          icon: Icon(Icons.remove_circle),
                                          onPressed: (){
                                            setState(() {
                                              this.numberOfProduits>1?this.numberOfProduits--:null;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          iconSize:25,
                                          color: Colors.blue,
                                          icon: Icon(Icons.add_circle),
                                          onPressed: (){
                                            setState(() {
                                              this.numberOfProduits++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child:   TypeAheadFormField<Product?>(
                                            debounceDuration: Duration(milliseconds: 500),
                                            textFieldConfiguration: TextFieldConfiguration(
                                              enabled: _edit? true:false,
                                              controller: _nomCommercial,
                                              decoration: InputDecoration(
                                                labelText: 'Produit',
                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 20.0, vertical: 10.0),
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            suggestionsCallback: Product.getProducts,
                                            itemBuilder: (context, Product? suggestions){
                                              return ListTile(
                                                title: Text(suggestions!.nom_commercial!),
                                              );
                                            },
                                            noItemsFoundBuilder: (context)=>Container(
                                              height: 100,
                                              child: Center(
                                                child: Text("Aucun produit n'est trouvé", style: TextStyle(fontSize: 24),),
                                              ),
                                            ),
                                            onSuggestionSelected: (Product ? suggestion) {
                                              setState(() {
                                                selectedProduct=suggestion!;
                                                _nomCommercial.text=selectedProduct.nom_commercial!;
                                                _matiereActive.text=selectedProduct.matiere_active!;
                                                _typeProduit.text=selectedProduct.categorie!;

                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: TextFormField(
                                            enabled: _edit ? true : false,
                                            controller: _matiereActive,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10.0),
                                              labelText: 'Matière active',
                                              border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                            ),
                                            onChanged: (String? value){
                                              print(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            enabled: _edit ? true : false,
                                            controller: _dose,
                                            keyboardType: TextInputType.number,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10.0),
                                              labelText: 'Dose',
                                              border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                            ),
                                            onChanged: (String? value){
                                              print(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: TextFormField(
                                            enabled: _edit ? true : false,
                                            controller: _typeProduit,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10.0),
                                              labelText: 'Catégorie',
                                              border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                            ),
                                            onChanged: (String? value){
                                              print(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextFormField(
                                            enabled: _edit ? true : false,
                                            controller: _quantite,
                                            keyboardType: TextInputType.number,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10.0),
                                              labelText: 'Quantité',
                                              border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                            ),
                                            onChanged: (String? value){
                                              print(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: TextFormField(
                                            enabled: _edit ? true : false,
                                            controller: _unite,
                                            decoration:  InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 10.0),
                                              hintText: 'Unité',
                                              labelText:'Unité',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey
                                              ),
                                              border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                            ),
                                            onChanged: (String? value){
                                              print(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        );

                      },),
                    TextFormField(
                      enabled: _edit ? true : false,
                      controller: _observations,
                      minLines: 2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Observations...',
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(right:8.0,left: 8.0),
          child:
          !_edit ? Row(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, // This is what you need!
                ),
                onPressed: (){},
                // onPressed: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ReserverCommande(snapshot.data!,resteAPayer))).then((value) => setState(() {this.calculReste();}));},
                child: Text("Associer"),
              ),
              Spacer(),
              SizedBox(width: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // This is what you need!
                ),
                onPressed: (){},
                // onPressed: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ReserverCommande(snapshot.data!,resteAPayer))).then((value) => setState(() {this.calculReste();}));},
                child: Text("Valider"),
              )
            ],
          ):
          Row(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // This is what you need!
                ),
                onPressed: (){
                  setState(() {
                    _edit=false;
                  });
                },
                // onPressed: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ReserverCommande(snapshot.data!,resteAPayer))).then((value) => setState(() {this.calculReste();}));},
                child: Text("Annuler"),
              ),
              Spacer(),
              SizedBox(width: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // This is what you need!
                ),
                onPressed: (){},
                // onPressed: () { Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new ReserverCommande(snapshot.data!,resteAPayer))).then((value) => setState(() {this.calculReste();}));},
                child: Text("Sauvegarder"),
              )
            ],
          )
          ,
        ),
      ),
    );
  }
}
mixin InputValidationMixin {
  bool isDateValid(String date) => date.isNotEmpty && date!='';
  bool isSelectionValid(String selection) => selection.isNotEmpty && selection!='';
}