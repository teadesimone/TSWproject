package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;

public class LoginServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName() );
    private static ClientDAO model = new ClientDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
    	String action = request.getParameter("action");
    	if(action!=null && action.equalsIgnoreCase("logout")){
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("home.jsp");
            return;
        }
        
        ClientBean client = null;
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
			client = model.doRetrieveByEmailAndPassword(email, password);
		} catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}  
        
        
        if(client == null){
        	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/loginError.jsp");
            dispatcher.forward(request, response);
            return;
        }
        else {
            request.getSession().setAttribute("utente", client);
            
            if (client.getEmail().equals("JadeTear@gmail.com")) {
            	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
                dispatcher.forward(request, response);
                return;
            }
            
        }  
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/home.jsp");
        dispatcher.forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }  
}
