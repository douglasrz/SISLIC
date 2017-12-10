<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISLIC - Gerente</title>

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
   	function validarSenha(){ 
			var senha = document.formulario.novasenha.value;		
			var senhaRepetida = document.formulario.novasenhaAlt.value;
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
                <a class="navbar-brand" href="gerentePedidosController.jsp?acao=pedidosaberto">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- ícone do Usuario (cabeçalho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                	<% Gerente gerente = ((Gerente) request.getSession().getAttribute("gerAutenticado"));            	
					out.print("<a href=gerenteCadastroController.jsp >"+gerente.getNome()+"</a>");
					ArrayList<Pedido> pedidos = (ArrayList<Pedido>) session.getAttribute("pedidosGer");
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
                        <a href="#"><i class="fa fa-shopping-cart fa-fw"></i> Pedidos<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerentePedidosController.jsp?acao=pedidosaberto"> Pedidos em aberto</a>
                                </li>
                                <li>
                                    <a href="gerentePedidosController.jsp?acao=pedidospendentes"> Pedidos pendentes</a>
                                </li>
                                <li>
                                    <a href="gerentePedidosController.jsp?acao=pedidosfechados"> Pedidos finalizados</a>
                                </li>
                                <li>
                                    <a href="cadastroPedidoController.jsp"> Cadastrar pedido</a>
                                </li>
                            </ul>
                        </li>                                               
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-users"></i> Fornecedores<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerenteFornecedoresController.jsp?acao=fornPendentes"> Fornecedores pendentes</a>
                                </li>
                                <li>
                                    <a href="gerenteFornecedoresController.jsp?acao=fornCadastrados"> Fornecedores cadastrados</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-users"></i> Funcionários<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerenteFuncionariosController.jsp?"> Funcionários cadastrados</a>
                                </li>
                                <li>
                                    <a href="gerenteFuncionariosController.jsp?acao=formCadastro"> Cadastrar Funcionário</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                        	<a href="gerenteLancesController.jsp?acao=lances"> <i class="fa fa-legal fa-fw"></i> Lances</a>
                        </li>
                         <li>
                            <a href="gerenteCadastroController.jsp"><i class="fa fa-user fa-fw"></i> Cadastro</a>
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
	                                <i class="fa fa-user fa-fw"></i>Meu cadastro
	                                <small class="pull-right"><a type="button" class="btn btn-primary pull-right btn-block" data-toggle="modal" data-target="#myModal">Editar</a> 
           							</small>
	                    </h2>                            
	            </div><!-- /.col -->
            </div>
            <!-- info row -->
            <div class="row invoice-info col-xs-12">
            	<div class="col-sm-6 invoice-col">                            
                    <address>
                        <strong>Informaçãoes gerais</strong><br>
                        	Login: <%=gerente.getLogin() %><br>
                          	Nome: <%=gerente.getNome() %><br>
                          	Telefone: <%=gerente.getTelefone()%>
                    </address>                    	 
               	</div>
               	<div class="col-sm-6 invoice-col">                            
                    <address><br>
                    		Cargo:  <%=gerente.getCargo() %><br>
                          	Setor: <%=gerente.getSetor().getNome()%><br>
                          	
                    </address>                    	 
               	</div>
          </div>           
             <div class="col-xs-12 table-responsive">
                        <h2>Pedidos</h2>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th width="20%">Pedido</th>
                                        <th>Descrição do pedido</th>
                                        <th width="20%">Data lançamento</th>
                                        <th width="20%">Data limite</th>
                                    </tr>                                    
                                </thead>
                                <tbody>
                                	<%
	                                for(Pedido p: pedidos){
	        							out.print("<tr onclick= location.href=\"gerentePedidosController.jsp?acao=pedido&id="+p.getId()+"\" style=\"cursor: pointer;\" title=\"Ver detalhes\">");
	                                	out.print("<td>"+p.getNome()+"</td>");
	                                	out.print("<td>"+p.getDescricao()+"</td>");
	                                	out.print("<td>"+p.getDataLancamento()+"</td>");
	                                	out.print("<td>"+p.getDataLimite()+"</td>");	                                			
	                                	out.print("</tr>");
	                                }
                                	%>
                                </tbody>
                            </table>                             
                 </div><!-- /.col -->                         
                         <!-- Modal -->
                  <div class="col-lg-6">	
           				</div>
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Editar Cadastro</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form name="formulario" action="gerenteCadastroController.jsp?acao=alterarCadastro" method="POST">                                    
	                                    		<div class="form-group col-lg-6">
	                                            	<label>Nome</label>
	                                                <input class="form-control" name="nome" type="text" value="<%=gerente.getNome()%>" required>
	                                        	</div>                                        
	                                        	<div class="form-group col-lg-6">
	                                            	<label>Cargo</label>
	                                            	<input class="form-control" name="cargo" type="text" value="<%=gerente.getCargo()%>" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-6">
	                                            	<label>Setor</label>
	                                            	<input class="form-control" name="setor" type="text" value="<%=gerente.getSetor().getNome()%>" required>
	                                        	</div>	
	                                        	<div class="form-group col-lg-6">
	                                            	<label>Telefone</label>
	                                            	<input class="form-control" name="telefone" type="text" value="<%=gerente.getTelefone()%>" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-6">
	                                            	<label>Senha</label>
	                                            	<input class="form-control" name="novasenha" type="password" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-6">
	                                        		<label>Senha novamente</label>
	                                            	<input class="form-control" name="novasenhaAlt" type="password" required>
	                                        	</div>	                               			
	                                        	<button type="submit" class="btn btn-success btn-block" onclick="return validarSenha()">Enviar</button>  	                                        	                                                                          
                                			</form>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                        
                 </div>
                         
            <!-- /.row -->
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