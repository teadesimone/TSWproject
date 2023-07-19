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
        
        //se l'azione è null, viene preso dalla request l'id dell'ordine cercato per vederne i dettagli
        if(action==null){
            int id = Integer.parseInt(request.getParameter("ordine"));

            OrderBean order = new OrderBean();
            
            try {
                order = orderModel.doRetrieveByKey(id);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("generalError.jsp");
                return;
            }
            //se si è loggati oppure si è l'admin, l'ordine viene settato coem attributo nella request
            if(order.getClient().getUsername().equalsIgnoreCase(client.getUsername()) || client.getEmail().equals("JadeTear@gmail.com")){
                request.setAttribute("detailedOrder", order);    
            }else{ //utente non loggato e non admin che tenta di accedere ai dettaglio di un ordine
                response.sendRedirect("home");
            }
        }//azione per mostrare la fattura
        if(action!=null && action.equalsIgnoreCase("viewInvoice")){
            
            int idordine = Integer.parseInt(request.getParameter("idOrder"));
            InvoiceBean invoice = null;
            
            ArrayList<OrderProductBean> products = null; // dati necessari alla creazione della fattura
			try {
				products = orderProdModel.doRetrieveByKey(idordine);
			} catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("generalError.jsp");
                return;
            }
            
            ArrayList<JewelBean> jewels = new ArrayList<JewelBean>(); // dati necessari alla creazione della fattura
            for(OrderProductBean prodotto : products){
                JewelBean jewel = null;
				try {
					jewel = jewelModel.doRetrieveByKey(prodotto.getId_prodotto());
				} catch (SQLException e) {
	                LOGGER.log( Level.SEVERE, e.toString(), e );
                    response.sendRedirect("generalError.jsp");
                    return;
	            }
                jewels.add(jewel);
            }
            
            try {
                invoice = invoiceModel.doRetrieveByOrder(idordine); // dati necessari alla creazione della fattura
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("generalError.jsp");
                return;
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