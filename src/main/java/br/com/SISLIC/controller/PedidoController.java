package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.LanceDAO;
import br.com.SISLIC.DAO.PedidoDAO;
import br.com.SISLIC.model.Fornecedor;
import br.com.SISLIC.model.Lance;
import br.com.SISLIC.model.Pedido;

@WebServlet("/pedidocontroller.do")
public class PedidoController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
		
		if(acao.equals("pedido")) {
			int id = Integer.parseInt(req.getParameter("id"));
			PedidoDAO pedidoDAO = new PedidoDAO();
			Pedido pedido = pedidoDAO.buscarPedido(id);			
			req.getSession().setAttribute("pedido", pedido);
			req.getRequestDispatcher("WEB-INF/pedido.jsp").forward(req, resp);
			
		}else {
			if(acao.equals("lance")) {
				int id = Integer.parseInt(req.getParameter("id"));
				int idPedido = Integer.parseInt(req.getParameter("id"));
				Lance lance = new Lance();
				lance.setIdPedido(idPedido);
				float total = Float.parseFloat(req.getParameter("total"));
				lance.setTotal(total);
				Date data = new Date();
				lance.setData(data);
				Fornecedor forn = (Fornecedor) req.getSession().getAttribute("forAutenticado");
				lance.setIdfornecedor(forn.getId());
				LanceDAO lanceDAO = new LanceDAO();
				if(lanceDAO.cadastrar(lance)) {					
					resp.getWriter().print("<script> window.alert('Lance efetuado com sucesso! Aguarde o contato por e-mail'); location.href='cadastrocontroller.do';</script>");
				}else {
					resp.getWriter().print("<script> window.alert('Erro ao efetuar o lance!'); location.href='cadastrocontroller.do';</script>");
					}
				}	
			}
		}else {
				PedidoDAO pedidoDAO = new PedidoDAO();
				ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidos();
				//FornecedorDAO
				req.getSession().setAttribute("pedidos", pedidos);
				req.getRequestDispatcher("WEB-INF/fornPedidos.jsp").forward(req, resp);
				}		
			}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
			PedidoDAO pedidoDAO = new PedidoDAO();
			ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidos();
			//FornecedorDAO
			req.getSession().setAttribute("pedidos", pedidos);
			req.getRequestDispatcher("WEB-INF/fornPedidos.jsp").forward(req, resp);
	}
	
}
