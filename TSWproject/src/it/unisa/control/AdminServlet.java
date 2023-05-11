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

public class AdminServlet extends HttpServlet {
	
	private static final Logger LOGGER = Logger.getLogger( AdminServlet.class.getName() );

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    JewelDAO model = new JewelDAO();

    String action = request.getParameter("action");
    
    if (action.equals("insert")) {
      JewelBean jewel = new JewelBean();
      jewel.setNome(request.getParameter("name"));
      jewel.setCategoria(request.getParameter("category"));
      jewel.setPietra(request.getParameter("gemstone"));
      jewel.setImmagine(request.getParameter("image"));
      jewel.setDisponibilita(Integer.parseInt(request.getParameter("availability")));
      jewel.setIVA(Float.parseFloat(request.getParameter("IVA")));
      jewel.setPrezzo(Float.parseFloat(request.getParameter("price")));
      jewel.setDescrizione(request.getParameter("description"));
      jewel.setMateriale(request.getParameter("material"));
      jewel.setSconto(Integer.parseInt(request.getParameter("discount")));
      
      if (request.getParameter("personalized") != null )
        jewel.setPersonalizzato(true);
      else
        jewel.setPersonalizzato(false);
      
      try {
		model.doSave(jewel);
	} catch (SQLException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	}
      
    }
    
    if (action.equals("load")) {
      JewelBean jewelToModify = new JewelBean();
      
	try {
		jewelToModify = model.doRetrieveByKey(Integer.parseInt(request.getParameter("id")));
	} catch (NumberFormatException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	} catch (SQLException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	}
	
      request.setAttribute("jewel",jewelToModify);
    }
    
    if (action.equals("modify")) {
      JewelBean jewel = new JewelBean();
      jewel.setId(Integer.parseInt(request.getParameter("idM")));
      jewel.setNome(request.getParameter("nameM"));
      jewel.setCategoria(request.getParameter("categoryM"));
      jewel.setPietra(request.getParameter("gemstoneM"));
      jewel.setImmagine(request.getParameter("imageM"));
      jewel.setDisponibilita(Integer.parseInt(request.getParameter("availabilityM")));
      jewel.setIVA(Float.parseFloat(request.getParameter("IVAM")));
      jewel.setPrezzo(Float.parseFloat(request.getParameter("priceM")));
      jewel.setDescrizione(request.getParameter("descriptionM"));
      jewel.setMateriale(request.getParameter("materialM"));
      jewel.setSconto(Integer.parseInt(request.getParameter("discountM")));
      
      if (request.getParameter("personalizedM") != null )
        jewel.setPersonalizzato(true);
      else
        jewel.setPersonalizzato(false);
      
      try {
		model.doModify(jewel);
	} catch (SQLException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	}
      
    }
    
    if (action.equals("delete")) {
      String id = request.getParameter("id");
      
      try {
		model.doDelete(Integer.parseInt(id));
	} catch (NumberFormatException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	} catch (SQLException e) {
		LOGGER.log( Level.SEVERE, e.toString(), e );
	}
      
    }

    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
    dispatcher.forward(request, response);

  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    doGet(request, response);
  }

}
