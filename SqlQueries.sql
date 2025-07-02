/*
Questao 1
*/
SELECT 	
	turma.dia,
    turma.descricao,
    turma.horario,
    pessoa.cpf,
    pessoa.nome
FROM Turma
JOIN professor on professor.codpessoa = turma.codpessoa
JOIN pessoa on professor.codpessoa = pessoa.codpessoa;

SELECT * 
	
FROM aluno
;

/*
Questao 2
*/
SELECT 
	count(aluno.codpessoa) as qtedAlunos,
    pessoa.nome as nomeProf,
    pessoa.cpf,
    professor.datacontratacao
FROM professor
JOIN
	Aluno on aluno.codpessoaprofessor = professor.codpessoa
JOIN
	pessoa on professor.codpessoa = pessoa.codpessoa
group by professor.codpessoa
;

/*
Questao 3
*/
SELECT
	count(aluno.codPessoa) as qtdeMenVenc,
    aluno.codPessoa,
    aluno.datamatricula,
    pessoa.cpf,
    pessoa.nome
FROM
	aluno
JOIN 
	Mensalidade on Mensalidade.codpessoa = aluno.codpessoa
JOIN 
    pessoa on pessoa.codpessoa = aluno.codpessoa
WHERE
	mensalidade.dataPagamento is null AND
    mensalidade.dataVencimento < NOW()
group by aluno.codPessoa
having qtdeMenVenc > 1
;

/*
Questao 4
*/
SELECT
	month(mensalidade.datavencimento) as Mes,
    year(mensalidade.datavencimento) as Ano,
    count(mensalidade.codMensalidade) AS Quantidade,
    sum(valor) as total
FROM
	mensalidade
where
	mensalidade.datapagamento is not null
group by month(mensalidade.datavencimento), year(mensalidade.datavencimento)
;

/*
Questao 5
*/
ALTER table Avaliacao add column imc numeric(9,2);

Update 
	Avaliacao
	
SET
	imc = peso / (altura * altura);

/*Questao 6 */
SELECT 
	count(turmaaluno.codPessoa) as QtdeAlunos,
    turma.descricao,
    turma.dia,
    turma.horario,
    turma.vagas,
    modalidade.descricao

FROM
	turmaaluno
JOIN
	turma on turma.codTurma = turmaaluno.codTurma
JOIN
	modalidade on modalidade.codModalidade = turma.codModalidade
group by turmaaluno.codTurma
;

/*Questao 7 */
SELECT dataVencimento, dataPagamento, valor
FROM Mensalidade
WHERE
dataPagamento IS NOT NULL
AND dataPagamento > dataVencimento;

/*Questao 8 */
SELECT 
	MAX(avaliacao.dataAvaliacao),
    Avaliacao.peso,
    Avaliacao.altura,
    pessoa.nome,
    pessoa.cpf
FROM
	Avaliacao
JOIN
	Aluno on aluno.codPessoa = avaliacao.codPessoa
JOIN
	Pessoa on Pessoa.codPessoa = aluno.codPessoa
group by avaliacao.codPessoa
;

SELECT PES.CPF, PES.nome AS Aluno, MAX(AVA.dataAvaliacao) AS dataAvaliacao, AVA.peso, AVA.altura
FROM Avaliacao AS AVA
INNER JOIN Aluno AS ALU ON AVA.codPessoa = ALU.codPessoa
INNER JOIN Pessoa AS PES ON PES.codPessoa = ALU.codPessoa
GROUP BY AVA.codPessoa
ORDER BY PES.nome;

select
		p.cpf,
        p.nome as aluno,
        MAX(av.dataAvaliacao) as ultimaAV,
        av.peso,
        av.altura
        
        From Avaliacao av
        
        inner join Aluno a on av.codPessoa = a.codPessoa
        
        inner join Pessoa p on a.codPessoa = p.codPessoa
        
        group by av.codPessoa
        order by p.nome;






