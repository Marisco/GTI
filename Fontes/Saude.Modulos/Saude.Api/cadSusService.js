
const soap = require('soap');
const crypto = require('crypto');
const moment = require('moment');
require('ssl-root-cas/latest').inject();
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';
const url = 'https://servicos.saude.gov.br/cadsus/CadsusService/v5r0?wsdl';
//var url = 'http://16-253398-w10:8088/mockCadsusServiceSOAP11Binding?wsdl';

// ok 01 02
//var url = 'https://servicos.saude.gov.br/cadsus/PesquisaUsuarioSUSService/v5r0?wsdl'
// ok 03
const wsSecurity = new soap.WSSecurity("CADSUS.ESUSAB", "#ESUSAB!0091", {
    hasNonce: true,
    hasTokenCreated: true,
    passwordType: 'PasswordText',
    mustUnderstand: false
});

//ok 02
// var args = {
//     CNESUsuario:
//     {
//         CNES: "CADSUS",
//         Usuario: "ESUSAB",
//         Senha: "#ESUSAB!0091",
//     },
//     FiltroPesquisaSimilar: {
//         nomeCompleto: {
//             Nome: "CHRISTIANO SILVEIRA MARISCO"
//         },
//         Mae: {
//             Nome: ""
//         },
//         dataNascimento: '1977-11-04',
//         Sexo: {
//             codigoSexo: "",
//             descricaoSexo: ""
//         }
//     },
//     //higienizar: "0",
// }

// ok 03
// var args = {
//     CNESUsuario:
//     {
//         CNES: "CADSUS",
//         Usuario: "ESUSAB",
//         Senha: "#ESUSAB!0091",
//     },
//     CNS: { numeroCNS: 706802165108930 }
// }

//ok 01
// var args = {
//     CNESUsuario:
//     {
//         CNES: "CADSUS",
//         Usuario: "ESUSAB",
//         Senha: "#ESUSAB!0091",
//     },
//     CPF: { numeroCPF: "03618673604" }
// }

//

var pesquisar = {
    CNESUsuario:
    {
        CNES: "CADSUS",
        Usuario: "ESUSAB",
        Senha: "#ESUSAB!0091",
    },
    FiltroPesquisa: {
        nomeCompleto: {
            Nome: "CHRISTIANO SILVEIRA MARISCO"
        },   
        // nomeSocial: "",
        // nomeFamilia:{Nome:""},
        // dataNascimento: "",
        // Mae: {
        //     Nome: ""
        // },
        // Pai:{
        //     Nome:""
        // },
        //  CPF:{
        //      numeroCPF:"03618673604"

        //  },
        // MunicipioNascimento: {
        //     codigoMunicipio: "",
        //     nomeMunicipio: "",
        //     UF: {
        //         codigoUF: "",
        //         siglaUF: "",
        //         codigoRegiao: "",
        //         nomeUF: ""
        //     }
        // },
        // TipoDocumento:{
        //     tipoDocumento:""
        // },
        // numeroDocumento:"",
          tipoPesquisa: "IDENTICA",
        // situacao:""
         },
        higienizar: 0
    
}



var consultarCadSus = function (req, res) {
    soap.createClient(url, function (err, client) {
        client.setSecurity(new soap.BearerSecurity('UsernameToken-2'));
        client.setSecurity(wsSecurity)
        //ok 01
        // client.consultarUsuarioSUS(args, function (err, result, rawResponse, soapHeader, rawRequest) {
        //     console.log(rawResponse);
        //     console.log(rawRequest);
        // });
        //ok 02
        // client.consultarUsuarioSUSSimilar(args, function (err, result, rawResponse, soapHeader, rawRequest) {
        //     console.log(rawResponse);
        //     console.log(rawRequest);
        // });
        //ok 03
        // client.consultar(args, function (err, result, rawResponse, soapHeader, rawRequest) {
        //     console.log(rawResponse);
        //     console.log(rawRequest);
        // });
        //ok 04
        client.pesquisar(pesquisar, function (err, result, rawResponse, soapHeader, rawRequest) {
            console.log(rawResponse);
            console.log(rawRequest);
        });

    });
};

module.exports = { consultarCadSus: consultarCadSus };