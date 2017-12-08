<%@ page import="br.com.SISLIC.model.Funcionario" %>
<%@ page import="br.com.SISLIC.model.Gerente" %>
<%@ page import="br.com.SISLIC.model.Pedido" %>
<%@ page import="br.com.SISLIC.model.Produto" %>
<%@ page import="br.com.SISLIC.model.Categoria" %>
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
                <a class="navbar-brand" href="gerentePedidoController.do">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- Ã­cone do Usuario (cabeÃ§alho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">                	
                	<% 
                	Gerente ger = ((Gerente) request.getSession().getAttribute("gerAutenticado"));            	
					out.print("<a href=gerenteCadastroController.jsp >"+ger.getNome()+"</a>");
					ArrayList<Categoria> categorias = (ArrayList<Categoria>) request.getSession().getAttribute("categorias");
					%>
                    <li><a href="loginController.jsp"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
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
                                    <a href="gerentePedidosController.jsp?acao=pedidosaberto">Pedidos em aberto</a>
                                </li>
                                <li>
                                    <a href="gerentePedidosController.js?acao=pedidospendentes">Pedidos pendentes</a>
                                </li>
                                <li>
                                    <a href="gerentePedidosController.js?acao=pedidosfechados">Pedidos finalizados</a>
                                </li>
                                <li>
                                    <a href="cadastroPedidoController.jsp">Cadastrar pedido</a>
                                </li>
                            </ul>
                        </li>                                               
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-users"></i> Fornecedores<span class="fa arrow"></span></a>
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
                            <a href="#"><i class="fa fa-bar-chart-o fa-users"></i> Funcionário<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="#">Funcionários pendentes</a>
                                </li>
                                <li>
                                    <a href="#">Funcionários cadastrados</a>
                                </li>
                                <li>
                                    <a href="#">Cadastrar Funcionário</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                        	<a href="gerentelancescontroller.do?acao=lances"> <i class="fa fa-legal fa-fw"></i> Lances</a>
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
                                    <form method="GET" action="cadastroPedidoController.jsp?acao=cadastrarPedido">
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
	                                            	<% for(Categoria c: categorias){
	                                            		out.print("<option>"+c.getNome()+"</option>");
	                                            	}
	                                            	%>
	                                                <!--  <option>Informática</option>
	                                                <option>Móveis</option>
	                                                <option>Construção</option>
	                                                <option>Papel</option>
	                                                <option>Eletrônicos</option>-->
	                                            </select>
	                                            <p class="help-block"><a data-toggle="modal" data-target="#myModal" style="cursor: pointer;">Cadastrar nova categoria</a></p>
	                                        </div>                                        
	                                      </div>	                                 
	                                      <div class="col-lg-6">
		                                	 <div class="form-group">
		                                            <label>Descrição</label>
		                                            <textarea id="descricaoPedido" class="form-control" rows="5" required></textarea>
		                                        	<p class="help-block">Seja objetivo</p>
		                                      </div>
		                                </div>
		                                <table class="table" id="produtos">
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
				                                	<td>
				                                		<input id="quant1" class="form-control" placeholder="Ex. 1" onkeyup="somenteNumeros(this);" required>
				                                	</td>
				                                	<td>
				                                		<input id="nome1" class="form-control" placeholder="Ex. notebook" required>
				                                	</td>
				                                	<td>
				                                		<input id="descricaoProduto1" class="form-control" placeholder="Ex. os notebooks devem ser da marca Dell..." required>
				                                	</td>
				                               		<td>
				                               			<input id="totalProdutos" class="form-control"  value = 1 readonly>
				                               		</td>
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
		                     <!-- CADASTRAR NOVA CATEGORIA -->
                            <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Cadastrar categoria</h4>
                                        </div>
                                        <div class="modal-body">
                                            <form action="categoriacontroller.do" method="POST">                                    
	                                    		<div class="form-group">
	                                            	<label>Nome</label>
	                                                <input class="form-control" name="nome" type="text" required>
	                                        	</div>                                        
	                                        	<div class="form-group">
	                                            	<label>Descrição</label>
	                                            	<input class="form-control" name="descricao" type="text" required>
	                                        	</div>               
	                                         	<button type="submit" class="btn btn-success ">Enviar</button>            
	                                    		<button type="reset" class="btn btn-warning ">Limpar</button>                                                                          
                                			</form>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>		                                                           
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
	        "<td><input id=\"quant"+i+"\" class=\"form-control\" placeholder=\"Ex. 1\" onkeyup=\"somenteNumeros(this);\" required></td>"+
			"<td><input id=\"nome"+i+"\" class=\"form-control\" placeholder=\"Ex. notebooks\" required></td>"+
			"<td><input id=\"descricaoProduto"+i+"\" class=\"form-control\" placeholder=\"Ex. os notebooks devem ser da marca Dell...\" required></td>"+
			"<td><input id=\"totalProdutos\" class=\"form-control\" name=\"totalProdutos\" value="+i+" readonly></td>"+
			"</tr>");
	};
</script>
</div>
</body>

</html>
