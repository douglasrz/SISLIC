<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.model.Produto"%>
<%@ page import="java.util.ArrayList"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SISLIC - PEDIDO</title>

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
                <a class="navbar-brand" href="fornecedorPedidoController.jsp">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- ícone do Usuario (cabeçalho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                	<% Fornecedor forn = ((Fornecedor) request.getSession().getAttribute("forAutenticado"));            	
					out.print("<a href=fornecedroCadastroController.jsp >"+forn.getrSocial()+"</a>");
					Pedido pedido = ((Pedido) request.getSession().getAttribute("pedido"));
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
                        <a href="fornecedorPedidoController.jsp"><i class="fa fa-shopping-cart fa-fw"></i> Pedidos</a>
                        </li>
                        <li>
                            <a href="fornecedorLanceController.jsp"><i class="fa fa-legal fa-fw"></i> Lances</a>
                        </li>                        
                        <li>
                            <a href="fornecedorPontuacaoController.jsp"><i class="fa fa-bar-chart-o fa-fw"></i> Pontuação</a>
                        </li>
                         <li>
                            <a href="fornecedorCadastroController.jsp"><i class="fa fa-user fa-fw"></i> Cadastro</a>
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
                                <i class="fa fa-shopping-cart fa-fw"></i> <%=pedido.getNome() %>
                                <small class="pull-right"><%=pedido.getProdutos().get(0).getCategoria().getNome() %></small>
                            </h2>                            
                        </div><!-- /.col -->
                    </div>
                    <!-- info row -->
                    <div class="row invoice-info">
                        <div class="col-sm-6 invoice-col">                            
                            <address>
                                <strong>Descrição</strong><br>
                                <%
                                out.print(pedido.getDescricao());
                                %>
                            </address>
                        </div><!-- /.col -->
                        <div class="col-sm-6 invoice-col">
                            <address>
                                <strong>Informações gerais</strong><br>
                                Lançado em <%=pedido.getDataLancamento() %><br>
                                Expira em <%=pedido.getDataLimite() %>
                               
                            </address>
                        </div><!-- /.col -->
                    </div><!-- /.row -->

                    <!-- Table row -->
                                     
                    <form action="fornecedorLanceController.jsp?acao=efetuarlance" method="POST">
                    <div class="row">   
                        <div class="col-xs-12 table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th width="7%">Quant.</th>
                                        <th width="20%">Produto</th>
                                        <th>Descrição</th>
                                        <th width="24%">Valor</th>
                                    </tr>                                    
                                </thead>
                                <tbody>
                                	<%
                                		int i = 0;
                                		for(Produto p: pedido.getProdutos()){
                                			out.print("<tr>");
                                			out.print("<td>"+p.getQuantidade()+"</td>");
                                			out.print("<td>"+p.getNome()+"</td>");
                                			out.print("<td>"+p.getDescricao()+"</td>");
                                			out.print("<td><input onchange=\"totalProdutos("+p.getId()+")\" class=\"form-control\" placeholder=\"Valor\" onkeyup=\"somenteNumeros(this);\" type=\"text\" id="+p.getId()+" name="+p.getId()+" required></td>");
                                			out.print("</tr>");
                                			i++;
                                		}
                                	%>
                                </tbody>
                            </table>                            
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                    <div class="row">
                        <!-- accepted payments column -->
                        <div class="col-xs-6">
                        <strong>Termos<br> </strong>
                            <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
                                Ao efetuar o lance, deverá arcar com as reponsabilidades de atender ao pedido, oferencendo um produto conforme especificado, no prazo estimado e com o valor ofertado.
                            </p>
                        </div><!-- /.col -->
                        <div class="col-xs-6">
                            <p class="lead">Valor do lance</p>
                            <div class="table-responsive">   
                            <!-- <form action="fornecedorPedidoController.jsp?acao=pedido&id="">     -->                 
                                <table class="table" >
                                	<tr>
                                        <th>Taxa de entrega:</th>
                                        <td><input class="form-control" onkeyup="somenteNumeros(this);" onchange="calculaTotal()" placeholder="Valor da entrega" type="text" id="taxaentrega" name="taxaentrega" required></td>
                                    </tr>
                                    <tr>
                                        <th style="width:50%">Produtos:</th>
                                        <td><input id= "subtotal" class="form-control" value = 00.00 disabled></td>
                                    </tr>                                    
                                    <tr>
                                       <th style="width:50%">Total:</th>
                                        <td><input id="total" name="total" class="form-control" value = 00.00 readonly></td>
                                    </tr>
                                    <tr>
                                    
                                    </tr>
                                    <tr>	
                                    	<th>
                                    		<button type="reset" class="btn btn-warning btn-block" onclick="javascript:limpar();">Limpar</button>  
                                    	</th>
                                    	<td>
                                    	 <button class="btn btn-success pull-right btn-block" type="submit">Efetuar lance</button>  
                                    	</td>
                                    </tr>
                                </table>   
                                </div>
                                </div>
                                </div>                                          	 
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
    
    <script type="text/javascript">				
			var valorTotalProdutos = 0;	
			var taxaEntrega = 0;
			var total = 0;
			function calculaTotal(){	
				taxaEntrega = parseFloat(document.getElementById("taxaentrega").value);
				total= valorTotalProdutos + taxaEntrega;
    			document.getElementById("total").value = total;
    			//console.log(totalProdutos(id));
				//console.log(valorTotalProdutos);
			}
    		function totalProdutos(id){
    			valorTotalProdutos += parseFloat(document.getElementById(id).value);
    			document.getElementById("subtotal").value = valorTotalProdutos;  
    			if(taxaEntrega>0)
    				calculaTotal();
    		}
    		function limpar(){
    			valorTotalProdutos = 0;	
    			taxaEntrega = 0;
    			total = 0;
    		}
    		function somenteNumeros(num) {
    	        var er = /[^0-9.]/;
    	        er.lastIndex = 0;
    	        var campo = num;
    	        if (er.test(campo.value)) {
    	          campo.value = "";
    	        }
    	    }
		</script>
	</div>
</div>
</body>

</html>