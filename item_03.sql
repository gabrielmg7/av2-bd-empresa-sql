
/*
* DML - Crie as consultas SQL a seguir:
*
* 1) Recupere a data de nascimento e o endereço dos funcionários cujo nome seja ‘João B. Silva’.
*/
SELECT data_nasc, endereco
FROM FUNCIONARIO
WHERE primeiro_nome = 'João'
    AND m_inicial = 'B'
    AND ultimo_nome = 'Silva';
/*    
 * 2) Recupere o nome e endereço de todos os funcionários que trabalham 
 * para o departamento ‘Pesquisa’.
 */
SELECT primeiro_nome, m_inicial, ultimo_nome, endereco
FROM FUNCIONARIO, DEPARTAMENTO
WHERE Nome_depto ='Pesquisa'
    AND DEPARTAMENTO.num_depto = FUNCIONARIO.num_depto;
/* 
 * 3) Para cada projeto localizado em ‘Mauá’, liste o número do projeto, 
 * o número do departamento que o controla e o sobrenome, endereço e data 
 * de nascimento do gerente do departamento.
 */
SELECT num_projeto, DEPARTAMENTO.num_depto, ultimo_nome, endereco, data_nasc
FROM PROJETO, DEPARTAMENTO, FUNCIONARIO
WHERE PROJETO.num_depto = DEPARTAMENTO.num_depto
    AND cpf_gerente = cpf
    AND local.PROJETO = 'Mauá';
/*
 * 4) Para cada funcionário, recupere o primeiro e o último nome do 
 * funcionário e o primeiro e o último nome de seu supervisor imediato.
 */
SELECT F.primeiro_nome, F.ultimo_nome, S.primeiro_nome, S.ultimo_nome
FROM FUNCIONARIO AS F, FUNCIONARIO AS S
WHERE F.cpf_supervisor = S.cpf;
/*
 * 5) Consulte todos os Cpfs de FUNCIONARIO.
 */
SELECT cpf
FROM FUNCIONARIO;
/* 
 *6) Consulte Cpf e Dnome (nome de departamento) de cada funcionário.
 */
SELECT cpf, nome_depto
FROM FUNCIONARIO, DEPARTAMENTO;
/*
 * 7) Recupere todos os valores de salário distintos de funcionários.
 */
SELECT DISTINCT salario
FROM FUNCIONARIO;
/*
 * 8) Exiba os números dos projetos que possuem funcionário ou gerente com o último nome ‘Silva’
 */
    (
    SELECT DISTINCT num_projeto
    FROM PROJETO, DEPARTAMENTO, FUNCIONARIO
    WHERE PROJETO.num_depto = DEPARTAMENTO.num_depto
        AND cpf_gerente = cpf
        AND ultimo_nome = 'Silva'
)
UNION
    (
    SELECT DISTINCT PROJETO.num_projeto
    FROM PROJETO, TRABALHA_EM, FUNCIONARIO
    WHERE PROJETO.num_projeto = TRABALHA_EM.num_projeto
        AND cpf.FUNCIONARIO = cpf
        AND ultimo_nome = 'Silva'
);
/*
 * 9) Recuperar todos os funcionários cujo endereço esteja em ‘São Paulo, SP’
 */
SELECT primeiro_nome, m_inicial, ultimo_nome, cpf, data_nasc
FROM FUNCIONARIO
WHERE endereco LIKE '%São Paulo, SP%';
/* 
 * 10) Encontrar todos os funcionários que nasceram durante a década de 1950.
 */
SELECT primeiro_nome, m_inicial, ultimo_nome, cpf, data_nasc
FROM FUNCIONARIO
WHERE data_nasc LIKE '________5_';

/*
 * 11) Mostrar nome completo do funcionário e salário acrescido de 10% 
 * dos funcionários que trabalham no projeto ‘ProdutoX’.
 */
SELECT F.primeiro_nome, F.m_inicial, F.ultimo_nome, 1.1 * F.salario AS aumento_salario
FROM FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P
WHERE F.cpf = T.cpf_funcionario
    AND T.num_projeto = P.num_projeto
    AND P.nome_projeto = 'ProdutoX';
/*
 * 12) Recuperar nome completo de todos os funcionários no departamento
 * 5, cujo salário esteja entre R$ 30.000,00 e R$ 40.000,00.
 */
SELECT primeiro_nome, m_inicial, ultimo_nome
FROM FUNCIONARIO
WHERE (
        Salario BETWEEN 30000 AND 40000
    )
    AND num_depto = 5;
/*
 * 13) Recuperar nome do departamento, nome completo do funcionário e nome 
 * do projeto onde ele trabalha, ordenado por departamento, e, dentro de cada 
 * departamento, ordenado alfabeticamente pelo sobrenome, depois pelo nome.
 */
SELECT D.nome_depto, F.primeiro_nome, F.m_inicial, F.ultimo_nome, P.nome_projeto
FROM DEPARTAMENTO AS D, FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P
WHERE D.num_depto = F.num_depto
    AND F.cpf = F.cpf_funcionario
    AND T.num_projeto = P.num_projeto
