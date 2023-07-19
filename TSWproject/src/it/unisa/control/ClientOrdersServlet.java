package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;

public class ClientOrdersServlet extends HttpServlet{
    
    static OrderDAO orderModel = new OrderDAO();
    private static final Logger LOGGER = Logger.getLogger( CartServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
    	if (client == null){
            response.sendRedirect("login");
            return;
        } 
        
        else if (!client.getEmail().equals("JadeTear@gmail.com")){
            //cliente generico
            String username = client.getUsername();
            try {
				orders = orderModel.doRetrieveByClient(username);
			} catch (SQLException e) {
				LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("generalError.jsp");
                return;
			}
            
        }else if (client.getEmail().equals("JadeTear@gmail.com")){
            //admin
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin?action=ordersNoFilter"); //fa il dispatch alla servlet che gestisce tutto ciò che riguarda le operaioni da admin
            dispatcher.forward(request, response);
            return;
        }
 
        request.setAttribute("ordini", orders);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}