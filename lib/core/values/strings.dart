// Defines all strings from the project
abstract class Strings {
  static const appName = 'Maria Me envia';
  static String copiedCode(String value) => '$value copiado';

  // Validators errors
  static const errorEmailInvalid = 'E-mail inválido';
  static const errorEmailEmpty = 'Insira seu e-mail';
  static const errorPasswordEmpty = 'Insira sua senha';
  static const errorPasswordTooShort = 'Senha muito curta';
  static const errorConfirmPassword = 'As senhas não podem ser diferentes';
  static const errorWrongPassword = 'Senha incorreta.';
  static const errorEmptyField = 'Campo obrigatório';
  static const errorCpfInvalid = 'CPF inválido';
  static const errorPhoneInvalid = 'Telefone inválido';
  static const errorDDDInvalid = 'DDD inválido';
  static const errorCepInvalid = 'CEP inválido';
  static const errorMoneyInvalid = 'Insira um valor maior que zero';
  static const addMoreOneFile = 'Selecione pelos menos um arquivo';
  static const errorFileMaxSize = 'Selecione um arquivo menor que 10MB';

  // Auth Errors
  static const errorUserCreationFailed = 'Email ou senha inválidas';
  static const errorUserNotFound = 'Usuário não encontrado';
  static const errorEmailNotVerified =
      'A confirmação de e-mail está pendente. Verifique na sua caixa de entrada ou spam.';
  static const errorAlreadyRegisteredUser =
      'Já existe um usuário cadastrado com essas credenciais';
  static const errorEmailNotExists =
      'Não existe usuário cadastrado com esse email';
  static const errorUnknownInApi =
      'Ocorreu um erro inesperado, por favor tente novamente';

  // No Connection
  static const toUpdate = 'Atualizar';
  static const closeToApp = 'Sair do Aplicativo';
  static const errorConnectionTitle = 'Ocorreu um erro';
  static const errorConnectionSubtitle =
      'Não foi possível carregar as informações.\nVerifique sua conexão e tente novamente';

  // Onboardings
  static const titleFirstStep = 'Faça suas compras';
  static const titleSecondStep = 'Monte sua caixa';
  static const titleThirdStep = 'Acompanhe todo processo';
  static const subtitleFirstStep =
      'Compre produtos nos EUA, na sua loja de preferência, e envie para o nosso endereço';
  static const subtitleSecondStep =
      'Organize tudo que você quer enviar para o Brasil e nos solicite o envio';
  static const subtitleThirdStep =
      'Fique por dentro de todas as movimentações dos seus objetos até chegarem na sua casa!';
  static const stringLastStep = 'Vamos as compras?';

  // Mantras
  static const randomMantrasMessage = 'Maria Me Envia só trás alegria';
  static const mantraOfMaria = 'Mantra da Maria';

  // ForgotPassword
  static const retrieveYourPasswordText = 'Recupere sua senha';
  static const retrieveYourPasswordEmailTitleText = 'E-mail enviado!';
  static const retrieveYourPasswordContentText =
      'Confira seu e-mail para acessar o link de recuperação de senha';

  // Buttons
  static const loadingButtonText = 'Carregando...';
  static const loginButtonTitle = 'Login';
  static const registerButtonTitle = 'Cadastre-se';
  static const forgotPasswordButtonTitle = 'Esqueci minha senha';
  static const forgotPasswordButtonTitleSend = 'Enviar';
  static const forgotPasswordButtonTitleConfirm = 'Confirmar';
  static const onboardingSkipButtonText = 'Pular';
  static const onboardigLastButtonText = 'Maria Me Envia';
  static const registrationNextButtonText = 'Próximo';
  static const registrationFinishButtonText = 'Concluir';
  static const seeAllButtonText = 'Ver todas';

  // Inputs Label Text
  static const nameInputLabelText = 'Nome Completo';
  static const cpfInputLabelText = 'CPF';
  static const phoneInputLabelText = 'Telefone';
  static const emailInputLabelText = 'E-mail';
  static const passwordInputLabelText = 'Senha';
  static const newPasswordInputLabelText = 'Nova senha';
  static const passwordConfirmationInputLabelText = 'Confirmar senha';
  static const newPasswordConfirmationInputLabelText = 'Confirmar nova senha';
  static const forgotPasswordInputHelperText = 'Insira seu e-mail de Cadastro';
  static const countryInputLabelText = 'País';
  static const zipCodeInputLabelText = 'CEP';
  static const streetInputLabelText = 'Endereço';
  static const numberInputLabelText = 'Número';
  static const cityInputLabelText = 'Cidade';
  static const districtInputLabelText = 'Bairro';
  static const complementInputLabelText = 'Complemento';

