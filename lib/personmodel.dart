class Person {
  int? id;
  String? name;
  String? amount;
  String? buyPrice;
  Person(this.id, this.name, this.amount, this.buyPrice);
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["amount"] = amount;
    map["buyPrice"] = buyPrice;
    return map;
  }

  Person.fromMap(Map map) {
    this.id = map["id"];
    this.name = map["name"];
    this.amount = map["amount"];
    this.buyPrice = map["buyPrice"];
  }
}
