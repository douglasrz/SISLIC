<%@ page import="br.com.SISLIC.model.Fornecedor"%>
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
                <a class="navbar-brand" href="pedidocontroller.do">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- Ã­cone do Usuario (cabeÃ§alho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">                
                	<% Fornecedor forn = ((Fornecedor) request.getSession().getAttribute("forAutenticado"));                	
					out.print("<a href=cadastrocontroller.do >"+forn.getrSocial()+"</a>");%>
                    <li><a href="logincontroller.do"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
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
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">SISLIC</h1>
                         <p>SISLIC é um sistema de compras e licitações da empresa Cimento Apodi...</p>
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
		