  // Settigns
  static const cardEditProfileTitle = 'Informações pessoais';
  static const cardEditAddressTitle = 'Endereço';
  static const editProfileTitle = 'Editar perfil';
  static const sectionProfileFirstText = 'Editado com sucesso!';
  static const sectionProfileSecondText = 'Informações pessoais editadas!';
  static const logout = 'Sair';
  static const noUserInformationToUptade = 'Edite pelos menos um campo';
  static const editAdress = 'Editar endereço';
  static const yes = 'Sim';
  static const no = 'Não';
  static const deleteAccount = 'Exluir conta';
  static const deleteAccountConfirmation =
      'Tem certeza que deseja excluir sua conta? Essa ação não poderá ser desfeita!';

  static const accountDeletedTitle = 'Conta Excluída!';
  static const accountDeletedMessage =
      'Sua conta não existe mais no app Maria Me Envia';

  // learn More Cards
  static const learnMore = 'Saiba Mais';
  static const whoIsMaria = 'Quem é Maria?';
  static const shippingCost = 'Valor do Frete';
  static const serviceTaxes = 'Taxas de Serviço';
  static const faq = 'FAQ';
  static const seeTutorialAgain = 'Reveja nosso tutorial';

  // RequestedBox
  static const pay = 'Pagar';
  static const awaitPaymentConfirmation = 'Comprovante em aprovação';
  static const paymentRefused =
      'Infelizmente seu comprovante de pagamento foi recusado, por favor envie um comprovante válido';
  static boxWithId(String id) => 'Caixa #$id';
  static lenghtBoxItems(int length) =>
      length >= 2 ? '$length Itens na caixa' : '$length Item na caixa';
  static boxDeclarationValue(String value, {bool isAmountoPay = false}) =>
      isAmountoPay ? 'Total à pagar: $value' : 'Total declarado: $value';

  // Pending Payment
  static const pendingPayment = 'Pagamento pendente';
  static const lastSend = 'Últimos envios';
  static const whoIsMariaSubtitle = 'Fundadora do Maria Me Envia';

  // Faq
  static const faqSubtitle =
      'Encontre aqui a resposta para pergunta frequentes que recebemos no Maria Me Envia';

// our service
  static const welcomeToMariaMeEnvia = 'Bem vindos ao Maria Me Envia!';

// service taxes
  static const serviceTaxesSubtitle = 'Como funcionam nossas taxas';
  static const serviceTaxesCardTitle = 'Taxas';
  static const maxVolumeAllowedCardTitle = 'Volume máximo permitido';

//forbidden itens
  static const forbiddenItensBackgroundImage =
      'https://images.unsplash.com/photo-1619659085787-9e779b420b84?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80';
  static const forbiddenItensTitle = 'Itens proibidos';
  static const forbiddenItensSubtitle =
      'Quais os itens que não podem ser enviados?';
  static const forbiddenItemCardDrugsTitle = 'Drogas e Entorpecentes';
  static const forbiddenItemCardDrugsContent =
      'Cocaína, ópio, morfina, demais estupefacientes e outras substâncias de uso proibido;\nCigarros, derivados do tabaco e produtos similares;\nEntorpecentes e substâncias psicotrópicas (que provocam alucinações e delírio).';
  static const forbiddenItemCardWeaponTitle = 'Armas e objetos perigosos';
  static const forbiddenItemCardWeaponContent =
      'Armas ou munição;\nSubstância explosiva, radioativa, deteriorável, fétida, nauseante, corrosiva nociva ou facilmente inflamável, cujo transporte constitua perigo ou possa danificar outro objeto;\nSubstâncias que, ao serem manuseadas ou transportadas, constituam perigo ou possam causar danos;\nObjetos que atentem contra a segurança nacional;Conteúdo classificado como perigoso conforme especificados em normas nacionais para transporte aéreo ou terrestre.';
  static const forbiddenItemCardBiohazardTitle = 'Biológicos e outros';
  static const forbiddenItemCardBiohazardContent =
      'Animais vivos;\nPlantas vivas;\nAnimais mortos, ossos ou cinzas;\nMaterial Biológico, entre outros;\nMoeda de valor corrente;\nQuaisquer outros bens ou produtos proibidos pela lei brasileira ou protegidos pela legislação ambiental.';

  //Maria Tips
  static const mariaTipsTitle = 'Dicas da Maria';
  static const checkpromotions = 'Confira já as promoções';
  static const returnButtonText = 'Voltar para inicio';

