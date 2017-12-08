package br.com.SISLIC.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.SISLIC.DAO.CategoriaDAO;
import br.com.SISLIC.DAO.PedidoDAO;
import br.com.SISLIC.model.Categoria;
import br.com.SISLIC.model.Pedido;
import br.com.SISLIC.model.Produto;
import br.com.SISLIC.model.Gerente;
import br.com.SISLIC.model.Funcionario;

@WebServlet("/cadastropedido.do")
public class CadastroPedidoController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getSession().getAttribute("categoria")==null) {
			CategoriaDAO catDAO = new CategoriaDAO();
			req.getSession().setAttribute("categorias", catDAO.buscarTodasEForn());
		}
		req.getRequestDispatcher("WEB-INF/cadastroPedido.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("acao")!=null) {
			String acao = req.getParameter("acao");
		
			if(acao.equals("cadastrarPedido")) {
				//DADOS GERAIS DO PEDIDO
				Pedido pedido = new Pedido();
				pedido.setNome((String) req.getAttribute("nomePedido"));
				pedido.setDescricao((String) req.getAttribute("descricaoPedido"));
				pedido.setDataLimite((Date) req.getAttribute("dataLimite"));
				System.out.println("NOME DO PEDIDO"+pedido.getNome());
				System.out.println("DESCRICAO DO PEDIDO"+pedido.getDescricao());
				//PEGAR DATA ATUAL
				java.util.Date dataUtil = new java.util.Date();
				java.sql.Date dataSql = new java.sql.Date(dataUtil.getTime());
				pedido.setDataLancamento(dataSql);
				
				//PEGAR CATEGORIA
				String nomeCategoria = (String) req.getAttribute("categoria");
				CategoriaDAO catDAO = new CategoriaDAO();
				Categoria categoria = catDAO.buscaPeloNome(nomeCategoria);
				
				//PRODUTOS
				int quantProdutos = (int) req.getAttribute("totalProdutos");
				ArrayList<Produto> produtos = new ArrayList<Produto>();
				
				for(int i=1; i<=quantProdutos; i++) {
					Produto produto = new Produto();
					produto.setQuantidade((int) req.getAttribute("quant"+i));
					produto.setNome((String) req.getAttribute("nome"+i));
					produto.setDescricao((String) req.getAttribute("descricaoProduto"+i));
					produto.setCategoria(categoria);
					produtos.add(produto);
				}
				pedido.setProdutos(produtos);
				
				//VERIFICO SE É GERENTE OU FUNCIONARIO E AUTORIZO
				if(req.getSession().getAttribute("gerAutenticado")!=null){
					pedido.setAutorizado(true);
					pedido.setId_funcionario(((Gerente) req.getSession().getAttribute("gerAutenticado")).getCodFunc());
					pedido.setIdSetor(((Gerente) req.getSession().getAttribute("gerAutenticado")).getSetor().getId());
				}else {
					pedido.setAutorizado(false);
					pedido.setId_funcionario(((Funcionario) req.getSession().getAttribute("funAutenticado")).getCodFunc());
					pedido.setIdSetor(((Funcionario) req.getSession().getAttribute("funAutenticado")).getSetor().getId());
				}
				
				//CADASTRAR NO BANCO
				PedidoDAO pedidoDAO = new PedidoDAO();
				if(pedidoDAO.cadastrarPedidoProdutoItensPedido(pedido)) {
					((Gerente) req.getSession().getAttribute("gerAutenticado")).getPedidosAberto().clear();
					resp.getWriter().print("<script> window.alert('Pedido cadastrado com sucesso!'); location.href='gerentepedidos.do';</script>");					
				}
			}
		}	
	}
}
