<%@ page import="br.com.SISLIC.model.Gerente"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.model.Produto"%>
<%@ page import="java.util.ArrayList"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISLIC - PONTUAÇÃO</title>

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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->	
   
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
                <a class="navbar-brand" href="pedidocontroller.do">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- ícone do Usuario (cabeçalho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                	<% Gerente ger = ((Gerente) request.getSession().getAttribute("gerAutenticado"));            	
					out.print("<a href=cadastrocontroller.do >"+ger.getNome()+"</a>");
					Lance lance = (Lance) request.getAttribute("lance");
					%>
                    <li><a href="logincontroller.do"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
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
                                    <a href="gerentepedidos.do?acao=pedidosaberto">Pedidos em aberto</a>
                                </li>
                                <li>
                                    <a href="gerentepedidos.do?acao=pedidospendentes">Pedidos pendentes</a>
                                </li>
                                <li>
                                    <a href="gerentepedidos.do?acao=pedidosfechados">Pedidos finalizados</a>
                                </li>
                                <li>
                                    <a href="cadastropedido.do">Cadastrar pedido</a>
                                </li>
                            </ul>
                        </li>                                               
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>Fornecedores<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#">Fornecedores pendentes</a>
                                </li>
                                <li>
                                    <a href="#">Fornecedores cadastrados</a>
                                </li>
                                <li>
                                    <a href="#">Cadastrar fornecedores</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                        	<a href="gerentelancescontroller.do?acao=lances"> <i class="fa fa-legal fa-fw"></i>Lances</a>
                        </li>
                         <li>
                            <a href="cadastrocontroller.do"><i class="fa fa-user fa-fw"></i>Cadastro</a>
                        </li>
                        <li>
                            <a href="sobrecontroller.do"><i class="fa fa-info-circle fa-fw"></i> Sobre</a>
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
	                                <i class="fa fa-shopping-cart fa-fw"></i><%=lance.getPedido().getNome()%> <small>(Lance)</small>
	                                <small class="pull-right"><%=lance.getPedido().getProdutos().get(0).getCategoria().getNome() %></small>
	                            </h2>                            
	            </div><!-- /.col -->
            </div>
            <!-- info row -->
            <div class="row invoice-info">
            	<div class="col-sm-6 invoice-col">                            
                    <address>
                        <strong>Descrição</strong><br>
                          	<%
                                out.print(lance.getPedido().getDescricao());
                           	%>
                    </address>
             	</div><!-- /.col -->
                <div class="col-sm-3 invoice-col">
                     <address>
                         <strong>Datas</strong><br>
                         Lançado em <%=lance.getPedido().getDataLancamento()%><br>
                         Efetuado em <%=lance.getData()%><br>
                         Expira em <%=lance.getPedido().getDataLimite() %>
                     </address>
                </div><!-- /.col -->
                <div class="col-sm-3 invoice-col">
                     <address>
                         <strong>Valores R$</strong><br>
                         Taxa de entrega: <%=lance.getTaxaEntrega()%><br>
                         Valor total:  <%=lance.getValorTotal()%>                               
                	</address>
               </div><!-- /.col -->
           </div><!-- /.row -->
			<div class="row invoice-info">
            	<div class="col-sm-6 invoice-col">                            
                    <address>
                        <strong>Fornecedor</strong><br>
                          	<%
                                out.print("<a href=\"#\">"+lance.getForn().getrSocial()+"</a>");
                           	%>
                    </address>
             	</div><!-- /.col -->
                <div class="col-sm-3 invoice-col">
                     <address>
                         <strong>Informações</strong><br>
                         CNPJ: <%=lance.getForn().getCnpj()%><br>
                         E-mail: <%=lance.getForn().getEmail()%><br>
                     </address>
                </div><!-- /.col --> 
                <div class="col-sm-3 invoice-col">
                     <address>
                     	<br>
                         Telefone: <%=lance.getForn().getTelefone()%><br>
                         Pontuação atual: <%=lance.getForn().getPontuacao()%>
                     </address>
                </div><!-- /.col -->               
           </div><!-- /.row -->
                    <!-- Table row -->
                    <form>
                    <div class="row">   
                        <div class="col-xs-12 table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Quant.</th>
                                        <th>Produto</th>
                                        <th>Descrição</th>
                                        <th>Valor R$</th>
                                    </tr>                                    
                                </thead>
                                <tbody>
                                	<%
                                		int i = 0;
                                		for(Produto p: lance.getPedido().getProdutos()){
                                			out.print("<tr>");
                                			out.print("<td>"+p.getQuantidade()+"</td>");
                                			out.print("<td>"+p.getNome()+"</td>");
                                			out.print("<td>"+p.getDescricao()+"</td>");
                                			out.print("<td>"+p.getPreco()+"</td>");
                                			out.print("</tr>");
                                			i++;
                                		}
                                	%>
                                </tbody>
                            </table>
                           <strong>Observações<br> </strong>
                            <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
                            	A negociação não é realizada pelo sistema, para efetuar a compra é necessário entrar em contato com o fornecedor, pelo seus contatos disponiveis.
                            </p>     
                        </div><!-- /.col -->                        
                    </div><!-- /.row -->                                                         	 
             </form>
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