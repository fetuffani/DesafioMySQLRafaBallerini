CREATE DATABASE BalleriniMySQLCadastroLivros;

USE BalleriniMySQLCadastroLivros;

CREATE TABLE livros (
  id int NOT NULL AUTO_INCREMENT,
  name char(50) DEFAULT NULL,
  description char(250) DEFAULT NULL,
  author char(50) DEFAULT NULL,
  PRIMARY KEY (id)
);



insert  into livros(id,name,description,author) values 
(1,'MySQL do inicio ao fim','O melhor livro pra aprender MySQL','Fulaninho'),
(2,'programacao em c#','melhor linguagem de longe!','Mariazinha'),
(3,'Como treinar seu cachorro','seu cachorro é raivoso? aqui esta a solucao','Joaozinho'),
(4,'cozinhando otimos brigadeiros de festa','os melhores brigadeiros que voce vai fazer na sua vida','Klebinho'),
(5,'meu livro','minha desc','meu autor');



CREATE TABLE usuarios (
  id int NOT NULL AUTO_INCREMENT,
  name char(50) DEFAULT NULL,
  age int DEFAULT NULL,
  book int DEFAULT NULL,
  PRIMARY KEY (id)
);



insert  into usuarios(id,name,age,book) values 
(1,'fetuffani',29,NULL),
(2,'outrousuario',25,2);



DELIMITER $$

CREATE  PROCEDURE AtualizaLivro(id INT, NAME CHAR(50), description CHAR(250), author CHAR(50))
BEGIN		
		CALL BalleriniMySQLCadastroLivros.CheckLivroExiste(id);

		update BalleriniMySQLCadastroLivros.livros a
		set a.NAME = NAME,
		a.description = description,
		a.author = author
		WHERE a.id = id;
	END $$
DELIMITER ;


DELIMITER $$

CREATE  PROCEDURE AtualizaUsuario(id INT, NAME CHAR(50), age int)
BEGIN
		CALL BalleriniMySQLCadastroLivros.CheckUsuarioExiste(id);
		
		
		UPDATE BalleriniMySQLCadastroLivros.usuarios a
		SET a.NAME = NAME,
		a.age = age
		WHERE a.id = id;
	END $$
DELIMITER ;


DELIMITER $$

CREATE  PROCEDURE CadastraLivro(name CHAR(50), description char(250), author char(50))
BEGIN
		insert into livros (name,description,author) values (name, description, author);
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE CadastraUsuario(NAME CHAR(50), age int)
BEGIN
		INSERT INTO usuarios (NAME,age) VALUES (NAME, age);
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE CheckLivroEmprestado(id_livro INT)
BEGIN
		DECLARE cnt INT DEFAULT NULL;
		
		SELECT COUNT(*) AS cnt
		INTO cnt
		FROM BalleriniMySQLCadastroLivros.usuarios a
		WHERE a.book = id_livro;
		
		IF (cnt > 0) THEN
		BEGIN
			SIGNAL SQLSTATE '42000' SET 
			MYSQL_ERRNO = 42000,
			MESSAGE_TEXT = 'O livro ja esta emprestado!!!';
		END;
		END IF;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE CheckLivroExiste(id INT)
BEGIN
		DECLARE cnt INT DEFAULT NULL;
		
		SELECT COUNT(*) AS cnt INTO cnt
		FROM BalleriniMySQLCadastroLivros.livros a
		WHERE a.id = id;
		
		IF (cnt <= 0 and id is not null) THEN
		BEGIN
			SIGNAL SQLSTATE '42000' SET 
			MYSQL_ERRNO = 42000,
			MESSAGE_TEXT = 'O id de livro nao existe!!!';
		END;
		END IF;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE CheckUsuarioEmprestimo(id_usuario INT)
BEGIN
		DECLARE book INT DEFAULT null;
		
		SELECT usuarios.book
		INTO book
		FROM BalleriniMySQLCadastroLivros.usuarios usuarios
		WHERE usuarios.id = id_usuario;
		
		IF (book is not null) THEN
		BEGIN
			SIGNAL SQLSTATE '42000' SET 
			MYSQL_ERRNO = 42000,
			MESSAGE_TEXT = 'O usuario ja tem um livro emprestado!!!';
		END;
		END IF;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE CheckUsuarioExiste(id INT)
BEGIN
		DECLARE cnt INT DEFAULT NULL;
		
		SELECT count(*) as cnt
		INTO cnt
		FROM BalleriniMySQLCadastroLivros.usuarios a
		WHERE a.id = id;
		
		IF (cnt <= 0) THEN
		BEGIN
			SIGNAL SQLSTATE '42000' SET 
			MYSQL_ERRNO = 42000,
			MESSAGE_TEXT = 'O id de usuario nao existe!!!';
		END;
		END IF;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE EmprestaLivro(id_usuario int, id_livro INT)
EmprestaLivro:
	BEGIN
	
		CALL BalleriniMySQLCadastroLivros.CheckUsuarioExiste(id_usuario);
		CALL BalleriniMySQLCadastroLivros.CheckLivroExiste(id_livro);
		CALL BalleriniMySQLCadastroLivros.CheckLivroEmprestado(id_livro);
		IF (id_livro IS NOT NULL) THEN
			CALL BalleriniMySQLCadastroLivros.CheckUsuarioEmprestimo(id_usuario);
		END IF;
	
		UPDATE BalleriniMySQLCadastroLivros.usuarios a
		SET a.book = id_livro
		WHERE a.id = id_usuario;
		
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE ProcuraLivro(id int)
BEGIN
		if (id is not null) then
		BEGIN
			select * 
			from BalleriniMySQLCadastroLivros.livros a
			where a.id = id;
		END;
		else
		BEGIN
			SELECT * 
			FROM BalleriniMySQLCadastroLivros.livros a;
		END;
		END IF;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE ProcuraUsuario(id INT)
BEGIN
		IF (id IS NOT NULL) THEN
		BEGIN
			SELECT * 
			FROM BalleriniMySQLCadastroLivros.usuarios a
			WHERE a.id = id;
		END;
		ELSE
		BEGIN
			SELECT * 
			FROM BalleriniMySQLCadastroLivros.usuarios a;
		END;
		END IF;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE RemoveLivro(id int)
BEGIN
		delete from BalleriniMySQLCadastroLivros.livros a
		WHERE a.id = id;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE RemoveUsuario(id INT)
BEGIN
		DELETE FROM BalleriniMySQLCadastroLivros.usuarios a
		WHERE a.id = id;
	END $$
DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE SumarioBiblioteca()
BEGIN		
		select
			a.*,
			b.id as id_usuario,
			b.name,
			b.age
		from BalleriniMySQLCadastroLivros.livros a
		left join BalleriniMySQLCadastroLivros.usuarios b
			on a.id = b.book;
	END $$
DELIMITER ;

