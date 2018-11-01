<?php
    require('back-end/clienteDAO.php');
    require('back-end/cliente.php');

    $cli = new Cliente($_POST['nome'],$_POST['cpf'],$_POST['email']);
    $banco = new ClienteDAO();
    $banco->AdicionarCliente($cli);
    header('Location: principal.php'); 
?>