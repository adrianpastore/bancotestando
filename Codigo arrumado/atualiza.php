<?php
    require('back-end/clienteDAO.php');
    require('back-end/cliente.php');
    
    $banco = new ClienteDAO();
    $cli = $banco->ObterCliente($_POST['codigo']);
    $cli = new Cliente($cli['nome'], $cli['cpf'], $cli['email']);
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Atualização de dados</title>
</head>
<body>
    <h3>Atualizar dados</h3> Seu código: 
    <?php echo '<label type="text" name="cg">' . $_POST['codigo'] .' </label>'?> <br><br>
    <form action="atualiza(1).php" method="post">
        <?php
            echo 'Nome: <input type="text" name="nome" placeholder="Nome" value="' . $cli->ObterNome() .'"><br><br>
            Cpf: <input type="number" name="cpf" placeholder="xxx.xxx.xxx-xx" value="' . $cli->ObterCpf() .'"><br><br>
            E-mail: <input type="email" name="email" placeholder="...@..." value="' . $cli->ObterEmail() .'">'
        ?>
        <button type="submit">Atualizar</button>
        <br><br>
    </form><br>
    <button id="pi">Página Inicial</button>
    <script>
        var btn = document.querySelector('#pi');
        btn.addEventListener('click', function () {
            window.location.href = "principal.php";
        });
    </script>
</body>
</html>