<%@ page import="br.com.SISLIC.DAO.LanceDAO"%>
<%@ page import="br.com.SISLIC.model.Lance"%>
<%@ page import="br.com.SISLIC.model.Fornecedor"%>
<%@ page import="br.com.SISLIC.model.Pedido"%>
<%@ page import="br.com.SISLIC.model.Produto"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 

	if(request.getMethod().equals("GET")){
		
		LanceDAO lanceDAO = new LanceDAO();
		if(request.getParameter("acao")!=null) {
			String acao = request.getParameter("acao");
			//PARA ATUALIZAR QUANDO ELE EFETUAR UMA NOVO
			if(acao.equals("lances")) {//PEGO TODOS OS LANCES
				//SETAR OS LANCES DO FORNECEDOR PARA SEREM MOSTRADOS NA PÁGINA				
				Fornecedor forn = (Fornecedor) request.getSession().getAttribute("forAutenticado");				
				request.getSession().setAttribute("lances", lanceDAO.lancesFornId(forn.getId()));
				request.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(request, response);
			}
			if(acao.equals("lance")) {//PEGO UM LANCE
				int idLance = Integer.parseInt(request.getParameter("id"));
				Lance lance = lanceDAO.buscarPorId(idLance);
				request.setAttribute("lance", lance);
				request.getRequestDispatcher("WEB-INF/lance.jsp").forward(request, response);
			}
			if(acao.equals("cancelarLance")) {
				int idLance = Integer.parseInt(request.getParameter("id"));
				if(lanceDAO.deleteLance(idLance)) {
					response.getWriter().print("<script> window.alert('Lance cancelado com sucesso!'); location.href='fornecedorLanceController.jsp?acao=lances';</script>");
				}else {
					response.getWriter().print("<script> window.alert('Erro interno ao cancelar o pedido, tente novamente'); location.href='fornecedorLanceController.jsp' </script>");
				}
			}
		}else{
			//CASO OS LANCES AINDA NÃO TENHA SIDO SETADO NA SESSAO
			if(request.getSession().getAttribute("lances")==null) {
				//SETAR OS LANCES DO FORNECEDOR PARA SEREM MOSTRADOS NA PÁGINA				
				Fornecedor forn = (Fornecedor) request.getSession().getAttribute("forAutenticado");
				request.getSession().setAttribute("lances", lanceDAO.lancesFornId(forn.getId()));
				request.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(request, response);
			}else {
			//CASO JÁ TENHA OS LANCES
			request.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(request, response);
			}
		}
	}else{//MÉTODO POST
		
		String acao = new String();
		
		if(request.getParameter("acao")!=null) {
			acao = request.getParameter("acao");			
		}		
		
		if(acao.equals("efetuarlance")) {			
			Pedido pedido = (Pedido) request.getSession().getAttribute("pedido");
			
			//PEGAR OS PREÇOS DE CADA PRODUTO
			for(Produto p: pedido.getProdutos()) {
				p.setPreco(Float.parseFloat(request.getParameter(Integer.toString(p.getId()))));
			}
			Lance lance = new Lance();			
			
			//CONVERTER A DATA
			java.util.Date dataUtil = new java.util.Date();
			java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
			
			lance.setData(dataSql);
			
			lance.setValorTotal(Float.parseFloat(request.getParameter("total")));
			lance.setTaxaEntrega(Float.parseFloat(request.getParameter("taxaentrega")));			
			lance.setForn((Fornecedor) request.getSession().getAttribute("forAutenticado"));
			
			lance.setPedido(pedido);
			
			LanceDAO lanceDAO = new LanceDAO();

			if(lanceDAO.cadastrar(lance)) {					
				response.getWriter().print("<script> window.alert('Lance efetuado com sucesso! Aguarde o contato por e-mail'); location.href='fornecedorLanceController.jsp?acao=lances';</script>");
			}else {
				response.getWriter().print("<script> window.alert('Erro ao efetuar o lance!'); location.href='fornecedorLanceController.jsp';</script>");
			}
		}
	}


%>