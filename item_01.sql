/*
* DDL - Use SQL DDL para criar um esquema de banco de 
* dados relacional baseado no modelo relacional da figura
*/

CREATE TABLE FUNCIONARIO
(
    primeiro_nome VARCHAR(15) NOT NULL,
    m_inicial CHAR,
    ultimo_nome VARCHAR(15) NOT NULL,
    cpf CHAR(11) NOT NULL,
    data_nasc DATE,
    endereco VARCHAR(50),
    sexo CHAR,
    salario DECIMAL(10, 2),
    cpf_supervisor CHAR(11),
    num_depto INT NOT NULL DEFAULT 1,
    CONSTRAINT PK_FUNCIONARIO PRIMARY KEY (Cpf),
    CONSTRAINT FK_FUNC_SUPERVISOR FOREIGN KEY(cpf_supervisor) 
    REFERENCES FUNCIONARIO(cpf) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_FUNC_DEPARTAMENTO FOREIGN KEY(num_depto) REFERENCES DEPARTAMENTO(num_depto) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE DEPARTAMENTO
(
    nome_depto VARCHAR(15) NOT NULL,
    num_depto INT NOT NULL,
    data_criacao DATE NOT NULL,
    cpf_gerente CHAR(11) NOT NULL DEFAULT '88866555576',
    data_inicio_gerente DATE,
    CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (num_depto),
    CONSTRAINT UK_DEPARTAMENTO UNIQUE (nome_depto),
    FOREIGN KEY (cpf_gerente) REFERENCES FUNCIONARIO(cpf)
    ON DELETE SET DEFAULT ON UPDATE CASCADE,
    CHECK (data_criacao <= Data_inicio_gerente)
);


CREATE TABLE LOCALIZACOES_DEPTO
(
    num_depto INT NOT NULL,
    data_criacao date NOT NULL,
    local VARCHAR(15) NOT NULL,
    PRIMARY KEY (num_depto, local),
    FOREIGN KEY (num_depto) REFERENCES DEPARTAMENTO(num_depto) 
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE PROJETO
(
    nome_projeto VARCHAR(15) NOT NULL,
    num_projeto INT NOT NULL,
    local_projeto VARCHAR(15),
    num_depto INT NOT NULL,
    PRIMARY KEY (num_projeto),
    UNIQUE (nome_projeto),
    FOREIGN KEY (num_depto) REFERENCES DEPARTAMENTO(num_depto)
);
CREATE TABLE TRABALHA_EM
(
    cpf_funcionario CHAR(11) NOT NULL,
    num_projeto INT NOT NULL,
    horas DECIMAL(3, 1) NOT NULL,
    PRIMARY KEY (cpf_funcionario, num_projeto),
    FOREIGN KEY (cpf_funcionario) REFERENCES FUNCIONARIO(cpf),
    FOREIGN KEY (num_projeto) REFERENCES PROJETO(num_projeto)
);
CREATE TABLE DEPENDENTE
(
    cpf_funcionario CHAR(11) NOT NULL,
    nome_dependente VARCHAR(15) NOT NULL,
    sexo CHAR,
    data_nasc DATE,
    parentesco VARCHAR(8),
    PRIMARY KEY (cpf_funcionario, nome_dependente),
    FOREIGN KEY (cpf_funcionario) REFERENCES FUNCIONARIO(cpf)
);