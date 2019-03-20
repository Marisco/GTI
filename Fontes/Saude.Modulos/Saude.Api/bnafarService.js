var soap = require('soap');
var crypto = require('crypto');
var moment = require('moment')
require('ssl-root-cas/latest').inject();
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';
var url = 'http://horusws.saude.gov.br/horus-ws-service/HorusWSService/HorusWS?wsdl';

//var url = 'http://horusws.treinamento.saude.gov.br/horus-ws-service/HorusWSService/HorusWS?wsdl';

var pesquisar = {
    
        nuProtocoloEntrada: "17100000023000003132",
        dtRecebimento: "31-10-2017 15:34:12"     
    
}

var consultarBnafar = function (req, res) {    
    soap.createClient(url, function (err, client) {
        //var auth = "Basic " + new Buffer("christiano.marisco@serra.es.gov.br" + ":" + "gti@S3s4!").toString("base64");
        //var auth = "Basic " + new Buffer("aluisio.souza@serra.es.gov.br" + ":" + "gti@S3s4!").toString("base64");
        //client.addHttpHeader('Authorization',auth);        
        //client.setSecurity(new soap.BasicAuthSecurity('aluisio.souza@serra.es.gov.br','gti@S3s4!'));        
        client.setSecurity(new soap.BasicAuthSecurity('christiano.marisco@serra.es.gov.br','gti@S3s4!'));        
        client.consultarInconsistencias(pesquisar, function (err, result, rawResponse, soapHeader, rawRequest) {
            console.log(rawResponse);
            console.log(rawRequest);
            //console.log(soapHeader);
        });
    });
}

module.exports = { consultarBnafar }