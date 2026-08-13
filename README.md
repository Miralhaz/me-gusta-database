# Me Gusta Database

Repositório responsável pelo versionamento dos arquivos de banco de dados do **Me Gusta**.

Este documento define as regras para organização, versionamento, nomenclatura e padronização dos arquivos SQL e DER do projeto.

---

## 📁 Estrutura de pastas

Os arquivos devem ser mantidos nas pastas correspondentes ao seu tipo.

```text
📦 database
 ├── 📂 SQL
 │    ├── megustaV01.sql
 │    ├── megustaV02.sql
 │    └── megustaV03.sql
 │
 └── 📂 DER
      ├── der-megustaV01.mwb
      ├── der-megustaV02.mwb
      └── der-megustaV03.mwb
```

### SQL

A pasta `SQL` deve conter **exclusivamente os arquivos `.sql`** referentes às versões do banco.

```text
SQL/
├── megustaV01.sql
├── megustaV02.sql
└── megustaV03.sql
```

### DER

A pasta `DER` deve conter **exclusivamente os arquivos `.mwb`** referentes às versões do banco.

```text
DER/
├── der-megustaV01.mwb
├── der-megustaV02.mwb
└── der-megustaV03.mwb
```

---

# 🔢 Versionamento

O versionamento do banco deve ser **incremental e permanente**.

> ⚠️ **Arquivos de versões anteriores nunca devem ser apagados ou sobrescritos.**

Sempre que uma alteração for realizada no banco, deve ser criada uma **nova versão**, utilizando o número da versão atual + `1`.

### Exemplo

Se a versão atual for:

```text
V03
```

uma nova alteração deverá gerar:

```text
V04
```

Mantendo todas as versões anteriores:

```text
SQL/
├── megustaV01.sql
├── megustaV02.sql
├── megustaV03.sql
└── megustaV04.sql
```

O mesmo princípio deve ser aplicado aos arquivos DER:

```text
DER/
├── der-megustaV01.mwb
├── der-megustaV02.mwb
├── der-megustaV03.mwb
└── der-megustaV04.mwb
```

### ❌ Não fazer

```text
❌ Apagar megustaV03.sql
❌ Sobrescrever megustaV03.sql
❌ Renomear uma versão existente
```

### ✅ Fazer

```text
V03 → V04
```

Criando um novo arquivo e mantendo o histórico completo.

---

# 🏷️ Nomenclatura

Os arquivos devem seguir obrigatoriamente os padrões abaixo.

## SQL

```text
megustaVxx.sql
```

Onde:

* `megusta` → nome do projeto
* `V` → identificador da versão
* `xx` → número da versão
* `.sql` → extensão do arquivo SQL

### Exemplos

```text
megustaV01.sql
megustaV02.sql
megustaV03.sql
megustaV04.sql
```

---

## DER

```text
der-megustaVxx.mwb
```

Onde:

* `der` → identificação do Diagrama Entidade-Relacionamento
* `megusta` → nome do projeto
* `V` → identificador da versão
* `xx` → número da versão
* `.mwb` → arquivo do MySQL Workbench

### Exemplos

```text
der-megustaV01.mwb
der-megustaV02.mwb
der-megustaV03.mwb
der-megustaV04.mwb
```

---

# 🗄️ Padrões de tabelas

As tabelas devem utilizar **snake_case** para sua nomenclatura.

### ✅ Correto

```text
usuario
pedido
item_pedido
forma_pagamento
endereco_usuario
```

### ❌ Incorreto

```text
Usuario
ItemPedido
itemPedido
FORMA_PAGAMENTO
```

---

# 🔑 Chaves primárias

## Tabelas comuns

A chave primária de uma tabela comum deve ser denominada:

```text
id
```

### Exemplo

```sql
CREATE TABLE usuario (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);
```

---

## Tabelas associativas

Em tabelas associativas, a chave primária composta deve utilizar as chaves estrangeiras das tabelas relacionadas.

O padrão é:

```text
fk_tabela1
fk_tabela2
```

### Exemplo

Considerando uma relação entre `usuario` e `pedido`:

```sql
CREATE TABLE usuario_pedido (
    fk_usuario INT,
    fk_pedido INT,
    PRIMARY KEY (fk_usuario, fk_pedido)
);
```

O nome das colunas deve seguir o padrão:

```text
fk_<tabela>
```

---

# 💰 Valores monetários

Colunas destinadas ao armazenamento de valores monetários devem utilizar:

```sql
DECIMAL(19,4)
```

### Exemplo

```sql
preco DECIMAL(19,4)
```

```sql
valor_total DECIMAL(19,4)
```

```sql
desconto DECIMAL(19,4)
```

Não utilizar tipos como:

```text
FLOAT
DOUBLE
```

para armazenamento de valores monetários.

---

# ⌨️ Comandos SQL

Os comandos SQL devem ser escritos em **CAPS LOCK**.

### ✅ Correto

```sql
CREATE TABLE usuario (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);

INSERT INTO usuario (id, nome)
VALUES (1, 'João');

SELECT *
FROM usuario;
```

### ❌ Incorreto

```sql
create table usuario (
    id int primary key
);
```

```sql
select *
from usuario;
```

Os comandos e palavras-chave SQL devem permanecer em letras maiúsculas para manter a padronização dos arquivos.

---

# 📋 Checklist

Antes de adicionar uma nova versão, confirme:

### 📁 Arquivos

* [ ] O arquivo `.sql` está dentro da pasta `SQL`.
* [ ] O arquivo `.mwb` está dentro da pasta `DER`.
* [ ] Os arquivos anteriores foram mantidos.

### 🔢 Versionamento

* [ ] A nova versão é a versão atual + `1`.
* [ ] Nenhuma versão anterior foi apagada.
* [ ] Nenhuma versão anterior foi sobrescrita.

### 🏷️ Nomenclatura

* [ ] O SQL segue `megustaVxx.sql`.
* [ ] O DER segue `der-megustaVxx.mwb`.

### 🗄️ Banco de dados

* [ ] Tabelas utilizam `snake_case`.
* [ ] PK de tabelas comuns utiliza `id`.
* [ ] PK de tabelas associativas utiliza `fk_tabela1, fk_tabela2`.
* [ ] Valores monetários utilizam `DECIMAL(19,4)`.
* [ ] Comandos SQL estão em CAPS LOCK.

---

# 📌 Resumo das regras

| Categoria         | Regra                                                 |
| ----------------- | ----------------------------------------------------- |
| 📁 SQL            | Arquivos `.sql` na pasta `SQL`                        |
| 📁 DER            | Arquivos `.mwb` na pasta `DER`                        |
| 🔢 Versionamento  | Versão atual + `1`                                    |
| 🗑️ Exclusão      | Arquivos de versões anteriores não devem ser apagados |
| 🏷️ SQL           | `megustaVxx.sql`                                      |
| 🏷️ DER           | `der-megustaVxx.mwb`                                  |
| 🗄️ Tabelas       | `snake_case`                                          |
| 🔑 PK comum       | `id`                                                  |
| 🔗 PK associativa | `fk_tabela1, fk_tabela2`                              |
| 💰 Dinheiro       | `DECIMAL(19,4)`                                       |
| ⌨️ SQL            | CAPS LOCK                                             |

---

> **Me Gusta Database**
>
> Manter o histórico.
> Manter o padrão.
> Manter a consistência.
