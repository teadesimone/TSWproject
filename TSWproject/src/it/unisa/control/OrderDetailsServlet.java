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
    static InvoiceDAO invoiceModel = new InvoiceDAO();
    
    private static final Logger LOGGER = Logger.getLogger(CartServlet.class.getName() );
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        if (client == null){
            response.sendRedirect("login");
            return;
        } 
        String action = request.getParameter("action");
        
        
        if(action==null){
            int id = Integer.parseInt(request.getParameter("ordine"));

            OrderBean order = new OrderBean();
            
            try {
                order = orderModel.doRetrieveByKey(id);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }
            
            if(order.getClient().getUsername().equalsIgnoreCase(client.getUsername()) || client.getEmail().equals("JadeTear@gmail.com")){
                request.setAttribute("detailedOrder", order);    
            }else{
                response.sendRedirect("home");
            }
        }
        if(action!=null && action.equalsIgnoreCase("viewInvoice")){
            
            int idordine = Integer.parseInt(request.getParameter("idOrder"));
            InvoiceBean invoice = new InvoiceBean();
            
            ArrayList<OrderProductBean> products = null;
			try {
				products = orderProdModel.doRetrieveByKey(idordine);
			} catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }
            
            ArrayList<JewelBean> jewels = new ArrayList<JewelBean>();
            for(OrderProductBean prodotto : products){
                JewelBean jewel = null;
				try {
					jewel = jewelModel.doRetrieveByKey(prodotto.getId_prodotto());
				} catch (SQLException e) {
	                LOGGER.log( Level.SEVERE, e.toString(), e );
	            }
                jewels.add(jewel);
            }
            
            try {
                invoice = invoiceModel.doRetrieveByOrder(idordine);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }
            
            request.setAttribute("jewels", jewels);
            request.setAttribute("orderProducts", products);
            request.setAttribute("invoice", invoice);
            
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/invoice.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/orderdetails.jsp");
        dispatcher.forward(request, response);
        return;
        
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
}