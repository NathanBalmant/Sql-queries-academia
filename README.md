
# 📘 Projeto: Consultas SQL em Academia de Ginástica

Este repositório contém uma série de consultas SQL realizadas sobre um modelo de banco de dados de uma academia de ginástica. As queries simulam cenários reais de relacionamento entre alunos, professores, turmas, pagamentos e avaliações físicas.

---

## 📌 Enunciados e Respostas

### 📄 Questão 1
**Enunciado:**  
Liste todas as turmas com seus respectivos dias, horários e descrição, junto com o nome e CPF do professor responsável.

**Resposta:**
```sql
SELECT 	
    turma.dia,
    turma.descricao,
    turma.horario,
    pessoa.cpf,
    pessoa.nome
FROM Turma
JOIN professor ON professor.codpessoa = turma.codpessoa
JOIN pessoa ON professor.codpessoa = pessoa.codpessoa;
```

---

### 📄 Questão 2
**Enunciado:**  
Liste a quantidade de alunos por professor, junto com o nome, CPF e data de contratação do professor.

**Resposta:**
```sql
SELECT 
    count(aluno.codpessoa) as qtedAlunos,
    pessoa.nome as nomeProf,
    pessoa.cpf,
    professor.datacontratacao
FROM professor
JOIN Aluno ON aluno.codpessoaprofessor = professor.codpessoa
JOIN pessoa ON professor.codpessoa = pessoa.codpessoa
GROUP BY professor.codpessoa;
```

---

### 📄 Questão 3
**Enunciado:**  
Liste os alunos que possuem mais de uma mensalidade vencida e ainda não paga. Mostre nome, CPF, data de matrícula e quantidade de mensalidades em atraso.

**Resposta:**
```sql
SELECT
    count(aluno.codPessoa) as qtdeMenVenc,
    aluno.codPessoa,
    aluno.datamatricula,
    pessoa.cpf,
    pessoa.nome
FROM aluno
JOIN Mensalidade ON Mensalidade.codpessoa = aluno.codpessoa
JOIN pessoa ON pessoa.codpessoa = aluno.codpessoa
WHERE mensalidade.dataPagamento IS NULL
  AND mensalidade.dataVencimento < NOW()
GROUP BY aluno.codPessoa
HAVING qtdeMenVenc > 1;
```

---

### 📄 Questão 4
**Enunciado:**  
Apresente a quantidade de mensalidades pagas por mês e ano, junto com o valor total recebido.

**Resposta:**
```sql
SELECT
    month(mensalidade.datavencimento) as Mes,
    year(mensalidade.datavencimento) as Ano,
    count(mensalidade.codMensalidade) AS Quantidade,
    sum(valor) as total
FROM mensalidade
WHERE mensalidade.datapagamento IS NOT NULL
GROUP BY month(mensalidade.datavencimento), year(mensalidade.datavencimento);
```

---

### 📄 Questão 5
**Enunciado:**  
Adicione uma coluna chamada `imc` na tabela `Avaliacao` e atualize com o valor calculado pelo peso dividido pela altura ao quadrado.

**Resposta:**
```sql
ALTER TABLE Avaliacao ADD COLUMN imc NUMERIC(9,2);

UPDATE Avaliacao
SET imc = peso / (altura * altura);
```

---

### 📄 Questão 6
**Enunciado:**  
Liste a quantidade de alunos por turma, com a descrição, dia, horário, número de vagas e descrição da modalidade da turma.

**Resposta:**
```sql
SELECT 
    count(turmaaluno.codPessoa) as QtdeAlunos,
    turma.descricao,
    turma.dia,
    turma.horario,
    turma.vagas,
    modalidade.descricao
FROM turmaaluno
JOIN turma ON turma.codTurma = turmaaluno.codTurma
JOIN modalidade ON modalidade.codModalidade = turma.codModalidade
GROUP BY turmaaluno.codTurma;
```

---

### 📄 Questão 7
**Enunciado:**  
Liste as mensalidades que foram pagas com atraso. Mostre data de vencimento, data de pagamento e valor.

**Resposta:**
```sql
SELECT dataVencimento, dataPagamento, valor
FROM Mensalidade
WHERE dataPagamento IS NOT NULL
  AND dataPagamento > dataVencimento;
```

---

### 📄 Questão 8
**Enunciado:**  
Liste a última avaliação física de cada aluno, mostrando nome, CPF, data da avaliação, peso e altura.

**Resposta:**
```sql
SELECT 
    p.cpf,
    p.nome AS aluno,
    MAX(av.dataAvaliacao) AS ultimaAV,
    av.peso,
    av.altura
FROM Avaliacao av
INNER JOIN Aluno a ON av.codPessoa = a.codPessoa
INNER JOIN Pessoa p ON a.codPessoa = p.codPessoa
GROUP BY av.codPessoa
ORDER BY p.nome;
```
