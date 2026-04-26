# Compilador Racket (Scanner + Parser)

Projeto acadêmico contendo:

* **Gerador de Scanner**
* **Analisador Léxico**
* **Parser Preditivo LL(1)**
* **Geração de Parse Tree**

---

# Como executar

## Opção 1 — Execução local

Se você já possui:

* `g++`
* `make`
* `python3`

basta rodar:

```bash
make
```

---

## Opção 2 — Execução com Docker 🐳

### 1. Construir a imagem

```bash
docker build -t comp-e1 .
```

### 2. Iniciar o container

```bash
docker run -it comp-e1
```

### 3. Executar o projeto

Dentro do container:

```bash
make
```

---

# Saídas geradas

Após a execução, serão criadas as pastas:

* `token_lists/` → tokens gerados pelo scanner
* `trees/` → árvores sintáticas em `.txt` e `.json`

---

# Estrutura do projeto

```text
scanner_generator/   -> gerador de scanner + scanner em C++
parser/              -> parser LL(1) em Python
examples/            -> exemplos em Racket
token_lists/         -> saída léxica
trees/               -> parse trees
```

---

# Observação

Caso utilize Docker, todo o ambiente já virá configurado com:

* GCC / G++
* Make
* Python 3

Sem necessidade de instalar dependências manualmente 😄
