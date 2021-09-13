# Desafio Cadastro de Livros

Lá no Discord da [Rafaella](https://github.com/rafaballerini) (que por sinal vale a pena dar uma olhada) rolou um desafio na semana do MySQL pra completar a seguinte tarefa:

### Desafio - Fácil  - Cadastro de Livros 

Deve ser montados queries SQL para a criação de uma tabela de livros na seguinte estrutura:

- id: inteiro auto-gerado (opcional utilizar uuid auto-gerado ou snowflake); 
- name: texto (50 caracteres); 
- description: texto (250 caracteres); 
- author: texto (50 caracteres); 

Depois as queries responsáveis por inserir um livro no banco, listar todos os livros, encontrar um livro, atualizar um livro e deletar um livro. 

### Desafio - Intermediário - Usuários

Deve ser montado queries SQL para a criação de uma tabela de usuários na seguinte estrutura: 

* id: inteiro auto-gerado (opcional utilizar uuid auto-gerado ou snowflake); 
* name: texto (50 caracteres); 
* age: inteiro; - book: referência para um livro da tabela de livros ou pode estar vazio; 

Além das queries para inserir, listar, encontrar, atualizar e deletar, deve haver uma query para definir um livro emprestado, atualizar o livro ou tirar o livro.



### As queries e exercícios

Criei as queries de forma a se assemelhar a uma API, usando exclusivamente Procedures pra facilitar o lado da aplicação que consome a API, além de evitar erros e padronizar a execução caso o DB seja atualizado

Basta importar o arquivo **prepare_database.sql** dentro do seu MySQL e está pronto para uso!

**PS: JAMAIS IMPORTE QUALQUER ARQUIVO SEM ANTES VERIFICAR O CONTEÚDO!!!**

### Como usar

Estarei assumindo que você esta no Database ```BalleriniMySQLCadastroLivros```

##### Cadastrar um novo livro:

`CALL CadastraLivro('nome do livro', 'descricao do livro', 'autor do livro');`

##### Atualizar um livro:

`CALL AtualizaLivro(id_do_livro, 'nome do livro', 'descricao do livro', 'autor do livro');`

Caso o id_do_livro não exista, será retornado um erro

##### Remover um livro:

`CALL RemoveLivro(id_do_livro);`

##### Procurar um livro:

`CALL ProcuraLivro(id_do_livro);`

`CALL ProcuraLivro(NULL);`

Caso o id_do_livro seja nulo será retornado toda a lista de livros cadastrados

##### Cadastrar um novo usuário:

`CALL CadastraUsuario('nome usuario', idade_do_usuario);`

##### Atualizar um usuário:

`CALL AtualizaUsuario(id_do_usuario, 'nome do usuario', idade_do_usuario);`

Caso o id_do_usuario não exista, será retornado um erro

##### Remover um usuário:

`CALL RemoveUsuario(id_do_usuario);`

##### Procurar um usuário:

`CALL ProcuraUsuario(id_do_usuario);`

`CALL ProcuraUsuario(NULL);`

Caso o id_do_usuario seja nulo será retornado toda a lista de usuários cadastrados

##### Emprestar um livro:

`CALL EmprestaLivro(id_do_usuario, id_do_livro);`

Caso não existir usuário com o id id_do_usuario, será retornado um erro

Caso não existir livro com o id id_do_livro, será retornado um erro

Caso o id_do_livro for nulo, o livro que está emprestado ao usuário será devolvido

Caso o usuário já possuir um livro emprestado, será retornado um erro. O usuário deve devolver o livro antes

Caso o livro já esteja emprestado, será retornado um erro informando que o livro já esta emprestado

##### Listar sumário da biblioteca:

`CALL SumarioBiblioteca(id_do_usuario);`

Retorna um resumo de todos os livros junto com quais usuários os possui emprestado, caso houver algum.

##### Verificar se um livro esta emprestado:

`CALL CheckLivroEmprestado(id_do_usuario);`

Caso esteja emprestado, um erro será retornado

##### Verificar se o livro existe:

`CALL CheckLivroExiste(id_do_usuario);`

Caso não exista, um erro será retornado

##### Verificar se o usuário já possui um livro emprestado:

`CALL CheckUsuarioEmprestimo(id_do_usuario);`

Caso o usuário já possua um livro emprestado, um erro será retornado

##### Verificar se usuário existe:

`CALL CheckUsuarioExiste(id_do_usuario);`

Caso não exista, um erro será retornado



