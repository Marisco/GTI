class modPaciente {

    constructor(Data) {
        this.numero = Data.numero ? Data.numero : "";
        this.nome = Data.nome ? Data.nome : "";
        this.cpf = Data.cpf ? Data.cpf : "";
        this.telefone = Data.telefone ? Data.telefone : "";
        this.celular = Data.celular ? Data.celular : "";
        this.cartaoSus = Data.cartao_sus ? Data.cartao_sus : "";
        this.dataNascimento = Data.data_nascimento ? Data.data_nascimento : "";
        this.dtOcorrencia = Data.dt_ocorrencia ? Data.dt_ocorrencia : "";
        this.sexo = Data.sexo ? Data.sexo : "";
        this.rg = Data.rg ? Data.rg : "";
        this.rg_uf = Data.rg_uf ? Data.uf : "";
        this.estadoCivil = Data.estado_civil ? Data.estado_civil : "";
        this.endereco = Data.endereco ? Data.endereco : "";
        this.observacao = Data.observacao ? Data.observacao : "";
        this.anonimo = Data.anonimo ? Data.anonimo : "";
    };
}

module.exports = {
    modPaciente
};