import '../../core.dart';

typedef ItemsList = List<String>;
typedef NewPackageList = List<NewPackage>;

class NewPackage {
  final String? receiverCpf;
  final String? receiverName;
  final Address address;
  final ItemsList items;
  final bool dropShipping;
  final DeclarationList declarations;

  const NewPackage({
    this.receiverCpf,
    this.receiverName,
    required this.address,
    required this.items,
    required this.dropShipping,
    required this.declarations,
  });

  Map toMap() {
    return {
      'items': items,
      'address': address.toMap(),
      'receiverCpf': receiverCpf,
      'receiverName': receiverName,
      'dropShipping': dropShipping,
      'declaration': declarations.map((it) => it.toMap()).toList(),
    };
  }

  Map toApi() {
    return {
      'items': items,
      ...address.toMap(),
      'receiverCpf': receiverCpf,
      'dropShipping': dropShipping,
      'receiverName': receiverName,
      'declaration': declarations.map((it) => it.toMap()).toList(),
    };
  }

  NewPackage copyWith({
    Address? address,
    ItemsList? items,
    bool? dropShipping,
    DeclarationList? declarations,
  }) {
    return NewPackage(
      address: address ?? this.address,
      items: items ?? this.items,
      dropShipping: dropShipping ?? this.dropShipping,
      declarations: declarations ?? this.declarations,
    );
  }

  @override
  String toString() {
    return 'NewPackage(address: $address, items: $items, dropShipping: $dropShipping, declarations: $declarations)';
  }
}
