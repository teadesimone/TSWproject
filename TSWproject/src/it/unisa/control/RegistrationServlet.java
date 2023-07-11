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

import com.google.gson.Gson;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;

public class RegistrationServlet extends HttpServlet {
	
	  static AddressDAO addressmodel = new AddressDAO();
	  static ClientDAO model = new ClientDAO();
      static ClientDAO clientmodel = new ClientDAO();
      

    private static final Logger LOGGER = Logger.getLogger(RegistrationServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    
    	ClientBean client = new ClientBean();
        
        String action = request.getParameter("action");
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        if(action != null && ajax){
            boolean bol;
            ClientBean result = null;
            if (action.equalsIgnoreCase("check") ){
                try {
                    result = (ClientBean) clientmodel.doRetrieveByKey(request.getParameter("username"));
                }catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }

            }else  if (action.equalsIgnoreCase("checkemail")){
                try {
                    result = (ClientBean) clientmodel.doRetrieveByEmail(request.getParameter("email"));
                }catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
            }
            if (result != null) bol=true;
            else bol=false;

            Gson gson = new Gson();
            String json = gson.toJson(bol);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.write(json);
        }
        else{


            int result = 0;

            client.setUsername(request.getParameter("username"));
            client.setCf(request.getParameter("cf"));
            client.setNome(request.getParameter("nome"));
            client.setCognome(request.getParameter("cognome"));
            client.setVia(request.getParameter("indirizzo"));
            client.setCitta(request.getParameter("citta"));
            client.setProvincia(request.getParameter("provincia"));
            client.setCap(request.getParameter("cap"));
            client.setTelefono(request.getParameter("telefono"));
            client.setEmail(request.getParameter("email"));
            client.setPassword(request.getParameter("password"));

            AddressBean indirizzobase = new AddressBean();
            //indirizzobase.setId(1);
            indirizzobase.setVia(request.getParameter("indirizzo"));
            indirizzobase.setCitta(request.getParameter("citta"));
            indirizzobase.setCAP(request.getParameter("cap"));
            indirizzobase.setUsername(request.getParameter("username"));

            try {
                result = model.doSave(client);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }

            if(result == 0){
                response.sendRedirect("loginError.jsp");
            }

        else{

            try {
                addressmodel.doSave(indirizzobase);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }


            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
        }

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }  
}
