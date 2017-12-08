package br.com.SISLIC.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.PedidoDAO;
import br.com.SISLIC.model.Gerente;
import br.com.SISLIC.model.Pedido;

@WebServlet("/gerentepedidos.do")
public class GerentePedidosController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
			
			if(acao.equals("pedidosaberto")) {
				if(((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto() == null || ((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto().size() == 0) {
					PedidoDAO pedidoDAO = new PedidoDAO();
					ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosAberto();
					((Gerente) req.getSession().getAttribute("gerAutenticado")).setPedidosAberto(pedidos);
					//req.getSession().setAttribute("pedidosaberto", pedidos);
				}
				//PARA USAR A MESMA PÁGINA JSP NO VIEW
				String tipoPedido = "pedidosabertos";
				req.getSession().setAttribute("tipoPedido", tipoPedido);
				req.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(req, resp);
			
			}else {
				if(acao.equals("pedidospendentes")) {
					if(((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosPendentes()== null || ((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosPendentes().size() == 0) {
						PedidoDAO pedidoDAO = new PedidoDAO();
						ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosPendentes();
						((Gerente) req.getSession().getAttribute("gerAutenticado")).setPedidosPendentes(pedidos);
						//req.getSession().setAttribute("pedidosaberto", pedidos);
					}
					String tipoPedido = "pedidospendentes";
					req.getSession().setAttribute("tipoPedido", tipoPedido);
					req.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(req, resp);
				
				}else {
					if(acao.equals("pedidosfechados")) {
						if(((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosFechados() == null || ((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosFechados().size() == 0) {
							PedidoDAO pedidoDAO = new PedidoDAO();
							ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosFechados();
							((Gerente) req.getSession().getAttribute("gerAutenticado")).setPedidosFechados(pedidos);
							//req.getSession().setAttribute("pedidosaberto", pedidos);
						}
						String tipoPedido = "pedidosfechados";
						req.getSession().setAttribute("tipoPedido", tipoPedido);
						req.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(req, resp);
					}else {
						if(acao.equals("pedido")) {
							int id = Integer.parseInt(req.getParameter("id"));
							PedidoDAO pedidoDAO = new PedidoDAO();
							Pedido pedido = pedidoDAO.buscarPedidoSemRestrição(id);
							//Pedido pedido = pedidoDAO.buscarPedido(id);			
							req.getSession().setAttribute("pedido", pedido);
							req.getRequestDispatcher("WEB-INF/gerentePedido.jsp").forward(req, resp);
						}
						if(acao.equals("cancelar")) {
							int id = Integer.parseInt(req.getParameter("id"));
							PedidoDAO pedidoDAO = new PedidoDAO();
							if(pedidoDAO.cancelarPedidoElances(id)) {
								((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto().clear();
								((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosPendentes().clear();		
								resp.getWriter().print("<script> window.alert('Pedido cancelado com sucesso!'); location.href='gerentepedidos.do?acao=pedidosaberto';</script>");
							}
						}else {
							if(acao.equals("autorizar")) {
								int id = Integer.parseInt(req.getParameter("id"));
								PedidoDAO pedidoDAO = new PedidoDAO();
								if(pedidoDAO.autorizarPedido(id)) {
									//SETAR COMO NULL PARA ELE ATUALIZAR COM ESTE NOVO AUTORIZADO
									((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto().clear();
									((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosPendentes().clear();									
									resp.getWriter().print("<script> window.alert('Pedido autorizado com sucesso!'); location.href='gerentepedidos.do?acao=pedidosaberto';</script>");
								}
							}
						}
					}
				}
			}
		}
		//req.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto()== null || ((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto().size() == 0) {
			PedidoDAO pedidoDAO = new PedidoDAO();
			ArrayList<Pedido> pedidos = pedidoDAO.buscarTodosPedidosAberto();
			((Gerente) req.getSession().getAttribute("gerAutenticado")).setPedidosAberto(pedidos);
			//req.getSession().setAttribute("pedidosaberto", pedidos);
		}
		//PARA USAR A MESMA PÁGINA JSP NO VIEW
		String tipoPedido = "pedidosabertos";
		req.getSession().setAttribute("tipoPedido", tipoPedido);
		req.getRequestDispatcher("WEB-INF/gerentePedidos.jsp").forward(req, resp);
	}
}
