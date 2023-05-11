package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;

public class RegistrationServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegistrationServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    
        ClientDAO model = new ClientDAO();
        ClientBean client = new ClientBean();
        int result = 0;
        
        client.setUsername(request.getParameter("username"));
        client.setCf(request.getParameter("cf"));
        client.setNome(request.getParameter("nome"));
        client.setCognome(request.getParameter("cognome"));
        client.setVia(request.getParameter("indirizzo"));
        client.setCitta(request.getParameter("citta"));
        client.setProvincia(request.getParameter("provincia"));
        client.setCap(request.getParameter("cap"));
        client.setTelefono(request.getParameter("telefono"));
        client.setEmail(request.getParameter("email"));
        client.setPassword(request.getParameter("password"));
        
        try {
			result = model.doSave(client);
		} catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
        
        if(result == 0){
            response.sendRedirect("loginError.jsp");
        }
        else{
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        }
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }  
}
