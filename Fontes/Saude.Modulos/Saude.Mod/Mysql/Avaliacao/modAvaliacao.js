class modAvaliacao {
    
    constructor(Data) {
        this.numero = Data.numero;
        this.paciente = Data.paciente
        this.tipoAvaliacao = Data.tipo_avaliacao,
        this.dataAtendimento  =  Data.data_atendimento,
        this.nota = Data.nota;
        this.texto = Data.texto;
        this.dataAvaliacao = Data.data_avaliacao,
        this.celular = Data.celular,
        this.numeroAtendimento = Data.numero_atendimento
    };      
}

module.exports ={
    modAvaliacao
    }