<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Penalidade"%>
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
                	<% Fornecedor forn = ((Fornecedor) request.getSession().getAttribute("forAutenticado")); 
                	int pontuacao = forn.getPontuacao();
                	float porcentagem = (pontuacao*100)/20;
                	ArrayList<Penalidade> penalidades = (ArrayList<Penalidade>) request.getSession().getAttribute("penalidades");                	
					out.print("<a href=cadastrocontroller.do >"+forn.getrSocial()+"</a>");%>
                    <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
                </li>
                </ul>
            <!-- /.navbar-top-links -->
			<!-- OPÇÕES DA PARTE ESQUERDA -->
            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                        <a href="pedidocontroller.do"><i class="fa fa-shopping-cart fa-fw"></i> Pedidos</a>
                        </li>
                        <li>
                            <a href="lancescontroller.do"><i class="fa fa-wrench fa-fw"></i>Lances</a>
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
                    <h1 class="page-header">Pontuação</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Pontuação de penalidades</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
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
                                </div>
                                <span class="pull-right text-muted small">
                                    <em> Obs: A pontuação refere-se as penalidades atribuídas a você, por descomprimentos das regras estabelecidade por nossa empresa, tais como: atraso de entrega, produto de baixa qualidade, desistência do lance ofertado, etc. Para maiores informações nos contate.</em>
                                </span>
                        </div>
            		</div>
           		</div>
            <!-- /.row -->
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Penalidade</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                <tr>
                                	<th>ID pedido</th>
                                   <th>Pedido</th>
                                   <th>Motivo</th>
                                   <th>Descrição</th>
                                   <th>Valor</th>
                                   <th>Data</th>
                               	</tr>                               	
                                </thead>                                
                                <tbody>                                
							 	<% for(Penalidade p: penalidades){
							 		out.print("<tr>");
							 		out.print("<td>"+p.getId_pedido()+"</td>");
							 		out.print("<td>"+p.getNomePedido()+"</td> <td>"+p.getMotivo()+"</td>");
							 		out.print("<td>"+p.getDescricao()+"</td> <td>"+p.getValor()+"</td>");
							 		out.print("<td>"+p.getData()+"</td>");
							 		out.print("</tr>");
							 	}%>                          
                                </tbody>
                            </table>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
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