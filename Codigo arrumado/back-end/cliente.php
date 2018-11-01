<?php
    class Cliente {
        private $nome;
        private $cpf;
        private $email;
        private $codigo;

        public function Cliente($nome, $cpf, $email) {
            $this->nome = $nome;
            $this->cpf = $cpf;
            $this->email = $email;
        }

        public function ObterNome() { return $this->nome;}
        public function ObterCpf() { return $this->cpf;}
        public function ObterEmail() { return $this->email;}
        public function ObterCodigo() { return $this->codigo;}
        public function MudarNome($nome) { $this->nome = $nome;}
        public function MudarCpf($cpf) { $this->cpf = $cpf;}
        public function MudarEmail($email) { $this->email = $email;}
    }
?>