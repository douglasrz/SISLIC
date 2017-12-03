package br.com.SISLIC.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.LanceDAO;
import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;

@WebServlet("/lancescontroller.do")
public class LanceController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {			
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
			//PARA ATUALIZAR QUANDO ELE EFETUAR UMA NOVO
			if(acao.equals("lances")) {//PEGO TODOS OS LANCES
				//SETAR OS LANCES DO FORNECEDOR PARA SEREM MOSTRADOS NA PÁGINA				
				Fornecedor forn = (Fornecedor) req.getSession().getAttribute("forAutenticado");
				LanceDAO lanceDAO = new LanceDAO();
				req.getSession().setAttribute("lances", lanceDAO.lancesFornId(forn.getId()));
				req.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(req, resp);
			}
			if(acao.equals("lance")) {//PEGO UM LANCE
				int idLance = Integer.parseInt(req.getParameter("id"));
				LanceDAO lanceDAO = new LanceDAO();
				Lance lance = lanceDAO.buscarPorId(idLance);
				req.setAttribute("lance", lance);
				req.getRequestDispatcher("WEB-INF/lance.jsp").forward(req, resp);
			}
			if(acao.equals("cancelarLance")) {
				int idLance = Integer.parseInt(req.getParameter("id"));
				LanceDAO lanceDAO = new LanceDAO();
				if(lanceDAO.deleteLance(idLance)) {
					resp.getWriter().print("<script> window.alert('Lance cancelado com sucesso!'); location.href='lancescontroller.do?acao=lances';</script>");
				}else {
					resp.getWriter().print("<script> window.alert('Erro interno ao cancelar o pedido, tente novamente'); location.href='lancescontroller.do' </script>");
				}
			}
		}else{
			//CASO OS LANCES AINDA NÃO TENHA SIDO SETADO NA SESSAO
			if(req.getSession().getAttribute("lances")==null) {
				//SETAR OS LANCES DO FORNECEDOR PARA SEREM MOSTRADOS NA PÁGINA				
				Fornecedor forn = (Fornecedor) req.getSession().getAttribute("forAutenticado");
				LanceDAO lanceDAO = new LanceDAO();				
				req.getSession().setAttribute("lances", lanceDAO.lancesFornId(forn.getId()));
				req.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(req, resp);
			}else {
			//CASO JÁ TENHA OS LANCES
			req.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(req, resp);
			}
		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String acao = new String();
		
		if(req.getParameter("acao")!=null) {
			acao = req.getParameter("acao");			
		}		
		
		if(acao.equals("efetuarlance")) {			
			Pedido pedido = (Pedido) req.getSession().getAttribute("pedido");
			
			//PEGAR OS PREÇOS DE CADA PRODUTO
			for(Produto p: pedido.getProdutos()) {
				p.setPreco(Float.parseFloat(req.getParameter(Integer.toString(p.getId()))));
			}
			Lance lance = new Lance();			
			
			//CONVERTER A DATA
			java.util.Date dataUtil = new java.util.Date();
			java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
			
			lance.setData(dataSql);
			
			lance.setValorTotal(Float.parseFloat(req.getParameter("total")));
			lance.setTaxaEntrega(Float.parseFloat(req.getParameter("taxaentrega")));			
			lance.setForn((Fornecedor) req.getSession().getAttribute("forAutenticado"));
			
			lance.setPedido(pedido);
			
			LanceDAO lanceDAO = new LanceDAO();

			if(lanceDAO.cadastrar(lance)) {					
				resp.getWriter().print("<script> window.alert('Lance efetuado com sucesso! Aguarde o contato por e-mail'); location.href='lancescontroller.do?acao=lances';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Erro ao efetuar o lance!'); location.href='lancescontroller.do';</script>");
			}
		}
	}
}
