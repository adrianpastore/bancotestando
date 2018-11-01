<?php
    require('back-end/clienteDAO.php');
    require('back-end/cliente.php');

    $banco = new ClienteDAO();
    $cli = new Cliente($_POST['nome'], $_POST['cpf'], $_POST['email']);
    echo $_POST['cg'];
    // $banco->AtualizarCliente($cli, $_POST['codigo']);
    // header('Location: principal.php');
?>