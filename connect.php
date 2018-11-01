<?php
    $codcliente = 0;
    function ConectarAoBanco(){
        $BD = 'port=5432 dbname=venda user=postgres password=postgres';
        return pg_connect($BD);
    }

    function ObterClientes() {
        $MeuBD = ConectarAoBanco();
        $sql = 'select * from cliente';
        $res = pg_query($MeuBD, $sql);
        while($cliente = pg_fetch_assoc($res)) {
            // print_r($cliente);
            echo $cliente['nome']; 
        }
        pg_close($MeuBD);
    }

    function DeletarCliente($id) {
        $MeuBD = ConectarAoBanco();
        $deleta = 'delete from cliente  where codcliente = $1';
        $res = pg_query_params($MeuBD, $deleta, array($id));
        pg_close($MeuBD);
    }
    function AdicionarCliente($codcliente, $nome, $cpf, $email) {
        $MeuBD = ConectarAoBanco();
        if($nome !== null && cpf !== null) {
            $sql2 = 'insert into cliente (codcliente, nome, cpf, email) values ($1, $2, $3, $4)';
            $vetor = array($codcliente, $nome, $cpf, $email);
            pg_query_params($MeuBD, $sql2, $vetor);
        }
        pg_close($MeuBD);
    }


    AdicionarCliente(223, 'Alan', '40027122698', '32@gmail.com');
    // DeletarCliente();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
    <title>Teste</title>
</head>
<body>
    <form>
        <h3>Adicionar Cliente</h3>
        <label for="">Nome:</label>
        <input type="text" placeholder="Nome completo">
        <label for="">E-mail:</label>
        <input type="email" placeholder="...@...">
        <label for="">Cpf:</label>
        <input type="number" placeholder="000.000.000-00">
    </form><br>
    <table>
        <tr>
            <th>Cliente</th>
            <th>Código</th>
        </tr>
        <tr>
            <td>Alan</td>
            <td>01</td>
        </tr>
    </table>
</body>
</html>