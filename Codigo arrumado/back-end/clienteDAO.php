<?php
    class ClienteDAO {
        private function ConectarAoBanco(){
            $BD = 'port=5432 dbname=Teste user=postgres password=1234';
            return pg_connect($BD);
        }
        public function ObterClientes() {
            $MeuBD = $this->ConectarAoBanco();
            $res = pg_query($MeuBD, 'select * from cliente');
            while($cliente = pg_fetch_assoc($res)) {
                // print_r($cliente);
                // echo $cliente['nome'];
                echo 
                '<tr>
                <td class="td">'.$cliente["codcliente"].'</td>
                <td class="td">'.$cliente["nome"].'</td>
                <td class="td">'.$cliente["cpf"].'</td>
                <td class="td">'.$cliente["email"].'</td>
                <td class="td">
                <a href="atualiza.php?codcliente='.$cliente["codcliente"].'"><input name"editar" class="btn btn-outline-info" type="submit" value="Editar"></a>
                <a href="deleta.php?codcliente='.$cliente["codcliente"].'"><input name="excluir" class="btn btn-outline-info" type="submit" value="Excluir"></a>
                </td>

                </tr>';
            }
            pg_close($MeuBD);
        }
        public function ObterCliente($codigo) {
            $MeuBD = $this->ConectarAoBanco();
            $res = pg_query($MeuBD, 'select * from cliente');
            $cli = array();
            while($cliente = pg_fetch_assoc($res)) {
                if ($cliente['codcliente'] === $codigo){
                    $cli = ['nome' => $cliente['nome'],
                            'cpf' => $cliente['cpf'],
                            'email' => $cliente['email']
                    ];
                }
            }
            pg_close($MeuBD);
            return $cli;
        }
        public function DeletarCliente($id) {
            $MeuBD = $this->ConectarAoBanco();
            $sql = 'delete from cliente  where codcliente = $1';
            pg_query_params($MeuBD, $sql, array($id));
            pg_close($MeuBD);
        }
        public function AdicionarCliente($cli) {
            $MeuBD = $this->ConectarAoBanco();
            $sql2 = 'insert into cliente (codcliente, nome, cpf, email) values ($1, $2, $3, $4)';
            pg_query_params($MeuBD, $sql2, array(13, $cli->ObterNome(), $cli->ObterCpf(), $cli->ObterEmail()));
            // codcliente fixo, só é possível adiocionar uma vez se não mudar o número 12
            pg_close($MeuBD);
        }
        public function AtualizarCliente($cli, $codigo) {
            $MeuBD = $this->ConectarAoBanco();
            $sql = 'update cliente set nome = $1, cpf = $2, email = $3
            where codcliente =' . $codigo;
            pg_query_params($MeuBD, $sql, array($cli->ObterNome(), $cli->ObterCpf(), $cli->ObterEmail())); 
            pg_close($MeuBD);
        }
    }
?>