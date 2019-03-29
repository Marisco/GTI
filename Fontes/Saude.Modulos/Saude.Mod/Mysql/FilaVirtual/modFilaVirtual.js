class modFilavirtual {
    
    constructor(Data) {
        this.numero = Data.numero;
        this.nomeAplicativo = Data.nome_aplicativo
        this.nomeFilavirtual = Data.nome_filavirtual;
        this.icone = Data.icone;
        this.dataInicio = Data.data_inicio;
        this.dataFim = Data.data_fim;        
    };      
}

module.exports ={
    modFilavirtual
    }