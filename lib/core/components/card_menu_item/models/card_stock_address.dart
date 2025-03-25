import 'package:cpfcnpj/cpfcnpj.dart';

import '../../../helpers/extensions.dart';
import '../../../models/models.dart';
import '../../../values/values.dart';

class CardStockAddress {
  final String cpf;
  final String userName;
  final Address? address;

  CardStockAddress({
    required this.cpf,
    required this.userName,
    required this.address,
  });

  String get fullStreetName {
    return Strings.userNameAndAddressNumber(
      address?.street ?? '',
      address?.houseNumber ?? '',
    );
  }

  String get getCpfWithMaks {
    return '${Strings.cpfInputLabelText} ${CPF.format(cpf)}';
  }

  String get getZipCodeWithMaks {
    return '${Strings.zipCodeInputLabelText} ${address?.zipcode.formatterCep}';
  }

  String get getFullLocation {
    return '${address?.city}, ${address?.state}, ${address?.country}';
  }
}
