class modAvaliacao {
    
    constructor(Data) {
        this.numero = Data.numero;
        this.nomeAplicativo = Data.nome_aplicativo
        this.nomeAvaliacao = Data.nome_avaliacao;
        this.icone = Data.icone;
        this.dataInicio = Data.data_inicio;
        this.dataFim = Data.data_fim;        
    };      
}

module.exports ={
    modAvaliacao
    }