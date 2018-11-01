<?php
    require('back-end/clienteDAO.php');

    $banco = new ClienteDAO();
    $banco->DeletarCliente($_GET['codcliente']);
    header('Location: principal.php'); 
?>