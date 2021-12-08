import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:suiviventes/Models/data.dart';

class AddClients extends StatefulWidget {
  @override
  _AddClientsState createState() => _AddClientsState();
}

class _AddClientsState extends State<AddClients> {
  final formKey = GlobalKey<FormState>();
  final controllerCity = TextEditingController();
  final controllerFood = TextEditingController();

  String? selectedCity;
  String? selectedFood;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildCity(),
                  SizedBox(height: 16),
                  buildFood(),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCity() => TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
      controller: controllerCity,
      decoration: InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(),
      ),
    ),
    suggestionsCallback: CityData.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
      title: Text(suggestion!),
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerCity.text = suggestion!,
    validator: (value) =>
    value != null && value.isEmpty ? 'Please select a city' : null,
    onSaved: (value) => selectedCity = value,
  );

  Widget buildFood() => TypeAheadFormField<String?>(
    textFieldConfiguration: TextFieldConfiguration(
      controller: controllerFood,
      decoration: InputDecoration(
        labelText: 'Food',
        border: OutlineInputBorder(),
      ),
    ),
    suggestionsCallback: FoodData.getSuggestions,
    itemBuilder: (context, String? suggestion) => ListTile(
      title: Text(suggestion!),
    ),
    onSuggestionSelected: (String? suggestion) =>
    controllerFood.text = suggestion!,
    validator: (value) =>
    value != null && value.isEmpty ? 'Please select a food' : null,
    onSaved: (value) => selectedFood = value,
  );

}
class CityData {
  static final faker = Faker();

  static final List<String> cities =
  List.generate(20, (index) => faker.address.city());

  static List<String> getSuggestions(String query) =>
      List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}

class FoodData {
  static final faker = Faker();

  static final List<String> foods =
  List.generate(20, (index) => faker.food.dish());

  static List<String> getSuggestions(String query) =>
      List.of(foods).where((food) {
        final foodLower = food.toLowerCase();
        final queryLower = query.toLowerCase();

        return foodLower.contains(queryLower);
      }).toList();
}