class Config {
  int httpSendTimeout = 10;
  int httpConnectTimeout = 10;
  int httpReceiveTimeout = 10;
  

  String uatBaseUrl = 'https://happy-gatewayapi.azurewebsites.net/api/';



  String? _customerToken;
  String? _engineerToken;

  void setCustomerToken(List<String> list){
    if(list.isEmpty) return;
    _customerToken = list.join(';');
  }

  String get getCustomerToken => _customerToken ?? '';

  void setEngineerToken(List<String> list){
    if(list.isEmpty) return;
    _engineerToken = list[1] + list[2];
  }

  String get getEngineerToken => _engineerToken ?? '';

  void clearCustomerToken() => _customerToken = '';

  void clearEngineerToken() => _engineerToken = '';

}


enum Flavor{
  uat,
  prod
}