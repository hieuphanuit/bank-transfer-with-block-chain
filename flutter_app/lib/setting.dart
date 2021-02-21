// const bool isProduction = bool.fromEnvironment('dart.vm.product');
const bool isProduction = false;

const testConfig = {
  'baseUrl': 'http://10.0.2.2:5010/api/',
  'blockchainNodeUrl': 'http://192.168.1.11:25100/'
};

const productionConfig = {
  'baseUrl': 'some-url.com',
  'blockchainNodeUrl': 'some-url.com',
};

final environment = isProduction ? productionConfig : testConfig;
