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

@WebServlet("/pedidocontroller.do")
public class PedidoController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String acao = req.getParameter("acao");
		
		if(acao.equals("pedido")) {
			req.getRequestDispatcher("WEB-INF/pedido.jsp").forward(req, resp);
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
