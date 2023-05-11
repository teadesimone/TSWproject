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

public class CartServlet extends HttpServlet {
	
	private static final Logger LOGGER = Logger.getLogger( CartServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Cart cart = (Cart)request.getSession().getAttribute("cart");
        if(cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }

        JewelDAO model = new JewelDAO();

        String id = request.getParameter("id");

        String action = request.getParameter("action");
        if(action == null)
        	action = "seeCart"; 

        JewelBean jewel = new JewelBean();
        
		try {
			jewel = model.doRetrieveByKey(Integer.parseInt(id));
		} catch (NumberFormatException e) {
			 LOGGER.log( Level.SEVERE, e.toString(), e );
		} catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
         

        if (action.equals("add"))
            cart.addProduct(jewel);

        if (action.equals("Delete from Cart"))
            cart.removeProduct(jewel);

        if (action.equals("Modify Amount"))
            cart.changeQuantity(jewel, Integer.parseInt(request.getParameter("quantity")));

        request.getSession().setAttribute("cart", cart);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cart.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
