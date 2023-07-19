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
        if(action!=null && action.equalsIgnoreCase("logout")){ // azione di logout
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("home");
            return;
        }
        
        if (action == null || action.equals("") ){
            
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/login.jsp");
            dispatcher.forward(request, response);
            return;
        }else if(action.equals("login")){

            ClientBean client = null;
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                client = model.doRetrieveByEmailAndPassword(email, password);
            } catch (SQLException e) {

                LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("loginError.jsp");	
                return;
            }  

            if(client == null){ // se si inseriscono le credenziali sbagliate, si viene rediretti alla login error 

                response.sendRedirect("loginError.jsp");	
                return;
            }
            else {
                request.getSession().setAttribute("utente", client); // set dell'attributo utente nella sessione 
    
                if (client.getEmail().equals("JadeTear@gmail.com")) {
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin");
                    dispatcher.forward(request, response);
                    return;
                }
    
            }

            response.sendRedirect("home");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }  
}
