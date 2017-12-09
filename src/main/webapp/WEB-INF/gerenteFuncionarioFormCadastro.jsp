<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISLIC - Funcionário</title>

    <!-- Bootstrap Core CSS -->
    <link href="sbAdmin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="sbAdmin/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="sbAdmin/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="sbAdmin/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="sbAdmin/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="sbAdmin/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
   <script>
	   function confirma(mensagem, id){
		   if(window.confirm("Tem certeza que deseja "+mensagem+" o fornecedor?")){
			   location.href="gerenteFuncionariosController.jsp?acao="+mensagem+"&id="+id;
		   }
	   }
		function validarSenha(){ 
			var senha = document.formulario.senha.value;		
			var senhaRepetida = document.formulario.senhaAlt.value;
			if (senha != senhaRepetida){
				alert("Repita a senha corretamente");
				document.formulario.novasenhaAlt.focus();
				return false;
			}
		}
   </script>
</head>
<body>
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="gerentePedidosController.jsp">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- ícone do Usuario (cabeçalho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                	<% Gerente ger = ((Gerente) request.getSession().getAttribute("gerAutenticado"));            	
					out.print("<a href=gerenteCadastroController.jsp >"+ger.getNome()+"</a>");
					%>
                    <li><a href="loginController.jsp"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
                </li>
                </ul>
            <!-- /.navbar-top-links -->
			<!-- OPÇÕES DA PARTE ESQUERDA -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                        <a><i class="fa fa-shopping-cart fa-fw"></i>Pedidos<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerentePedidosController.jsp?acao=pedidosaberto">Pedidos em aberto</a>
                                </li>
                                <li>
                                    <a href="gerentePedidosController.jsp?acao=pedidospendentes">Pedidos pendentes</a>
                                </li>
                                <li>
                                    <a href="gerentePedidosController.jsp?acao=pedidosfechados">Pedidos finalizados</a>
                                </li>
                                <li>
                                    <a href="cadastroPedidoController.jsp">Cadastrar pedido</a>
                                </li>
                            </ul>
                        </li>                                               
                        <li>
                            <a><i class="fa fa-bar-chart-o fa-fw"></i>Fornecedores<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerenteFornecedoresController.jsp?acao=fornPendentes">Fornecedores pendentes</a>
                                </li>
                                <li>
                                    <a href="gerenteFornecedoresController.jsp?acao=fornCadastrados">Fornecedores cadastrados</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a><i class="fa fa-bar-chart-o fa-fw"></i>Funcionários<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerenteFuncionariosController.jsp">Funcionários cadastrados</a>
                                </li>
                                <li>
                                    <a href="gerenteFuncionariosController.jsp?acao=formCadastro">Cadastrar Funcionário</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                        	<a href="gerenteLancesController.jsp?acao=lances"> <i class="fa fa-legal fa-fw"></i>Lances</a>
                        </li>
                         <li>
                            <a href="gerenteCadastroController.jsp"><i class="fa fa-user fa-fw"></i>Cadastro</a>
                        </li>
                        <li>
                            <a href="sobreController.jsp"><i class="fa fa-info-circle fa-fw"></i> Sobre</a>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper">
            <div class="row">
	            <div class="col-lg-12">
	                    <h2 class="page-header">
	                                <i class="fa fa-shopping-cart fa-fw"></i>Cadastrar funcionário
	                            </h2>                            
	            </div><!-- /.col -->
      </div>
      <div class="panel-body">
                        <form name="formulario" action="gerenteFuncionariosController.jsp?acao=cadastrar" method="POST" >
                           <fieldset>         
                           	<div class="col-lg-6">                       
                                    	<div class="form-group">
                                          	<label for="disabledSelect">Username</label>
                                        	<input class="form-control" name="login" type="text"  placeholder="Login (não poderá ser alterado)" required>
                                        </div>                                        
                                        <div class="form-group">
                                            <label>Nome</label>
                                            <input class="form-control" name="nome"  placeholder="Ex. Fulano de tal" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Senha</label>
                                            <input class="form-control" type="password" name="senha" required>
                                        </div> 
                                        <div class="form-group">
                                            <input class="form-control" placeholder="Digite a nova senha novamente" type="password" name="senhaAlt" required>
                                        </div>
                                    </div>
                                     <div class="col-lg-6">
                                    	<div class="form-group">
                                            <label for="disabledSelect">Cargo</label>
                                            <input class="form-control" type="text"  placeholder="Ex. Auxiliar Administrativo" name="cargo" required>
                                        </div>
	                                 	<div class="form-group">
	                                	    <label>Setor</label>
	                                        <input class="form-control"  placeholder="Ex. Financeiro" name="setor" onkeyup="somenteNumeros(this);" required>
	                                    </div>
                                        <div class="form-group">
                                           	<label>Telefone</label>
                                           	<input class="form-control"  placeholder="Ex. 998098789" name="telefone" required>
                                        </div> 
                                     </div>
                                     <div class="col-lg-12">   
                                     <div class="col-lg-6">
	                                    <button type="submit" class="btn btn-success btn-block" onclick="return validarSenha()" >Enviar</button>            
	                                 </div>   
	                                 <div class="col-lg-6">
	                                 	<button type="reset" class="btn btn-warning btn-block">Limpar</button> 
	                                 </div>   
                                  </div>                                                                           
                              </fieldset>
                        </form>
                    </div>
                </div>
    <!-- jQuery -->
    <script src="sbAdmin/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="sbAdmin/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="sbAdmin/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="sbAdmin/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="sbAdmin/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="sbAdmin/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="sbAdmin/dist/js/sb-admin-2.js"></script>
	</div>
</div>
</body>
</html>