import 'Article.dart';

class OrderItem{
  String? espece;
  String? variete;
  int? nombreALivrer;

  OrderItem.vide();

  OrderItem(this.espece,this.variete, this.nombreALivrer);


  @override
  String toString() {
    return 'OrderItem{espece: $espece, variete: $variete, nombreALivrer: $nombreALivrer}';
  }

  Map<String, dynamic> toJson() {
    return {
      'espece': this.espece,
      'variete':this.variete,
      'nombreALivrer': this.nombreALivrer,
    };
  }

  factory OrderItem.fromJson(dynamic json) {
    OrderItem item = new OrderItem(
        json['espece'] as String,
        json['variete'] as String,
      json['nombreALivrer'] as int
   );
    return item;
  }
}