  // Registration
  static const registrationCompleted = 'Quase lá!';
  static const registrationCompletedMessage =
      'Por favor, verifique a sua caixa de entrada e confirme o seu e-mail. Ah, não esquece de conferir no spam!';

  static const resgitrationHeaderTitle = 'Cadastro';
  static const nextProgress = 'Próximo';
  static const finishRegistration = 'Concluir';
  static const changeData = 'Alterar dados';
  static const country = 'Páis';
  static const zipcode = 'CEP';

  static const street = 'Endereço';
  static const number = 'Número';
  static const city = 'Cidade';
  static const state = 'Estado';
  static const district = 'Bairro';
  static const complement = 'Complemento';
  static const errorRegistrationFailure =
      'Por favor, altere os dados e tente novamente.';

  static const termOfUseTitle =
      'Confira aqui os Termos de Uso e Política de Privacidade do Maria Me Envia';
  static const acceptTermOfUse =
      'Aceitar Termos de Uso e Política de Privacidade';
  static const termOfUseFilePath = 'assets/files/privacy_policy.txt';

  //TabBar
  static const feedbackButtonBoxListEmpty =
      'Acompanhe aqui os itens selecionados';
  static const feedbackButtonCreatePackage =
      'Clique aqui para concluir a criação da caixa';
  static const tabBarTexts = [
    'Home',
    'Pedidos',
    'Saiba Mais',
  ];

  //Tutorial
  static const tutorialStart = 'Iniciar';
  static const skipTutorial = 'Pular Tutorial';
  static const tutorialTitleFirstText = 'Tutorial Maria Me Envia';
  static const tutorialTitleFirstStepText = 'Faça suas compras';
  static const tutorialTitleSecondtepText = 'Acompanhe seu estoque';
  static const tutorialTitleThirdStepText = 'Crie suas caixas';
  static const tutorialTitleFourthStepText = 'Maria Me Envia';
  static const tutorialTitleFifthStepText = 'Declare seus objetos';
  static const tutorialTitleSixthStepText = 'Realize o pagamento';
  static const tutorialTitleSeventhStepText = 'Acompanhe todo processo';
  static const tutorialSubtitleFirstStepText =
      'Faça suas compras em suas lojas de preferência de qualquer lugar do mundo e envie para o nosso endereço';
  static const tutorialSubtitleSecondStepText =
      'Iremos disponibilizar fotos das suas compras à medida que elas forem chegando no nosso estoque';
  static const tutorialSubtitleThirdStepText =
      'Selecione quais itens você deseja colocar em uma caixa. Você poderá selecionar todos os itens no nosso estoque de uma vez ou organizá-los em caixas diferentes';

  static const tutorialSubtitleFourthStepText = [
    'Caixa pronta, basta clicar no botão ',
    'Maria Me Envia ',
    'e nos informar o endereço de destino que desejar',
  ];
  static const tutorialSubtitleFifthStepText = [
    'Preencha sua declaração da ',
    'Receita Federal. ',
    ' Qualquer dúvida, entrar em contato com a nossa equipe através do botão do WhatsApp',
  ];
  static const tutorialSubtitleSixthStepText = [
    'Iremos disponibilizar o valor total referente a taxa de serviço e frete da caixa a ser enviada \n\n Faça o pagamento, anexe o comprovante e a sua caixa sairá no próximo voo disponível!',
  ];
  static const tutorialSubtitleSeventhStepText = [
    'Fique por dentro de cada movimentação da sua caixa. E quando você receber a sua encomenda lembre-se:\n\n',
    'Maria Me Envia só trás alegria!',
  ];

  // Tutorial modal string
  static const tutorialModalServiceFeesBtn = 'Estou ciente';
  static const modalServiceFeesTexts = {
    0: 'Taxas de Serviço',
    1: 'O valor cobrado para o envio de caixas corresponde a taxa do nosso serviço Maria Me Envia mais o valor do frete (calculado por peso)',
    2: 'Confira as taxas de serviço abaixo:',
    3: '*Consulte o valor do frete no nosso FAQ',
  };
  static const modalRateAndDescriptionTitle = [
    'Taxa',
    'Descrição',
  ];
  static const modalRateSubtitleTexts = [
    {
      'money': '\$40.00',
      'message': 'Valor fixo por caixa enviada',
    },
    {
      'money': '\$50.00',
      'message':
          'Valor fixo por caixa enviada com produtos Apple com preço até U\$500.00',
    },
    {
      'money': '\$100.00',
      'message':
          'Valor fixo por caixa enviada com produtos Apple com preço a partir de U\$501.00',
    },
  ];
  static const modalTaxationWarningTitleText = [
    'Tributação',
    'Caixa tributada',
    'Liberação da caixa',
  ];
  static const modalTaxationWarningSubtitleText = [
    'Ah! Última informação importante:\n\nFique atento às atualizações de rastreio da sua caixa para caso ela seja tributada',
    'Se sua caixa for tributada na Receita Federal, você deverá pagar o valor do imposto devido diretamente no site dos Correios do Brasil.',
    'Assim que você efetuar o pagamento do imposto devido, sua caixa será liberada e entregue no endereço que você nos solicitou.',
  ];

