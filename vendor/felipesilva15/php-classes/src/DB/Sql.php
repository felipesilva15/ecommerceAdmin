<?php

namespace felipesilva15\DB;

class Sql extends \PDO{
    private $conn;

    // BD Senac
    private $server = "127.0.0.1:3306";
    private $user = "root";
    private $password = "root";
    private $db = "DB_ECOMMERCE";

    // Método construtor para criar atributo de conexão da classe
    public function __construct(){
        $this->conn = new \PDO ("mysql:dbname={$this->db};host={$this->server}r", $this->user, $this->password);
    }

    // Define um parâmetro da query com o bindValue
    public function setParameter($stmt, $key, $value){
        $stmt->bindParam($key, $value);
    }

    // Define todos os parâmetros da query com o bindValue em cada item do array de parâmetros da query
    public function setParameters($stmt, $parameters = []){
        foreach ($parameters as $key => $value) {
            $this->setParameter($stmt, $key, $value);
        }
    }

    // Prepara a query e a executa no BD
    // Utilize este método para comandos que NÃO retornam algo do BD
    public function executeQuery($query, $parameters = []){
        $stmt = $this->conn->prepare($query);

        $this->setParameters($stmt, $parameters);

        $stmt->execute();

        return($stmt);
    }

    // Realiza uma select no BD
    // Utilize este método para comandos que retornam algo do BD
    public function select($query, $parameters = []):array{
        $stmt = $this->executeQuery($query, $parameters);

        return ($stmt->fetchAll(\PDO::FETCH_ASSOC));
    }

    public function returnLastId(){
        return($this->conn->lastInsertId());
    }
}