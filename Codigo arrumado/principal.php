<?php
    require('back-end/clienteDAO.php');
    $banco = new ClienteDAO();
?>

<!DOCTYPE html>
<html lang="pt-BR">
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
    <title>Página Inicial</title>
</head>
<body>
    <h3>Cadastro</h3>
    <form action="adiciona.php" method="post">
        <input type="text" name="nome" placeholder="Nome">
        <input type="number" name="cpf" placeholder="xxx.xxx.xxx-xx">
        <input type="email" name="email" placeholder="...@...">
        <button type="submit">Enviar</button>
    </form><br><br>
    <form action="atualiza.php" method="post">
        <label for="">Código:</label>
        <input type="text" name="codigo" placeholder="Informe o código">
        <button id="btn">Atualize seus dados</button>
    </form><br>
    <h3>Excluir cliente</h3>
    <form action="deleta.php" method="get">
        <label for="">Código: </label>
        <input type="number" name="codigo" placeholder="Informe o código">
        <button type="submit">Excluir</button>
    </form>
    <h3>Clientes cadastrados</h3>
    <table>
        <tr>
            <th>Cliente</th>
            <th>Código</th>
        </tr>
        <?php $banco->ObterClientes();?>
    </table>
</body>
</html>