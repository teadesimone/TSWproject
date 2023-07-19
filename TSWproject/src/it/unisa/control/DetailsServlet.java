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

public class DetailsServlet extends HttpServlet {
	
	private static final Logger LOGGER = Logger.getLogger(DetailsServlet.class.getName() );
	
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
      
      JewelDAO model = new JewelDAO();

      String id = request.getParameter("id");
      if (id == null || Integer.parseInt(id)==0){
          response.sendRedirect("catalog");
          return;
      } 
      
      JewelBean j = new JewelBean();
      
      try {
		j = model.doRetrieveByKey(Integer.parseInt(id));
	} catch (NumberFormatException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	} catch (SQLException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	}
      
      if (j.getDisponibilita() <= 0) {
    	  
    	  request.setAttribute("erroresoldout2", "We are sorry but this jewel's sold out");
      }
      
      request.setAttribute("detailed", j);
      
      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/details.jsp");
      dispatcher.forward(request, response);
  }
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
      doGet(request, response);
  }  
}
