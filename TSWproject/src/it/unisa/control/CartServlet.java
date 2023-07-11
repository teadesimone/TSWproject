package it.unisa.control;

import it.unisa.model.*;

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
    
    private static JewelDAO model = new JewelDAO();
    private static AddressDAO addressModel = new AddressDAO();
    private static PaymentMethodDAO paymentModel = new PaymentMethodDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Cart cart = (Cart)request.getSession().getAttribute("cart");
        if(cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
            
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");

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
         
            
        if (action.equals("add")){
            //controllo che ci siano abbastanza prodotti da aggiungere al carrello
            if(jewel.getDisponibilita()>0)
                cart.addProduct(jewel);
            //else
                // scritta di errore generale oppure dispatch alla pagina di errore generale 
        }
            
        if (action.equals("Delete from Cart"))
            cart.removeProduct(jewel);

        if (action.equals("Modify Amount")){
                if((jewel.getDisponibilita() - Integer.parseInt(request.getParameter("quantity"))) >= 0 )
                        cart.changeQuantity(jewel, Integer.parseInt(request.getParameter("quantity")));
                //else
                        //scritta di errore generale oppure dispatch alla pagina di errore generale 
        }
            
        if (cart != null && cart.getProducts().size() != 0){
            if(action.equalsIgnoreCase("buy")) {
                // se non è loggato lo portiamo al login
                if(client == null) {
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
                request.getSession().setAttribute("cart", cart);
                
                ArrayList<AddressBean> indirizzi = null;
				try {
					indirizzi = addressModel.doRetrieveByClient(client.getUsername());
				} catch (SQLException e) {
					LOGGER.log( Level.SEVERE, e.toString(), e );
				}
				
                ArrayList<PaymentMethodBean> carte = null;
				try {
                    carte =  paymentModel.doRetrieveByClient(client.getUsername());
				} catch (SQLException e) {
					LOGGER.log( Level.SEVERE, e.toString(), e );
                    
				}
                
             
				
                if(!indirizzi.isEmpty() && !carte.isEmpty()){
                
                	request.setAttribute("addresses", indirizzi);
                	request.setAttribute("payments",carte);
                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/checkout.jsp");
                    dispatcher.forward(request, response);       
                    
                    return;
                }
                else{
                	
                    //QUI DOVREMMO INSERIRE UN ERRORE IN SOVRAIMPRESSIONE SULLA PAGINA 
                    
                   RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/generalError.jsp");
                   dispatcher.forward(request, response);
                   return;
                }

            }
        }
        
  
        request.getSession().setAttribute("cart", cart);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cart.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

}
