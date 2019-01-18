var express = require('express')
var app = express()
var cors = require('cors');
var port = process.env.PORT || 3010
app.listen(port);
app.use(cors());
app.use(express.json());
var router = express.Router();
const srvController = require('./serverController')
moment = require('moment')
moment.locale('pt-br')
console.log('Prefeitura da Serra: Módulo Saude.Api  -Porta: ' + port)

app.post('/saude/getPaciente', function(req, res) {
  
  srvController.obterPaciente(req, res)  

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