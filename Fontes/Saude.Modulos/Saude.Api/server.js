const moment = require('moment')
moment.locale('pt-br')
const srvController = require('./serverController')
var express = require('express')
var app = express()
var cors = require('cors');
var http = require('http');
var port = process.env.PORT || 3010
app.set('port', port);
app.listen(port);
app.use(cors());
app.use(express.json());


console.log('Prefeitura da Serra: Módulo Saude.Api  -Porta: ' + port)

function onListening() {
  debug('Listening on port ' + server.address().port);
}

app.post('/saude/getPaciente', function(req, res) {
  
  srvController.obterPaciente(req, res)  

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