package br.com.SISLIC.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.LanceDAO;
import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.ItemPedido;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;

@WebServlet("/lancescontroller.do")
public class LanceController extends HttpServlet{
	

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {			
		
			req.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(req, resp);
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String acao = new String();
		
		if(req.getParameter("acao")!=null) {
			acao = req.getParameter("acao");
			
		}else {
			req.getRequestDispatcher("WEB-INF/fornLances.jsp").forward(req, resp);
		}
		
		if(acao.equals("efetuarlance")) {
			
			Pedido pedido = (Pedido) req.getSession().getAttribute("pedido");
			
			//PEGAR OS PREÇOS DE CADA PRODUTO
			for(Produto p: pedido.getProdutos()) {
				p.setPreco(Float.parseFloat(req.getParameter(Integer.toString(p.getId()))));
			}
			Lance lance = new Lance();
			
			Date data = new Date();
			SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");
			String novaData = formatador.format(data);
			lance.setData(novaData);
			lance.setTotal(Float.parseFloat(req.getParameter("total")));
			lance.setTaxaEntrega(Float.parseFloat(req.getParameter("taxaentrega")));
			
			Fornecedor forn = (Fornecedor) req.getSession().getAttribute("forAutenticado");
			lance.setIdfornecedor(forn.getId());
			
			ItemPedido itemPedido = new ItemPedido();
			itemPedido.setPedido(pedido);
			
			LanceDAO lanceDAO = new LanceDAO();
			//REVER A PARTE DO DAO NO LANCE
			if(lanceDAO.cadastrar(lance)) {					
				resp.getWriter().print("<script> window.alert('Lance efetuado com sucesso! Aguarde o contato por e-mail'); location.href='cadastrocontroller.do';</script>");
			}else {
				resp.getWriter().print("<script> window.alert('Erro ao efetuar o lance!'); location.href='cadastrocontroller.do';</script>");
			}
		}
	}
}
