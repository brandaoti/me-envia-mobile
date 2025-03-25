typedef QueryParamsMap = Map<String, String>;

enum MariaInformationParams {
  faq,
  whoIsMaria,
  ourService,
  serviceFees,
  prohibitedItems,
}

final _mappinQueryParams = {
  MariaInformationParams.faq: 'faq',
  MariaInformationParams.whoIsMaria: 'quem+é+maria?',
  MariaInformationParams.ourService: 'nosso+serviço',
  MariaInformationParams.prohibitedItems: 'itens+proibidos',
  MariaInformationParams.serviceFees: 'taxas+do+serviço',
};

extension JsonMariaInformationParams on MariaInformationParams {
  QueryParamsMap get toQueryParams {
    final String queryString = _mappinQueryParams[this] ?? '';
    return QueryParamsMap.from({'option': queryString});
  }
}
