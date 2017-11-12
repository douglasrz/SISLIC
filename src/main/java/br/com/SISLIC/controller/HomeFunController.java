package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.PedidoDAO;
import br.com.SISLIC.model.Funcionario;
import br.com.SISLIC.model.Pedido;

@WebServlet("/homefuncontroller.do")
public class HomeFunController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
			if(acao.equals("pedidosPendentes")) {
				PedidoDAO pedidoDAO = new PedidoDAO();
				Funcionario fun = (Funcionario) req.getSession().getAttribute("funAutenticado");
				ArrayList<Pedido> pedidosPendentes = pedidoDAO.buscarPedentesSetor(fun.getSetor().getId());
				
				req.getSession().setAttribute("pedidosPendentes", pedidosPendentes);
				req.getRequestDispatcher("WEB-INF/funPedidosPendentes.jsp").forward(req, resp);
			}
		}else
			req.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		req.getRequestDispatcher("WEB-INF/funPedidos.jsp").forward(req, resp);
	}
	
}
