class modModulo {
    
    constructor(Data) {
        this.numero = Data.numero;
        this.nomeAplicativo = Data.nome_aplicativo
        this.nomeModulo = Data.nome_modulo;
        this.icone = Data.icone;
        this.dataInicio = Data.data_inicio;
        this.dataFim = Data.data_fim;        
    };      
}

module.exports ={
    modModulo: modModulo
    };