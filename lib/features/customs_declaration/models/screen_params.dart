import '../../../core/models/models.dart';

class ScreenParams {
  final BoxList boxList;
  final Address address;
  final bool dropShipping;

  ScreenParams({
    required this.boxList,
    required this.address,
    required this.dropShipping,
  });

  @override
  String toString() =>
      'ScreenParams(boxList: $boxList, address: $address, dropShipping: $dropShipping)';
}
