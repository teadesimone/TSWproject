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
        
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        String action = request.getParameter("action");
        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
        
        if (client == null){
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        } 
        else if (!client.getEmail().equals("JadeTear@gmail.com")){
            //cliente generico
            String username = client.getUsername();
            try {
				orders = orderModel.doRetrieveByClient(username);
			} catch (SQLException e) {
				LOGGER.log( Level.SEVERE, e.toString(), e );
			}
            
        }
        else {
            //admin
            if(action == null){
                
                action = "nofilter";
                try {
					orders = orderModel.doRetrieveAll();
				} catch (SQLException e) {
					LOGGER.log( Level.SEVERE, e.toString(), e );
				}
                
            }
            
            if (Boolean.parseBoolean(request.getParameter("Order By Client"))== true){

                String user = request.getParameter("cliente");
                
                try {
                    orders = orderModel.doRetrieveByClient(user);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                
            }
            if(Boolean.parseBoolean(request.getParameter("Order By Date"))== true){
                
                String data_da = (String) request.getParameter("data_da");
                String data_a = (String) request.getParameter("data_a");
                if (data_da.compareTo(data_a)< 0){

                    try {
						orders = orderModel.DateOrders(data_da,data_a);
					} catch (SQLException e) {
						LOGGER.log( Level.SEVERE, e.toString(), e );
					}
                }
                /*else {
                    
                    // pagina di errore
                }*/
            }
            if ((Boolean.parseBoolean(request.getParameter("Order By Date"))== true) && (Boolean.parseBoolean(request.getParameter("Order By Client"))== true)){
                
                String user = request.getParameter("cliente");
                String data_da = (String) request.getParameter("data_da");
                String data_a = (String) request.getParameter("data_a");
                try {
                    orders = orderModel.ClientDateOrders(user,data_da,data_a);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
            }
           
            
        }
        
        
        request.setAttribute("ordini", orders);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientorders.jsp");
        dispatcher.forward(request, response);
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}