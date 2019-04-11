const moment = require('moment')
moment.locale('pt-br')
const srvController = require('./serverController')
const cadSusService = require('./cadSusService')
const bnafarService = require('./bnafarService')
var express = require('express')
var app = express()
var cors = require('cors');
var http = require('http');
var port = process.env.PORT || 3010
app.set('port', port);
app.listen(port);
app.use(cors());
app.use(express.json());


console.log('Prefeitura da Serra: Módulo Saude.Api - Porta: ' + port )


app.post('/saude/getPaciente', function(req, res) {
  
  srvController.obterPaciente(req, res)  

})

app.post('/saude/getDadosPaciente', function(req, res) {
  
  srvController.obterDadosPaciente(req, res)  

})

 app.get('/saude/getPacienteCadSus', function(req, res) {
  
   cadSusService.consultarCadSus(req, res)  

 })

 app.get('/saude/getConsultaBnafar', function(req, res) {
  
  bnafarService.consultarBnafar(req, res)  

})

app.post('/saude/postPaciente', function(req, res) {
  
  srvController.inserirPaciente(req, res)  

})
app.get('/saude/getUnidades', function(req, res) {
  
  srvController.obterUnidades(req, res)  

})
app.post('/saude/getEspecialidades', function(req, res) {
  
  srvController.obterEspecialidades(req, res)  

})
app.post('/saude/getConsultas', function(req, res) {
  
  srvController.obterConsultas(req, res)  

})

app.post('/saude/postConsulta', function(req, res) {
  
  srvController.agendarConsulta(req, res)  

})

app.get('/saude/teste', function(req, res) {   
  moment().locale('pt-br')
  res.send('Prefeitura da Serra: Módulo Saude.Api  - Porta: ' + port + ' - ' + moment().format('LL'))
})

app.get('/saude/getBairros', function(req, res) {
  
  srvController.obterBairros(req, res)  

})

app.get('/saude/getModulos', function(req, res) {
  
  srvController.obterModulos(req, res)  

})

app.post('/saude/postFilaVirtual', function(req, res) {
  
  srvController.inserirFilaVirtual(req, res)  

})

app.get('/saude/getFilaVirtual', function(req, res) {
  
  srvController.obterModulos(req, res)    

})
app.post('/saude/getFilasVirtuais', function(req, res) {
  
  srvController.obterFilasVirtuais(req, res)

})
app.post('/saude/getAvaliacoes', function(req, res) {
  
  srvController.obterAvaliacoes(req, res)  

})

app.post('/saude/postAvaliacao', function(req, res) {
  
  srvController.inserirAvaliacao(req, res)  

})

