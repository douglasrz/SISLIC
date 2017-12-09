<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISLIC - Fornecedor</title>

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
		   console.log("location.href=\"gerenteFornecedoresController.jsp?acao=\"+mensagem+\"&id=\"+id;")
		   location.href="gerenteFornecedoresController.jsp?acao="+mensagem+"&id="+id;
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
					Fornecedor fornecedor = (Fornecedor) request.getSession().getAttribute("fornecedor");
					boolean tipo = (boolean) request.getSession().getAttribute("tipoFornPendete");
					int pontuacao = fornecedor.getPontuacao();
                	float porcentagem = (pontuacao*100)/20;
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
                        <a href="#"><i class="fa fa-shopping-cart fa-fw"></i>Pedidos<span class="fa arrow"></span></a>
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
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>Fornecedores<span class="fa arrow"></span></a>
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
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>Funcionário<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerenteFuncionariosController.jsp">Funcionários cadastrados</a>
                                </li>
                                <li>
                                    <a href="gerenteFuncionariosController.jsp?acao=Cadastrar">Cadastrar Funcionário</a>
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
	                                <i class="fa fa-shopping-cart fa-fw"></i>Fornecedor
	                                <small class="pull-right">Cadastro</small>
	                            </h2>                            
	            </div><!-- /.col -->
            </div>
            <!-- info row -->
            <div class="row invoice-info">
            	<div class="col-sm-3 invoice-col">                            
                    <address>
                        <strong>Informaçãoes gerais</strong><br>
                          	Razão Social: <%=fornecedor.getrSocial() %><br>
                          	CNPJ:  <%=fornecedor.getCnpj() %>
                    </address> 
                    	<address>
                         <strong>Contatos</strong><br>
                         Telefone: <%=fornecedor.getTelefone() %><br>
                         E-mail:  <%=fornecedor.getEmail() %>
                     </address> 
               	</div>
               	<div class="col-sm-4 invoice-col"> 
               	<address>           		 
                        	<p>
                                <strong>
                                Sua pontuação no momento é <%=pontuacao%>  (<%=porcentagem %>%)
                                </strong>
                                <!-- A PONTUAÇÃO TOTAL É 20 PONTOS. 100% = 20 -->
                                <span class="pull-right text-muted">100%</span>
                            </p>
                               <div class="progress progress-striped active">
                               <% if( porcentagem <= 50){
		                        		out.print("<div class=\"progress-bar progress-bar-success\" style=\"width: ");
		                        		out.print(porcentagem);
		                        		out.print("%\" >");
		                        	}else{
		                        		if(porcentagem<=80){
		                        			out.print("<div class=\"progress-bar progress-bar-warning\" style=\"width: ");
		                        			out.print(porcentagem);
			                        		out.print("%\" >");
		                        		}else{
		                        			out.print("<div class=\"progress-bar progress-bar-danger\" style=\"width: ");
		                        			out.print(porcentagem);
			                        		out.print("%\" >");			                        	
		                        		}
		                        	}
		                        	%>
		                         <span class="sr-only">40% Completo (success)</span>
                               </div>
                      </address>
                      </div>
                    <div class="col-sm-5 invoice-col">    
                    <address>
                         	<table class="table table-responsive">
                                <thead>
                                    <tr>
                                        <th>Categorias</th>
                                        <th>Descrição</th>
                                    </tr>                                    
                                </thead>
                                <tbody>
                                	<%
                                		if(fornecedor.getCategorias() != null){
                                			for(Categoria c: fornecedor.getCategorias()){
	                                			out.print("<tr>");
	                                			out.print("<td>"+c.getNome()+"</td>");
	                                			out.print("<td>"+c.getDescricao()+"</td>");
	                                			out.print("</tr>");
	                                		}
                                		}
                                	%>
                                </tbody>
                            </table>
                     </address>                                                              	
             	</div><!-- /.col -->
          </div> 
             <div class="col-xs-12 table-responsive">
                        <h1>Lances</h1>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Pedido</th>
                                        <th>Data</th>
                                        <th>Descrição do pedido</th>
                                        <th>Valor total R$</th>
                                    </tr>                                    
                                </thead>
                                <tbody>
                                	<%
                                		int i = 0;
                                		if(fornecedor.getLances() != null){
	                                		for(Lance l: fornecedor.getLances()){
	                                			out.print("<tr>");
	                                			out.print("<td>"+l.getPedido().getNome()+"</td>");
	                                			out.print("<td>"+l.getData()+"</td>");
	                                			out.print("<td>"+l.getPedido().getDescricao()+"</td>");
	                                			out.print("<td>"+l.getValorTotal()+"</td>");
	                                			out.print("</tr>");
	                                			i++;
	                                		}
                                		}
                                	%>
                                </tbody>
                            </table>                             
                        </div><!-- /.col --> 
                         <div class="col-xs-3">	
                         	<a type="button" class="btn btn-primary pull-right btn-block" <%if(tipo){out.print("disabled");}%> data-toggle="modal" data-target="#myModal">Atribuir penalidade</a> 
                        </div>
                        <div class="col-xs-3">	
                        	<a type="button" class="btn btn-warning btn-block" href="javascript:confirma('excluir', <%=fornecedor.getId()%>)">Excluir</a>  
                        </div>
                        <div class="col-xs-3">
                        	<a type="button" class="btn btn-success btn-block" <%if(!tipo){out.print("disabled");}else{%> href="javascript:confirma('autorizar', <%=fornecedor.getId()%>)"<%} %>>Autorizar</a> 
                        </div>
                        <div class="col-xs-3">
                         	<a type="button" class="btn btn-primary pull-right btn-block" <%if(tipo){out.print("disabled");}%> data-toggle="modal" data-target="#myModal2">Remover penalidade</a> 
                        </div>
                         <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Atribuir penalidade</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form action="penalidadeController.jsp?acao=atribuirPenalidade" method="POST">                                    
	                                    		<div class="form-group col-lg-3">
	                                            	<label>Valor</label>
	                                                <input class="form-control" name="valor" type="text" placeholder="Entre 0 e 20" required>
	                                        	</div>                                        
	                                        	<div class="form-group col-lg-9">
	                                            	<label>Motivo</label>
	                                            	<input class="form-control" name="motivo" type="text" placeholder="Ex.: Atraso na entrega" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-12">
	                                            	<label>Descrição</label>
	                                            	<input class="form-control" name="descricao" type="text" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-12">
	                                        		<label>Nome do pedido</label>
		                                            <select class="form-control" name="pedido">
		                                            	<option disabled>Selecione um pedido</option>
		                                            <%
		                                            for(Lance lances: fornecedor.getLances()){
	                                            		out.print("<option>"+lances.getPedido().getNome()+"</option>");		                                            		
	                                            	}
		                                            %>	
		                                            </select>
		                               			</div> 
		                               			<div class="form-group col-lg-12">
	                                        	<p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
	                                        	A pontuação é entre 0 e 20, quando for antigido 20 pontos de penalidade, o seu cadastro será bloqueado. Na descrição identifique se é adcionado a penalidade ou diminuido, para ficar no log.  
	                                        	</p> 
	                                        	</div> 
	                                        	<button type="submit" class="btn btn-success btn-block">Enviar</button>  	                                        	                                                                          
                                			</form>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
                            <!-- MODAL 2 -->
                            <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Remover penalidade</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form action="penalidadeController.jsp?acao=removerPenalidade" method="POST">                                    
	                                    		<div class="form-group col-lg-3">
	                                            	<label>Valor</label>
	                                                <input class="form-control" name="valor" type="text" placeholder="Entre 0 e 20" required>
	                                        	</div>                                        
	                                        	<div class="form-group col-lg-9">
	                                            	<label>Motivo</label>
	                                            	<input class="form-control" name="motivo" type="text" placeholder="Ex.: Atraso na entrega" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-12">
	                                            	<label>Descrição</label>
	                                            	<input class="form-control" name="descricao" type="text" required>
	                                        	</div>
	                                        	<div class="form-group col-lg-12">
	                                        		<label>Nome do pedido</label>
		                                            <select class="form-control" name="pedido">
		                                            	<option disabled>Selecione um pedido</option>
		                                            <%
		                                            for(Lance lances: fornecedor.getLances()){
	                                            		out.print("<option>"+lances.getPedido().getNome()+"</option>");		                                            		
	                                            	}
		                                            %>	
		                                            </select>
		                               			</div> 
		                               			<div class="form-group col-lg-12">
	                                        	<p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
	                                        	A pontuação é entre 0 e 20, quando for antigido 20 pontos de penalidade, o seu cadastro será bloqueado. Na descrição identifique se é adcionado a penalidade ou diminuido, para ficar no log.  
	                                        	</p> 
	                                        	</div> 
	                                        	<button type="submit" class="btn btn-success btn-block">Enviar</button>  	                                        	                                                                          
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