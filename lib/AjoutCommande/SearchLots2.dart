
import 'package:flutter/material.dart';
import 'package:suiviventes/Models/Lots.dart';
import 'package:suiviventes/Models/Produits.dart';

enum SingingCharacter { lafayette, jefferson }
enum SortType { asc, desc }

class SearchLots2 extends StatefulWidget {
  @override
  _SearchLots2State createState() => _SearchLots2State();
}

class _SearchLots2State extends State<SearchLots2> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  SortType? _sort = SortType.desc;
  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chercher les lots"),
        actions: <Widget>[
          IconButton(onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => StatefulBuilder(
    builder: (BuildContext context, StateSetter mystate /*You can rename this!*/) {
    return makeDismissible(
      child: DraggableScrollableSheet(
        maxChildSize: 0.9,
        minChildSize: 0.3,
        initialChildSize: 0.7,
        builder: (_, controller) =>
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  )
              ),
              //   padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Trier par", style: TextStyle(fontWeight: FontWeight.bold)),

                    Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: RadioListTile<SortType>(
                        contentPadding: EdgeInsets.all(0.0), dense: true,
                        title: const Text('Quantité : croissante'),
                        value: SortType.asc,
                        groupValue: _sort,
                        onChanged: (SortType? value) {
                          mystate(() {
                            _sort = value;
                            print(_sort.toString().split('.').last);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<SortType>(
                        contentPadding: EdgeInsets.all(0.0), dense: true,
                        title: const Text('Quantité : croissante'),
                        value: SortType.asc,
                        groupValue: _sort,
                        onChanged: (SortType? value) {
                          mystate(() {
                            _sort = value;
                            print(_sort.toString().split('.').last);
                          });
                        },
                      ),
                    ),
                    ],
                        ),
                    FutureBuilder(
                        future: Produit.getProduits(),
                        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      height: 170.0,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 8.0,
                                      ),
                                      child: new Stack(
                                        children: <Widget>[
                                          Expanded(
                                            child: RadioListTile<dynamic>(
                                              title: snapshot.data![i].espece as Widget,
                                              value: snapshot.data![i].espece,
                                              groupValue: selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                          );
                        }
                    ),
                ],
              ),

              ),
            ),
      );
    }),
              );

              },
          icon: Icon(Icons.toc)),
        ],
      ),
      body:  ListView(
        // controller: controller,
        children: <Widget>[
          Text("Trier par", style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RadioListTile<SingingCharacter>(
                title: const Text('Lafayette'),
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<SingingCharacter>(
                title: const Text('Thomas Jefferson'),
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
  Widget makeDismissible({required Widget child})=> GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap:()=>Navigator.of(context).pop(),
    child: GestureDetector(onTap: (){},child:child),
  );

  Widget BottomModal() {
    return makeDismissible(
      child: DraggableScrollableSheet(
        maxChildSize: 0.9,
        minChildSize: 0.3,
        initialChildSize: 0.7,
        builder: (_, controller) =>
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  )
              ),
              //   padding: EdgeInsets.all(16),
              child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder(
                          future: Lots.getLots("",""),
                          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        height: 170.0,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 8.0,
                                        ),
                                        child: new Stack(
                                          children: <Widget>[
                                            RadioListTile<SingingCharacter>(
                                              title: const Text('Lafayette'),
                                              value: SingingCharacter.lafayette,
                                              groupValue: _character,
                                              onChanged: (SingingCharacter? value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            );
                          }
                      ),
                    ],
                  ),
            ),
      ),
    );
  }
}
