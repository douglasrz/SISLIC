package br.com.SISLIC.model;

import java.util.Random;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

import br.com.SISLIC.DAO.FornecedorDAO;

public class Email {


	public void Enviar(String login, String emailDestinatario) throws EmailException {
	    
		   SimpleEmail email = new SimpleEmail();
		   //Utilize o hostname do seu provedor de email
		   System.out.println("alterando hostname...");
		   email.setHostName("smtp.gmail.com");
		   //Quando a porta utilizada n�o � a padr�o (gmail = 465)
		   email.setSmtpPort(465);
		   //Adicione os destinat�rios
		   email.addTo(emailDestinatario, "SISLIC");
		   //Configure o seu email do qual enviar�
		   email.setFrom("sislicweb@gmail.com", "SISLIC");
		   //Adicione um assunto
		   email.setSubject("Solicita��o de nova senha");
		   //Adicione a mensagem do email
		   String novaSenha = gerarSenha(); 
		   email.setMsg("Seu login � "+login+"\nSua nova senha � "+novaSenha);
		   //Para autenticar no servidor � necess�rio chamar os dois m�todos abaixo
		   System.out.println("autenticando...");
		   //email.setSSL(true);
		   email.setAuthentication("sislicweb@gmail.com", "sislic123");
		   System.out.println("enviando...");
		   email.send();
		   System.out.println("Email enviado!");
		   FornecedorDAO forn = new FornecedorDAO();
		   forn.updateSenha(login, novaSenha);
		}
	private String gerarSenha() {
			char[] chart ={'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
			char[] senha= new char[8];
			int chartLenght = chart.length;
			Random rdm = new Random();
			for (int x=0; x<8; x++)
			senha[x] = chart[rdm.nextInt(chartLenght)];
			return new String(senha);
	}
}