  static const noOrderItemButtonTextStock = 'Ver Endereço de Envio';
  static const noOrderItemButtonText = [
    'Ver endereço',
    'Rever tutorial',
  ];

  // Address of our stock
  static const stockAddressBtnText = 'Concluir';
  static const stockAddressTitle = 'Endereço do nosso estoque';
  static const cardStockCopyAddress = 'Copiar endereço';
  static const recipientInformationText = 'Informações do destinatário';
  static String userNameAndAddressNumber(String name, String number) =>
      '$name, nº $number';
  static const cardStockAddress = {
    0: '1628 Elizabeths Walk',
    1: 'Winter Park, Florida',
    2: '32789',
  };

  static const recipientAddressBtn = [
    'Confirmar destinatário',
    'Escolher outro',
  ];

  // New Recipient
  static const newRecipientTitle = 'Novo destinatário';
  static const recipientCreated = 'Destinatário cadastrado!';
  static const dropShipping = 'Drop Shipping';
  static const enterInContact = 'Entre em contato conosco no WhatsApp';
  static const enterInContactTitleButton = 'Entrar em contato';
  static const enterInContactMessage =
      'Essa modalidade requer um contato direto com a nossa equipe';
  static const dropShippingMessage =
      'Seu pedido atual se destina a prática de Drop Shippping?';
  static const dropShippingButtons = ['Não', 'Sim'];

  // Home Header
  static const createBox = 'Criar caixa';
  static const headerMoreTipsText = 'Mais dicas';
  static const headerSeeAllButtonText = 'Ver todas';
  static const headerTipsOfMariaText = 'Dicas da Maria';
  static const headerSeeAllText = 'Acompanhe suas caixas';
  static dollarQuotationText(String money) => 'Dólar - $money';
  static const headerNoTipsTitleText = 'Em breve\ndicas para suas compras!';

  // Order Screen
  static const onePhotoAttached = '1 foto anexada';
  static const cancelCreateBoxButtonText = 'cancelar';
  static const orderScreenTitle = 'Seus itens no nosso estoque';
  static const orderScreenSubtitle = 'Selecione o que deseja enviar';
  static String boxItemName(int index) => 'Item #${index.toString()}';
  static const orderHeaderTabs = [
    'Itens recebidos',
    'Caixas solicitadas',
    'Pagamento pendente',
    'Caixas enviadas',
  ];

  // Requested boxes
  static const trackYourBox = 'Acompanhe suas caixas';
  static const avaliableItemText =
      'Monte sua caixa com os itens disponíveis abaixo';
  static const selectAllItem = 'Sel. Todos';
  static const noStockItem = 'Nenhuma caixa criada';
  static const noStockItemHome = 'Nenhum item no nosso estoque';
  static const noRequestBox = 'Nenhuma caixa foi solicitada';
  static const noPaymentPedengBox = 'Não há pagamentos pendentes';
  static const noSendBox = 'Nenhuma caixa foi enviada';
  static const letStart = 'Vamos começar?';
  static const noStockItems = 'Não há itens no seu estoque';
  static const awaitPackageLastLocation = 'Aguardando localização';
  static const noOrderItemText =
      'Faça suas compras em suas lojas de preferência de qualquer lugar do mundo e envie para o nosso endereço';
  static String selectedAllItems(int count) => count == 0
      ? 'Nada selecionado'
      : '$count ${count > 1 ? 'itens' : 'item'}  na caixa';

  // Checkout Payment
  static const paymentTitle = 'Pagamento';
  static const paymentFileUploadTitle =
      'Insira aqui o seu comprovante de pagamento';
  static const paymentCreated = 'Pagamento registrado!';
  static const paymentCreatedMessage =
      'Aguarde a aprovação da nossa equipe e o código de rastreio da sua caixa';
  static const paymentInfoMessage = 'Dados bancários';
  static const copyPaymentInfo = 'Copiar dados bancários';
  static const mariaphoneNumber = '+18325918581';
  static const whatsAppLinkInAndroid =
      'whatsapp://send?phone=$mariaphoneNumber';
  static const whatsAppLinkInIOS = 'https://wa.me/$mariaphoneNumber';
  static const informationOfPayment = [
    'Maria Helena Maroun',
    'Cpf 118.199.997-93',
    'Bradesco',
    'Ag 2650',
    'Conta 2146-6',
    'Pix mhmaroun@gmail.com',
  ];
  static const paymentFileUploadName = 'Comprovante';
  static const paymentFileUploadError = 'Formato inválido';
  static const photoFileUploadName = 'Comprovante';
  static const photoFileOpenError = 'Formato inválido';
  static const photoFileUploadTitle = 'Inserir fotos';
  static const sendProofOfPayment = 'Enviar';

