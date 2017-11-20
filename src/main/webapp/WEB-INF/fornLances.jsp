<%@ page import="br.com.SISLIC.model.Fornecedor" %>
<%@ page import="br.com.SISLIC.model.Lance" %>
<%@ page import="java.util.ArrayList"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISLIC - LANCES</title>

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
                <!-- Ã­cone do Usuario (cabeÃ§alho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">                
                	<% Fornecedor forn = ((Fornecedor) request.getSession().getAttribute("forAutenticado"));   
                	ArrayList<Lance> lances = (ArrayList<Lance>)  request.getSession().getAttribute("lances");
					out.print("<a href=cadastrocontroller.do >"+forn.getrSocial()+"</a>");%>
                    <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
                </li>
                </ul>
            <!-- /.navbar-top-links -->
			<!-- OPÃ‡Ã•ES DA PARTE ESQUERDA -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                        <a href="pedidocontroller.do"><i class="fa fa-shopping-cart fa-fw"></i> Pedidos</a>
                        </li>
                        <li>
                            <a href="lancescontroller.do"><i class="fa fa-legal fa-fw"></i>Lances</a>
                        </li>                        
                        <li>
                            <a href="pontcontroller.do"><i class="fa fa-bar-chart-o fa-fw"></i> Pontuação</a>
                        </li>
                         <li>
                            <a href="cadastrocontroller.do"><i class="fa fa-user fa-fw"></i> Cadastro</a>
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
                    <h1 class="page-header">Lances</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <% for(Lance l: lances){
                	%>
                	<div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        <% 
                      	out.print(l.getPedido().getNome()+"</div>");
                        out.print("<div class=\"panel-body\">");
                        out.print("<p>"+l.getPedido().getDescricao()+"</p><br>");
                        out.print("<strong>Efetuado em: </strong>"+l.getData()+"<br>");
                        out.print("<strong>Expira em: </strong>"+l.getPedido().getDataLimite());
                        %>
                        </div><!-- painel body -->
                        <div class="panel-footer">
                        <a type="submit" href="lancescontroller.do?acao=lance&id=<%=l.getId()%>" class="btn btn-success btn-block"> Detalhes </a> </div>
                		</div>
                		</div>
                	<%} %>
                    </div>
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

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
 
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
    </script>
</div>
</div>
</body>
</html>
