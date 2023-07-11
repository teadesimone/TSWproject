package it.unisa.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.gson.*;

import it.unisa.model.*;

public class CatalogServlet extends HttpServlet {
	
	private static final Logger LOGGER = Logger.getLogger( CatalogServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        
     JewelDAO model = new JewelDAO();
     boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
     
     String action = request.getParameter("action");
     String query = request.getParameter("query");
     System.out.println("Test query: "+query);
     ArrayList<JewelBean> result = null;
     
     
     if (action == null) {
         try {
			result = (ArrayList<JewelBean>)model.doRetrieveAll();
		}catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
     } else if (action.equals("search")) {
         try {
			result = model.doRetrieveAllByKeyword(query);
		}catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
     }
        
     Gson gson = new Gson();
     String json = gson.toJson(result);

     response.setContentType("application/json");
     PrintWriter out = response.getWriter();
     out.write(json);
    

     /*
     if (action != null && action.equalsIgnoreCase("search")){
         System.out.println("Test: ");
         String query = request.getParameter("query");
         ArrayList<JewelBean> result = null;
         
         try {
             result = model.doRetrieveAllByKeyword(query);
			//request.setAttribute("products", model.doRetrieveAllByKeyword(query));
		}catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
         
         Gson gson = new Gson();
         String json = gson.toJson(result);

         response.setContentType("application/json");
         PrintWriter out = response.getWriter();
         out.write(json); 
         System.out.println("Test: "+json);
     }
        
        if(action == null && !ajax){
            request.removeAttribute("products");
            
            try {
                request.setAttribute("products", model.doRetrieveAll());
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }

            
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/catalog.jsp");
            dispatcher.forward(request, response);

        }*/
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }

}