  // Box modal limit and confirm order
  static const boxModalLimitTitle = 'Limites das caixas';
  static const boxModalLimitNotificationBtn = tutorialModalServiceFeesBtn;
  static const boxModalLimitNotificationTitle = maxVolumeAllowedCardTitle;
  static const boxModalLimitNotificationSubtitle = [
    'Inferior a 79” = (197cm)',
    'Calculando da seguinte forma:',
    '(1 x o lado maior)',
    '(2 x lado menor 1)',
    '(2 x lado menor 2)',
    'Sendo que o lado maior não pode ultrapassar a medida de 41” (104 cm)',
  ];
  static const modalConfirmOrderBoxTitle = 'Confirmar pedido?';
  static const modalConfirmOrderBoxSubtitle =
      'Após a confirmação você não poderá editar ou cancelar o pedido da sua caixa';
  static const modalConfirmOrderBoxErro =
      'Por favor, selecione pelos um iten para prosseguir com criação da caixa';
  static const ok = 'ok';
  static const modalConfirmOrderBtn = forgotPasswordButtonTitleConfirm;
  static const modalEditBoxBtn = 'Editar caixa';

  // Date format
  static const currentCountry = 'Brasil';
  static const brazilianMonthAbreviation = {
    DateTime.january: 'jan',
    DateTime.february: 'fev',
    DateTime.april: 'abr',
    DateTime.may: 'mai',
    DateTime.june: 'jun',
    DateTime.july: 'jul',
    DateTime.august: 'ago',
    DateTime.september: 'set',
    DateTime.october: 'out',
    DateTime.november: 'nov',
    DateTime.december: 'dez',
  };

  // Customs Declaration
  static const customsDeclarationText = [
    'Declaração da Aduaneira',
    'Sua declaração pode ter até 5 linhas',
  ];
  static const customsDeclarationInputs = [
    'Categoria',
    'Descrição do produto',
    'Quantidade',
    'Valor unitário',
    'Valor total',
  ];
  static const customsDeclarationBtn = [
    'Adicionar item',
    'Editar item',
    'Finalizar',
  ];
  static const categoryLabelText = 'Categoria';
  static const categoryList = [
    'Automobile utensils parts',
    'Books – album',
    'Chandeliers – light fixture',
    'Christmas decoration',
    'Cooking utensils',
    'Earbuds',
    'Fishing products',
    'Camping products',
    'Games',
    'Garden utensils',
    'Hair dryer – straightener',
    'Machine photography',
    'Mobile device accessories',
    'Musical instruments',
    'Laptop',
    'Pack hair products',
    'Pack adult clothes',
    'Pack children clothes',
    'Pack bijouxs – accessories',
    'Pack candy',
    'Pack female-male underwear',
    'Printer – scanner',
    'Products for pets',
    'School products',
    'Sculpture',
    'Set bag – wallet – backpack',
    'Set home decoration',
    'Set kitchen utensils',
    'Set makeup',
    'Set ointments',
    'Set body splash',
    'Set skincare',
    'Shoes',
    'Souvenirs',
    'Stroller – car seat',
    'Toys',
    'Home utensils',
    'Baby utensils – accessories',
    'Vaccum cleaner',
    'Video game',
    'Vitamin',
    'Watch',
    'Speakers',
  ];
  static const errorDeclarationsListEmpty =
      'Informe pelo menos uma declaração aduaneira';
  static String customsDeclarationItemTitle(String id, String unity) =>
      'Item #$id - $unity Unidades';
  static String customsDeclarationItemValue(String value, bool isTotalValue) =>
      isTotalValue ? 'Valor total: $value' : 'Valor unitário: $value';
  static String totalValueDeclared(String value) => 'Total declarado: $value';
  static const tryAgain = 'Tentar novamente';
  static const createdBox = 'Caixa criada!';
  static const createdBoxMessage =
      'Aguarde a taxa do serviço e frete para realizar o seu pagamento';

  // Home Screen
  static String homeHeaderUserName(String name) => 'Olá $name,';
}
