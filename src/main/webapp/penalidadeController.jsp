<%@ page import="br.com.SISLIC.DAO.FornecedorDAO"%>
<%@ page import="br.com.SISLIC.DAO.PenalidadeDAO"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.model.Categoria"%>
<%@ page import="br.com.SISLIC.model.Produto"%>
<%@ page import="br.com.SISLIC.model.Funcionario"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){
	
	}else{
		//MÉTODO POST
		if(request.getParameter("acao")!=null) {
				int valor = Integer.parseInt((String) request.getParameter("valor"));
				String motivo = (String) request.getParameter("motivo");
				String descricao = (String) request.getParameter("descricao");
				String pedido = (String) request.getParameter("pedido");
				Fornecedor forn = ((Fornecedor) request.getSession().getAttribute("fornecedor"));
				//VERIFICAÇÃO POIS PODE SER UM GERENTE OU FUNCIONARIO
				Funcionario funcionario = new Funcionario();
				if((Funcionario) request.getSession().getAttribute("gerAutenticado")!=null){
					funcionario = (Funcionario) request.getSession().getAttribute("gerAutenticado");
				}else{
					funcionario = (Funcionario) request.getSession().getAttribute("funAutenticado");
				}
				PenalidadeDAO penalDAO = new PenalidadeDAO();
				FornecedorDAO fornDAO = new FornecedorDAO();
				if(request.getParameter("acao").equals("atribuirPenalidade")){
					if(penalDAO.atribuirNoLog(valor, motivo,descricao, forn.getId(), funcionario.getCodFunc(),pedido) && (fornDAO.atribuirPenalidade(valor, forn.getId()))){
						//PRECISO ATUALIZAR A PONTUAÇÃO DO FORNECEDOR
						request.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(forn.getId()));//SOBRESCREVENDO NO JÁ EXISTENTE
						response.getWriter().print("<script> window.alert('Penalidade atribuida com sucesso!'); location.href='gerenteFornecedoresController.jsp?acao=fornCadastrados&id="+forn.getId()+"'</script>");
					}else{
						response.getWriter().print("<script> window.alert('Erro, tente novamente mais tarde!'); location.href='gerenteFornecedoresController.jsp?acao=fornCadastrados&id="+forn.getId()+"'</script>");
					}
				}else{//REMOVER PENALIDADE
					if(penalDAO.atribuirNoLog(valor, motivo,descricao, forn.getId(), funcionario.getCodFunc(),pedido) && (fornDAO.removerPenalidade(valor, forn.getId()))){
						//PRECISO ATUALIZAR A PONTUAÇÃO DO FORNECEDOR
						request.getSession().setAttribute("fornecedor", fornDAO.buscarPorId(forn.getId()));
						response.getWriter().print("<script> window.alert('Penalidade foi subtraída com sucesso!'); location.href='gerenteFornecedoresController.jsp?acao=fornCadastrados&id="+forn.getId()+"'</script>");
					}else{
						response.getWriter().print("<script> window.alert('Erro, tente novamente mais tarde!'); location.href='gerenteFornecedoresController.jsp?acao=fornCadastrados&id="+forn.getId()+"'</script>");
					}
				
			}
		}
		}
%>