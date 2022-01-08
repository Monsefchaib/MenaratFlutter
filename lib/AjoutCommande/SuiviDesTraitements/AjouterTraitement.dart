
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AjouterTraitement extends StatefulWidget {
  @override
  _AjouterTraitementState createState() => _AjouterTraitementState();
}

class _AjouterTraitementState extends State<AjouterTraitement> {
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
  final TextEditingController _unite = TextEditingController();
  int numberOfProduits = 1;
  DateTime _date = DateTime.now();
  TimeOfDay selectedTimeStart = TimeOfDay.now();
  TimeOfDay selectedTimeFinish = TimeOfDay.now();

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
        title: Text("Ajouter traitement"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Ajouter un traitement : " , style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,)),
                  SizedBox(height: 20,),
                  ListTile(
                    onTap: () {

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
                          horizontal: 20.0, vertical: 10.0),
                      labelText: 'Type',
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child:DropdownButton<String>(
                      isExpanded: true,
                      value: _typeValue,
                      icon: const Icon(Icons.arrow_circle_down),
                      iconSize: 20,
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          showCursor: false,
                          enableInteractiveSelection: true,
                          controller: _timeStartController,
                          decoration: InputDecoration(
                            suffixIcon:  IconButton(icon: Icon(Icons.access_time), onPressed:()=>_selectTime("start"),),
                            labelText: "Heure de démarrage de l'opération",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          showCursor: false,
                          enableInteractiveSelection: true,
                          controller: _timeFinishController,
                          decoration: InputDecoration(
                            suffixIcon:  IconButton(icon: Icon(Icons.access_time), onPressed:()=>_selectTime("finish"),),
                            labelText: "Heure de fin de l'opération",
                            border: OutlineInputBorder(),
                          ),

                        ),
                      ),
                    ],
                  ),
                    SizedBox(height: 20,),
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      labelText: "Motif de l'opération",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child:DropdownButton<String>(
                      isExpanded: true,
                      value: _motifValue,
                      icon: const Icon(Icons.arrow_circle_down),
                      iconSize: 20,
                      elevation: 16,
                      underline: Container(),
                      onChanged: (String? newValue) {
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

                                SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
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
                                        controller: _typeProduit,
                                        decoration:  InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          labelText: 'Type de produit',
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
                  Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(onPressed: (){}, child: Text("Ajouter le traitement"))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget searchProduit() =>
      Column(
          children: [
            // TypeAheadFormField<Client?>(
            //   debounceDuration: Duration(milliseconds: 500),
            //   textFieldConfiguration: TextFieldConfiguration(
            //     controller: controllerProduit,
            //     decoration: InputDecoration(
            //       labelText: 'Client',
            //       border: OutlineInputBorder(),
            //     ),
            //   ),
            //   suggestionsCallback: Client.getClientSuggestions,
            //   itemBuilder: (context, Client? suggestions){
            //     final client=suggestions!;
            //     return ListTile(
            //       title: Text(client.nom +" "+ client.prenom),
            //     );
            //   },
            //   noItemsFoundBuilder: (context)=>Container(
            //     height: 100,
            //     child: Center(
            //       child: Text("Aucun client n'est trouvé", style: TextStyle(fontSize: 24),),
            //     ),
            //   ),
            //   onSuggestionSelected: (Client ? suggestion) {
            //     clientToShow=suggestion!;
            //     Navigator.pop(context, suggestion);
            //   },
            // ),

          ]

      );

}
