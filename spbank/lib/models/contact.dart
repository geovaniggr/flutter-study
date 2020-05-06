class Contact {
  final int id;
  final int accountNumber;
  final String name;

  Contact(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contact { name: $name, accountNumber $accountNumber }';
  }

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'id': id, 'accountNumber': accountNumber};
}
