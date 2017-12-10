<%@ page import="br.com.SISLIC.model.Gerente"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SISLIC - Sobre</title>

    <!-- Bootstrap Core CSS -->
    <link href="sbAdmin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="sbAdmin/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

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
                <a class="navbar-brand" href="gerentePedidosController.jsp?acao=pedidosaberto">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- Ã­cone do Usuario (cabeÃ§alho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">                
                	<% Gerente ger = ((Gerente) request.getSession().getAttribute("gerAutenticado"));                	
					out.print("<a href=gerenteCadastroController.jsp >"+ger.getNome()+"</a>");%>
                    <li><a href="logincontroller.do"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
                </li>
                </ul>
            <!-- /.navbar-top-links -->
			<!-- OPÃ‡Ã•ES DA PARTE ESQUERDA -->
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
                            <a><i class="fa fa-bar-chart-o fa-users"></i> Funcionário<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="gerenteFuncionariosController.jsp"> Funcionários cadastrados</a>
                                </li>
                                <li>
                                    <a href="gerenteFuncionariosController.jsp?acao=Cadastrar"> Cadastrar Funcionário</a>
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
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                    	<h2 class="page-header">
	                                <i class="fa fa-spinner"></i> SISLIC
	                            </h2> 
                         <p>SISLIC é um sistema de compras e licitações da empresa M2D, que por objetivo oferecer a oportunidade de empresas possam aproveitar as nossas necessidades e oferecer seus produtos.</p>
                    </div>
                   
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->
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
</body>

</html>
		