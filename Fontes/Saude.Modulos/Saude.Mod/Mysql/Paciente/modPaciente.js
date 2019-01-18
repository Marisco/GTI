class modPaciente {
    
    constructor(Data) {
        this.numero = Data.numero;
        this.nome = Data.nome;
        this.cpf = Data.cpf;
        this.telefone = Data.telefone;
        this.celular = Data.celular;
        this.cartaoSus = Data.cartao_sus;
        this.dataNascimento = Data.data_nascimento;        
        this.dtOcorrencia = Data.DT_OCORRENCIA;        
        this.sexo = Data.sexo;
        this.rg = Data.rg;
        this.rg_uf = Data.rg_uf;
        this.estadoCivil = Data.estado_civil;
        this.endereco = Data.endereco;
        this.observacao = Data.observacao;
        this.anonimo = Data.anonimo;
    };      
}

module.exports ={
    modPaciente
    }