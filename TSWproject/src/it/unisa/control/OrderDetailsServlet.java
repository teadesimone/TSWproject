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

public class OrderDetailsServlet extends HttpServlet{
    
    static OrderDAO orderModel = new OrderDAO(); 
    static OrderProductDAO orderProdModel = new OrderProductDAO(); 
    static JewelDAO jewelModel = new JewelDAO();
    private static final Logger LOGGER = Logger.getLogger(CartServlet.class.getName() );
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        
        int id = Integer.parseInt(request.getParameter("ordine"));
        
        OrderBean order = new OrderBean();
        
        try {
			order = orderModel.doRetrieveByKey(id);
		} catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
        
        request.setAttribute("detailedOrder", order);
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/orderdetails.jsp");
        dispatcher.forward(request, response);
        
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
}