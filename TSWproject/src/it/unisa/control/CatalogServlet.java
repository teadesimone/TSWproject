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

public class CatalogServlet extends HttpServlet {
	
	private static final Logger LOGGER = Logger.getLogger( CatalogServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
     JewelDAO model = new JewelDAO();
        
     request.removeAttribute("products");
     
     try {
		request.setAttribute("products", model.doRetrieveAll());
	} catch (SQLException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	}
        
     RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/catalog.jsp");
     dispatcher.forward(request, response);
     
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }

}
