import '../types/types.dart';
import '../models/models.dart';
import '../values/values.dart';

abstract class Mocks {
  static User user = User(
    address: address,
    cpf: '79892059042',
    id: '8177a9d4-e0b5',
    type: UserType.user,
    phoneNumber: '79892059042',
    name: 'Residencia de Software',
    email: 'cubosacademy@residencia.dev',
  );

  static MariaInformation mariaInformation = MariaInformation.fromJson({
    'id': '8177a9d4-e0b5-4d87-a81b-32778108f962',
    'title': 'Quem é Maria?',
    'subtitle': 'Fundadora do Maria Me Envia',
    'text':
        'Seu principal objetivo é que você fique feliz e satisfeito com o serviço. Queremos que todos os clientes se sintam seguros com esse método de envio e que sempre possam se comunicar conosco em caso de dúvidas ou se precisarem de auxilio em qualquer etapa do processo.\nComo sempre falamos, para nós é um prazer e uma honra ter vocês como clientes e estamos em sintonia com as necessidades de todos vocês para fazer desse processo o mais simples, rápido e eficiente possível.',
    'picture':
        'dev-static-mariameenvia.cubos.dev/4b28753b-4e11-4f6c-8371-648876367825.png'
  });

  static MariaTips mariaTips = MariaTips(
    id: '1b738329-737d-4737-8882-61c43d5ad826',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    media: Strings.forbiddenItensBackgroundImage,
    title: 'Roupas em Conta',
    link: 'http://google.com/',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Egestas vitae ornare id turpis at.',
  );

  static MariaTipsList mariaTipsList = [
    mariaTips,
    mariaTips,
    mariaTips,
    mariaTips,
    mariaTips,
  ];

  static Box box = Box(
    id: '22',
    name: 'Iphone 11',
    media: 'https://source.unsplash.com/random',
    userId: '01',
    description: 'Iphone 11 Pro',
    createdAt: DateTime.now(),
  );

  static Address address = const Address(
    city: 'Salvador',
    houseNumber: '290',
    complement: 'Piatã - Em frente ao SENAI',
    country: 'Brasil',
    district: '',
    state: 'Bahia',
    street: 'Rua da Gratidão',
    zipcode: '41650195',
  );

  static Package package = Package(
    id: '239be6b3',
    totalItems: '15',
    declaredTotal: 0,
    shippingFee: 5000,
    updateAt: DateTime.now(),
    createdAt: DateTime.now(),
    trackingCode: 'LB299323591HK',
    lastPackageUpdateLocation: 'Salvador/BH',
    status: 'Objeto entregue ao destinatário',
    type: PackageType.warning,
    step: PackageStep.notSend,
    packageStatus: PackageStatus.paymentAccept,
    paymentVoucher:
        'http://dev-static-mariameenvia.cubos.dev/83f95e9c-5bc7-4c00-819b-2ad605009484.jpeg',
  );

  static DeclarationList declarations = [
    Declaration.fromJson({
      'name': 'Item #1',
      'category': 'Games',
      'description': 'God of war 1, 2 e 3',
      'quantity': 3,
      'unitaryValue': 10.0,
      'totalValue': 30.0
    }),
    Declaration.fromJson({
      'name': 'Item #1',
      'category': 'Games',
      'description': 'God of war 1, 2 e 3',
      'quantity': 2,
      'unitaryValue': 5.0,
      'totalValue': 10.0
    }),
    Declaration.fromJson({
      'name': 'Item #1',
      'category': 'Games',
      'description': 'God of war 1, 2 e 3',
      'quantity': 3,
      'unitaryValue': 60.0,
      'totalValue': 180.0
    }),
  ];
}
