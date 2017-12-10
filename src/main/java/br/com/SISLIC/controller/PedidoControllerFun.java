package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import br.com.SISLIC.DAO.PedidoDAO;
import br.com.SISLIC.model.Pedido;

@WebServlet("/pedidocontrollerfun.do")
public class PedidoControllerFun extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
		
			if(acao.equals("pedido")) {
				int id = Integer.parseInt(req.getParameter("id"));
				PedidoDAO pedidoDAO = new PedidoDAO();
				Pedido pedido = pedidoDAO.buscarPedidoAberto(id);			
				req.getSession().setAttribute("pedido", pedido);
				req.getRequestDispatcher("WEB-INF/pedidoFun.jsp").forward(req, resp);
			}
		}else {
				if(req.getSession().getAttribute("pedidos")==null) {
					PedidoDAO pedidoDAO = new PedidoDAO();
					ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosAberto();
					//ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidos();
					//FornecedorDAO
					req.getSession().setAttribute("pedidos", pedidos);
					req.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(req, resp);
				}
				else {
					req.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(req, resp);
				}				
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//VERIFICO SE OS PEDIDOS JÁ FORAM SETADOS NA SESSAO, CASO POSITIVO NÃO PRECISO MAIS PEGAR NO BANCO, ASSIM A NAVEGAÇAO FICA MAIS RÁPIDA
		//QUANDO EU INSERIR UM NOVO AÍ QUE EU DEVO ATUALIZAR
		if(req.getSession().getAttribute("pedidos")==null) {
			PedidoDAO pedidoDAO = new PedidoDAO();
			ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosAberto();
			//FornecedorDAO
			req.getSession().setAttribute("pedidos", pedidos);
			req.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(req, resp);
		}else {
			req.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(req, resp);
		}
	}
	
}
