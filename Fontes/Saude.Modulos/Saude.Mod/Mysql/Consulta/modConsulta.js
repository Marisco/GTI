class modConsulta {

    constructor(Data) {
        this.numero = Data.numero
        this.unidade = Data.unidade_nome
        this.consultorio = Data.consultorio_nome
        this.especialidade = Data.especialidade_nome
        this.medico = Data.medico_nome
        this.dataInicio = Data.data_inicio
        this.dataFim = Data.data_fim
    };
};

module.exports = {
    modConsulta: modConsulta
};