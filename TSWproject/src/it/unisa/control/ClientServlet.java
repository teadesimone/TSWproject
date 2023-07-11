package it.unisa.control;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;


public class ClientServlet extends HttpServlet{
    
    static final Logger LOGGER = Logger.getLogger(DetailsServlet.class.getName() );
    static ClientDAO clientModel = new ClientDAO();
    static AddressDAO addressmodel = new AddressDAO();
    static PaymentMethodDAO paymentmodel = new PaymentMethodDAO();
    
    public ClientServlet() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        String action = request.getParameter("action");
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        
        ArrayList<AddressBean> addresses = null;
		try {
			addresses = (ArrayList<AddressBean>) addressmodel.doRetrieveByClient(client.getUsername());
		} catch (SQLException e) {
            LOGGER.log( Level.SEVERE, e.toString(), e );
        }
		
        ArrayList<PaymentMethodBean> payments = null;
		try {
			payments = (ArrayList<PaymentMethodBean>) paymentmodel.doRetrieveByClient(client.getUsername());
		}  catch (SQLException e) {
            LOGGER.log( Level.SEVERE, e.toString(), e );
        }
        
        request.setAttribute("addresses", addresses);
        request.setAttribute("payments", payments);
        
        
        if(action != null){
            
            if(action.equalsIgnoreCase("modify")){
                
                client.setCf(request.getParameter("cf"));
                client.setNome(request.getParameter("nome"));
                client.setCognome(request.getParameter("cognome"));
                client.setVia(request.getParameter("indirizzo"));
                client.setCitta(request.getParameter("citta"));
                client.setProvincia(request.getParameter("provincia"));
                client.setCap(request.getParameter("cap"));
                client.setTelefono(request.getParameter("telefono"));
                client.setEmail(request.getParameter("email"));
                
                try {
                    clientModel.doModify(client);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
            }
            
            if(action.equalsIgnoreCase("addPaymentCard")){
                PaymentMethodBean card = new PaymentMethodBean();
                int id = -1;
                card.setNumero_carta(request.getParameter("numero_carta"));
                card.setCvv(request.getParameter("cvv"));
                card.setData_scadenza(request.getParameter("data_scadenza"));
                card.setCircuito(request.getParameter("circuito"));
                card.setUsername(client.getUsername());
                
                try {
                    id = paymentmodel.doSave(card);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                card.setId(id);
                payments.add(card);
                request.setAttribute("payments", payments);
            }
            
            if(action.equalsIgnoreCase("deletePaymentCard")){
                int idcarta = Integer.parseInt(request.getParameter("id_carta"));
                System.out.println(idcarta);
                PaymentMethodBean bean = null;
                
                try {
                    bean = paymentmodel.doRetrieveByKey(idcarta);
				}catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                payments.remove(bean);
                request.setAttribute("payments", payments);
               
                try {
                    paymentmodel.doDelete(idcarta);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
            }
            
            if(action.equalsIgnoreCase("addAddress")){
                AddressBean address = new AddressBean();
                int id = -1;
                address.setVia(request.getParameter("via_indirizzo"));
                address.setCitta(request.getParameter("citta_indirizzo"));
                address.setCAP(request.getParameter("CAP_indirizzo"));
                address.setUsername(client.getUsername());
                
                try {
                    id = addressmodel.doSave(address);
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                address.setId(id);
                addresses.add(address);
                request.setAttribute("addresses", addresses);
            }
            
            if(action.equalsIgnoreCase("deleteAddress")){
                int idindirizzo = Integer.parseInt(request.getParameter("id_indirizzo"));
                AddressBean bean = null;
                
                try {
                    bean = addressmodel.doRetrieveByKey(idindirizzo);
				}catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                addresses.remove(bean);
                request.setAttribute("addresses", addresses);
                
                try {
                    addressmodel.doDelete(Integer.parseInt(request.getParameter("id_indirizzo")));
                } catch (SQLException e) {
                    LOGGER.log( Level.SEVERE, e.toString(), e );
                }
                
            }
        }
        
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/client.jsp");
        dispatcher.forward(request, response);

        
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    } 
}