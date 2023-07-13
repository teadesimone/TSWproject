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
     //boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
     
     String action = request.getParameter("action");
     ArrayList<JewelBean> result = null;
     
     
     if (action == null) {
         try {
			result = (ArrayList<JewelBean>)model.doRetrieveAll();
		}catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
     }
     else if(action.equals("suggest")){
         String keyword = request.getParameter("keyword");
         
         try {
             result = (ArrayList<JewelBean>)model.doRetrieveAllByName(keyword);
         }catch (SQLException e) {
             LOGGER.log( Level.SEVERE, e.toString(), e );
         }
     }
     else if(action.equals("searchByCategory")){
         
         String category = request.getParameter("category");

         try {
             result = (ArrayList<JewelBean>)model.doRetrieveAllByCategory(category);
         }catch (SQLException e) {
             LOGGER.log( Level.SEVERE, e.toString(), e );
         }
     }
     else if(action.equals("filter")){
         String sql ="";
         
         String keyword = request.getParameter("keyword");
         
         String prezzo = request.getParameter("prezzo");
         float prezzo_da = 0;
         float prezzo_a = 5000; 
         if (!request.getParameter("prezzo_da").equals(""))
             prezzo_da = Float.parseFloat(request.getParameter("prezzo_da"));
         if (!request.getParameter("prezzo_a").equals(""))
             prezzo_a = Float.parseFloat(request.getParameter("prezzo_a"));
         
             String materiale = request.getParameter("materiale");
             String argento = request.getParameter("argento");
             String oro = request.getParameter("oro");
             String ororosa = request.getParameter("ororosa");
         
             String categoria = request.getParameter("categoria");
             String collana = request.getParameter("collana");
             String bracciale = request.getParameter("bracciale");
             String anello = request.getParameter("anello");
             String orecchini = request.getParameter("orecchini");
        
             String pietra = request.getParameter("pietra");
             String giada = request.getParameter("giada");
             String ametista = request.getParameter("ametista");
             String smeraldo = request.getParameter("smeraldo");
             String acquamarina = request.getParameter("acquamarina");
             String rubino = request.getParameter("rubino");
             String quarzorosa = request.getParameter("quarzorosa");
             
             if (!pietra.equals("") || !materiale.equals("") || !categoria.equals("")){
                 sql = " AND (prezzo > "+ prezzo_da +" AND prezzo < "+ prezzo_a + ") AND (materiale = '"+ argento + "' OR materiale = '" + oro + "' OR materiale='" + ororosa ;
                 sql+= "' OR categoria = '"+collana+"' OR categoria = '"+bracciale+"' OR categoria ='"+anello+"' OR categoria ='"+orecchini;
                 sql+= "' OR pietra = '"+giada+"' OR pietra = '"+ametista+"' OR pietra = '"+smeraldo+"' OR pietra = '"+acquamarina+"' OR pietra = '"+rubino+"' OR pietra = '"+quarzorosa + "')";
                
             }
             else if (pietra.equals("") && materiale.equals("") && categoria.equals("")){
                  sql = " AND prezzo > "+ prezzo_da +" AND prezzo < "+ prezzo_a;
            }
         
            //System.out.println(sql);

             try {
                 result = model.doRetrieveAllByKeyword(keyword,sql);
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
