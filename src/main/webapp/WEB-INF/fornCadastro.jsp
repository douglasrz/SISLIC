<%@ page import="br.com.SISLIC.model.Fornecedor" %>
<%@ page import="br.com.SISLIC.model.Categoria" %>
<%@ page import="java.util.ArrayList"%>
<%@	page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>SISLIC - CADASTRO</title>
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
	<script type="text/javascript">
			function confirmaExclusao(id){
				if(window.confirm("Tem certeza que deseja excluir?")){
					location.href="categoriacontroller.do?acao=excluir&id="+id;
				}
			}
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
                <a class="navbar-brand" href="pedidocontroller.do">SISLIC - Sistema de Compras e Licitações</a>
            </div>            
                <!-- Ã­cone do Usuario (cabeÃ§alho)-->
                <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                	<% Fornecedor forn = ((Fornecedor) request.getSession().getAttribute("forAutenticado")); 
                	ArrayList<Categoria> categorias = forn.getCategorias();
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
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Cadastro</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Editar cadastro
                        </div>
                        <div class="panel-body">
                            <div class="row">
                            	<form name="formulario" action="cadastrocontroller.do?acao=alterar" method="post">                            		
                                	<div class="col-lg-6">                                    
                                    	<div class="form-group">
                                                <label for="disabledSelect">Username</label>
                                                <input class="form-control" id="disabledInput" type="text" value="<%=forn.getLogin()%>" disabled>
                                        </div>                                        
                                        <div class="form-group">
                                            <label>Razão Social</label>
                                            <input class="form-control" value="<%=forn.getrSocial()%>" name="razaoSocial" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Senha</label>
                                            <input class="form-control" placeholder="Nova senha" type="password" name="novasenha" required>
                                        </div> 
                                        <div class="form-group">
                                            <input class="form-control" placeholder="Digite a nova senha novamente" type="password" name="novasenhaAlt" required>
                                        </div>
                                    </div>
                                     <div class="col-lg-6">
                                    	<div class="form-group">
                                            <label for="disabledSelect">CNPJ</label>
                                            <input class="form-control" id="disabledInput" type="text" value="<%=forn.getCnpj()%>" name="cnpj" disabled>
                                        </div>
	                                   	<div class="form-group">
	                                	    <label>Telefone</label>
	                                        <input class="form-control" value="<%=forn.getTelefone()%>" name="telefone" required>
	                                    </div>
                                        <div class="form-group">
                                           	<label>E-mail</label>
                                           	<input class="form-control" value="<%=forn.getEmail()%>" name="email" required>
                                        </div>                            
                                         <button type="submit" class="btn btn-success" onclick="return validarSenha()" >Enviar</button>            
                                    	<button type="reset" class="btn btn-warning ">Limpar</button>                                                                             
                                     </div>                                                                          
                                </form>
                             </div>
                           </div>     
                         </div>
                 <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">                        
               			<div class="panel-heading">Categorias</div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th width="20%">Categoria</th>
                                        <th>Descrição</th>                                   
                                        <th width="10%">Ação</th>
                                    </tr>
                                </thead>
                                <tbody>
	                                <% for(Categoria cat: categorias){
								 		out.print("<tr>");
								 		out.print("<td>"+cat.getNome()+"</td>");
								 		out.print("<td>"+cat.getDescricao()+"</td>");
								 		out.print("<td><a type=button href=\"javascript:confirmaExclusao("+cat.getCod()+")\">Excluir</a></td>");
								 		//out.print("<td><a href=\"categoriacontroller.do?acao=excluir&id="+cat.getCod()+"\">Excluir</a></td>");
								 		out.print("</tr>");
								 	}%>                                                                         
                                </tbody>
                            </table>
                            
                            <!-- CADASTRAR NOVA CATEGORIA -->
                            <button class="btn btn-success " data-toggle="modal" data-target="#myModal">Cadastar nova categoria</button>
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
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
        </div>
      </div>
	</div>
	</div>
	</div>
    <!-- jQuery -->
    <script src="sbAdmin/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="sbAdmin/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="sbAdmin/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="sbAdmin/dist/js/sb-admin-2.js"></script>-->

</body>

</html>
