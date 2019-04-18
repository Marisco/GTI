class modFilavirtual {

    constructor(Data) {
        this.numero = Data.numero
        this.unidade = Data.unidade
        this.especialidade = Data.especialidade
        this.dataInicio = Data.data_inicio
        this.dataFim = Data.data_fim
    };
};

module.exports = {
    modFilavirtual: modFilavirtual
};