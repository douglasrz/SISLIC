<%@ page import="br.com.SISLIC.model.Funcionario" %>
<%@ page import="br.com.SISLIC.model.Gerente" %>
<%@ page import="br.com.SISLIC.model.Pedido" %>
<%@ page import="br.com.SISLIC.model.Produto" %>
<%@ page import="java.util.ArrayList"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>SISLIC - CADASTRAR PEDIDO</title>

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
                	<% 
                	//VERIFICAR SE É FUNCIONARIO OU GERENTE
                	Gerente ger = ((Gerente) request.getSession().getAttribute("gerAutenticado"));            	
					out.print("<a href=cadastrocontroller.do >"+ger.getNome()+"</a>");
					
					%>
                    <li><a href="logincontroller.do"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
                </li>
                </ul>
            <!-- /.navbar-top-links -->
			<!-- OPÃ‡Ã•ES DA PARTE ESQUERDA -->
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
                    <h1 class="page-header">Cadastrar pedido</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Cadastro
                        </div>
                        <div class="panel-body">
                            <div class="row">                               
                                    <form role="form" class="col-lg-12" action="cadastropedido.do?acao=cadastrarPedido" method="post">
                                    	<div class="col-lg-6">
	                                        <div class="form-group">
	                                            <label>Nome do pedido</label>
	                                            <input id="nomepedido" class="form-control" placeholder="Ex. notebooks" required>                                            
	                                        </div>                                      
	                                        <div class="form-group ">
	                                            <label>Data limite</label>
	                                            <input id="datalimite" class="form-control" placeholder="Ex. 20-11-2018" required>
	                                        </div> 
	                                        <div class="form-group">
	                                            <label>Selecione a categoria</label>
	                                            <select class="form-control" id="categoria">
	                                                <option>Informática</option>
	                                                <option>Móveis</option>
	                                                <option>Construção</option>
	                                                <option>Papel</option>
	                                                <option>Eletrônicos</option>
	                                            </select>
	                                            <p class="help-block"><a href="#" >Cadastrar nova categoria</a></p>
	                                        </div>                                        
	                                      </div>	                                 
	                                      <div class="col-lg-6">
		                                	 <div class="form-group">
		                                            <label>Descrição</label>
		                                            <textarea id="descricaoPedido" class="form-control" rows="5" required></textarea>
		                                        	<p class="help-block">Seja objetivo</p>
		                                      </div>
		                                </div>
		                                <table class="table table-striped" id="produtos">
				                                <thead>
				                                    <tr>
				                                        <th width="7%">Quant.</th>
				                                        <th width="25%">Produto</th>
				                                        <th>Descrição</th>
				                                        <th width="5%">Total</th>
				                                    </tr>                                    
				                                </thead>
				                                <tbody>
				                                <tr>
				                                	<td><input class="form-control" placeholder="Ex. 1" onkeyup="somenteNumeros(this);" type="text" id="quant1" required></td>
				                                	<td><input class="form-control" placeholder="Ex. notebook" type="text" id="nome1" required></td>
				                                	<td><input class="form-control" placeholder="Ex. os notebooks devem ser da marca Dell..." type="text" id="descricaoProduto1" required></td>
				                               		<td><input class="form-control" type="text" id="quantProdutos" value="1" readonly></td>
				                                </tr>				                               	 
				                                </tbody>
				                            </table>
				                            	<div class= "col-lg-4">
				                            		<a type="button" class="btn btn-primary btn-block col-lg-3" href="javascript:Adicionar()">Mais produtos</a>
				                            	</div>   				                            
				                                <div class= "col-lg-4">
				                                	<button type="reset" class="btn btn-warning btn-block col-lg-3">Limpar</button>
				                                </div>
				                                <div class= "col-lg-4">
				                                	 <button type="submit" class="btn btn-success btn-block col-lg-3">Cadastrar</button>
				                                </div>				                               
		                             </form>
		                                                           
                                <!-- /.col-lg-6 (nested) --> 
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
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

	function somenteNumeros(num) {
        var er = /[^0-9.]/;
        er.lastIndex = 0;
        var campo = num;
        if (er.test(campo.value)) {
          campo.value = "";
        }
    }
	function Adicionar(){
		var tamanho = $("#produtos tbody tr").length
		var i = tamanho+1
	    $("#produtos tbody").append(
	        "<tr>"+
	        "<td><input onchange=\"#\" class=\"form-control\" placeholder=\"Ex. 1\" onkeyup=\"somenteNumeros(this);\" type=\"text\" id=\"quant"+i+"\" required></td>"+
			"<td><input onchange=\"#\" class=\"form-control\" placeholder=\"Ex. notebooks\" type=\"text\" id=\"nome"+i+"\" required></td>"+
			"<td><input onchange=\"#\" class=\"form-control\" placeholder=\"Ex. os notebooks devem ser da marca Dell...\" type=\"text\" id=\"descricaoProduto"+i+"\" required></td>"+
			"<td><input class=\"form-control\" type=\"text\" id=\"quantProdutos\" value="+i+" readonly></td>"+
			"</tr>");
	};
	function Cadastrar(){
			if(window.confirm("Tem certeza que deseja cadastrar o novo pedido? (confira os dados)")){				
				location.href="gerentepedidos.do?acao=autorizar&id="+id;
			}
		}
</script>
</div>
</body>

</html>