ORDER BY D.nome_depto, F.ultimo_nome, F.primeiro_nome;
/*
 * 14) Recupere os nomes de todos os funcionários no departamento 5 que 
 * trabalham mais de 10 horas por semana no projeto ‘ProdutoX’.
 */
SELECT F.primeiro_nome, F.m_inicial, F.ultimo_nome
FROM FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P, DEPARTAMENTO AS D
WHERE T.num_depto = 5
    AND P.horas >= 10
    AND P.projeto ='ProjetoX'

/*
 * 15) Liste os nomes de todos os funcionários que possuem um dependente 
 * com o mesmo primeiro nome que seu próprio.
 */
SELECT F.primeiro_nome, F.m_inicial, F.ultimo_nome
FROM FUNCIONARIO AS F, DEPENDENTE AS D
WHERE F.primeiro_nome = D.nome_dependente;
/*
 * 16) Ache os nomes de todos os funcionários que são supervisionados 
 * diretamente por ‘Fernando Wong’
 */

/*
 * 17) Recuperar os nomes de todos os funcionários que não possuem 
 * supervisores.
 */
SELECT primeiro_nome,
    ultimo_nome
FROM FUNCIONARIO
WHERE cpf_supervisor IS NULL;
/*
 * 18) Selecionar CPFs de todos os funcionários que trabalham na mesma 
 * combinação de projeto e horas que o funcionário de CPF 12345678966 trabalha.
 */
SELECT DISTINCT cpf_funcionario
FROM TRABALHA_EM
WHERE (num_projeto, horas) IN 
( 
SELECT num_projeto, horas
FROM TRABALHA_EM
WHERE cpf_funcionario = '12345678966' 
);


/*
 * 19) Exibir os nomes dos funcionários cujo salário é maior do que o salário 
 *de todos os funcionários do departamento de número 5.
 */
SELECT primeiro_nome, m_inicial, ultimo_nome
FROM FUNCIONARIO
WHERE salario > ALL 
(
SELECT salario
FROM FUNCIONARIO
WHERE num_depto = 5
);

/*
 * 20) Obter o nome de cada funcionário que tem um dependente com o 
 * mesmo sexo do funcionário.
 */
SELECT F.primeiro_nome, F.m_inicial, F.ultimo_nome
FROM FUNCIONARIO AS F, DEPENDENTE AS D
WHERE F.sexo = D.sexo;

/*
 * 21) Listar os nomes dos gerentes que possuem pelo menos um dependente.
 */

SELECT primeiro_nome, m_inicial, ultimo_nome
FROM FUNCIONARIO AS F
WHERE(F.cpf = DEPARTAMENTO.cpf_gerente)
(SELECT cpf_gerente
FROM DEPARTAMENTO
WHERE (DEPENDENTE.cpf_funcionario = DEPARTAMENTO.cpf_gerente));

/*
 * 22) Listar os CPFs de todos os funcionários que trabalham nos projetos 
 * de números 1, 2 ou 3.
 */
SELECT DISTINCT cpf_funcionario
FROM TRABALHA_EM
WHERE num_projeto IN (1, 2, 3);

/*
 * 23) Exibir a soma dos salários de todos os funcionários, o salário máximo, 
 * o salário mínimo e a média dos salários.
 */
SELECT SUM(salario), MAX(salario), MIN(salario), AVG(salario)
FROM FUNCIONARIO;

/*
 * 24) Exibir a soma dos salários de todos os funcionários de cada 
 * departamento, bem como o salário máximo, o salário mínimo e a 
 * média dos salários de cada um desses departamentos.
 */
SELECT SUM(salario), MAX(salario), MIN(salario), AVG(salario)
FROM (FUNCIONARIO JOIN DEPARTAMENTO ON FUNCIONARIO.num_depto = DEPARTAMENTO.num_depto)

/*
 * 25) Recuperar o número total de funcionários da empresa.
 */
SELECT COUNT (*)
FROM FUNCIONARIO;
/*
 *26) Recuperar o número de funcionários de cada departamento.
 */
SELECT COUNT (*)
FROM FUNCIONARIOS
WHERE num_depto IN (1, 4, 5);

/*
 * 27) Obter o número de valores distintos de salário.
 */
SELECT DISTINCT COUNT (*) salario
FROM FUNCIONARIO;

/*
 * 28) Exibir os nomes de todos os funcionários que possuem dois ou mais dependentes.
 */
SELECT primeiro_nome, m_inicial, ultimo_nome
FROM FUNCIONARIO
WHERE (
     SELECT COUNT (*)
FROM DEPENDENTE
WHERE cpf=cpf_funcionario)>=2;

/*
 * 29) Exibir o número do departamento, o número de funcionários no 
 * departamento e o salário médio do departamento, para cada departamento da empresa.
 */
SELECT num_depto, COUNT (*), AVG(salario)
FROM FUNCIONARIO
GROUP BY num_depto;

/*
 * 30) Listar o número do projeto, o nome do projeto e o número de 
 * funcionários que trabalham nesse projeto, para cada projeto.
 */
SELECT PROJETO.num_projeto, nome_projeto, COUNT(*)
FROM PROJETO, TRABALHA_EM
WHERE PROJETO.num_projeto = TRABALHA_EM.num_projeto 
GROUP BY PROJETO.num_projeto, nome_projeto;