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
        
        if(action == null){
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/registration.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
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
        else if(!ajax && action.equals("register")){
            int result = 0;
            String username = request.getParameter("username");
            String cf = request.getParameter("cf");
            String nome = request.getParameter("nome");
            String cognome = request.getParameter("cognome");
            String indirizzo = request.getParameter("indirizzo");
            String citta = request.getParameter("citta");
            String provincia = request.getParameter("provincia");
            String cap = request.getParameter("cap");
            String telefono = request.getParameter("telefono");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if(username==null || !username.matches("^[a-zA-Z0-9_-]{6,20}$")){
                sendError(request, response);
                return;
            }
            if(cf==null || !cf.matches("^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$")){
            	sendError(request, response);
            	return;
            }
            if(nome==null || !nome.matches("^[A-Za-z ]+$")){
            	sendError(request, response);
            	return;
            }
            if(cognome==null || !cognome.matches("^[A-Za-z ]+$")){
            	sendError(request, response);
            	return;
            }
            if(indirizzo==null || !indirizzo.matches("^([A-Za-z]+\\s)+\\d+$")){
            	sendError(request, response);
            	return;
            }
            if(citta==null || !citta.matches("^[A-Za-z ]+$")){
            	sendError(request, response);
            	return;
            }
            if(provincia==null || !provincia.matches("^[A-Za-z ]+$")){
            	sendError(request, response);
            	return;
            }
            if(cap==null || !cap.matches("^\\d{5}$")){
            	sendError(request, response);
            	return;
            }
            if(telefono==null || !telefono.matches("^\\d{10}$")){
            	sendError(request, response);
            	return;
            }
            if(email==null || !email.matches("^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$")){
            	sendError(request, response);
            	return;
            }
            if(password==null || !password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,20}$")){
            	sendError(request, response);
            	return;
            }
            
            client.setUsername(username);
            client.setCf(cf);
            client.setNome(nome);
            client.setCognome(cognome);
            client.setVia(indirizzo);
            client.setCitta(citta);
            client.setProvincia(provincia);
            client.setCap(cap);
            client.setTelefono(telefono);
            client.setEmail(email);
            client.setPassword(password);

            AddressBean indirizzobase = new AddressBean();
            
            indirizzobase.setVia(indirizzo);
            indirizzobase.setCitta(citta);
            indirizzobase.setCAP(cap);
            indirizzobase.setUsername(username);

            try {
                result = model.doSave(client);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }

            if(result == 0){
                response.sendRedirect("loginError.jsp");
                return;
            }else{
                try {
                    addressmodel.doSave(indirizzobase);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                
                response.sendRedirect("login");        
            }

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }
    
    public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        request.setAttribute("error", "JadeTear encountered a problem during your registration. Please, try to fill up the form correctly and check your data before submitting.");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/registration.jsp");
        dispatcher.forward(request, response);
    }
}
