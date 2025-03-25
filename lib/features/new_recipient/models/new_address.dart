import '../../../core/core.dart';
import '../../features.dart';

class NewAddress {
  final String cpf;
  final String name;
  final Address address;

  const NewAddress({
    required this.cpf,
    required this.name,
    required this.address,
  });

  factory NewAddress.information(
    String cpf,
    String name,
    AddressInformation info,
  ) {
    return NewAddress(
      cpf: cpf,
      name: name,
      address: info.toAddress(),
    );
  }
}
