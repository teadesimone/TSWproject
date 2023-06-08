package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.logging.Level;
import java.util.logging.Logger;

import it.unisa.model.*;


public class PaymentServlet extends HttpServlet {
	private static final Logger LOGGER = Logger.getLogger(DetailsServlet.class.getName() );
    private static final long serialVersionUID = 1L;

    static OrderDAO orderModel = new OrderDAO();
    static JewelDAO jewelModel = new JewelDAO();


    static int id_ordine = 0;

    public PaymentServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        boolean check = true;


        if(action != null) {

            if (cart != null && cart.getProducts().size() != 0){
                /*if(action.equalsIgnoreCase("buy")) {
                    // se non è loggato lo portiamo al login
                    if(client == null) {
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
                        dispatcher.forward(request, response);
                    }

                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/checkout.jsp");
                    dispatcher.forward(request, response);

                }*/

			     if(action.equalsIgnoreCase("confirm_buy")) {

                    //INIZIALIZZA L'ID, COSI DA POTER POPOLARE L'ARRAY
                    id_ordine++;
                    OrderBean order = new OrderBean();
                    float totale = 0;
                    float prezzo = 0;

                    //CICLO PER POPOLARE ARRAYLIST DEGLI ORDERPRODUCT
                    ArrayList<OrderProductBean> products = new ArrayList<>(); 
                    for (CartProduct cp : cart.getProducts()){
                        OrderProductBean prodotto = new OrderProductBean();
                        prodotto.setId_ordine(id_ordine); 
                        prodotto.setId_prodotto(cp.getProduct().getId());
                        prodotto.setPrezzo(cp.getProduct().getPrezzo());
                        prodotto.setIVA(cp.getProduct().getIVA());
                        prodotto.setQuantita(cp.getQuantity());
                        products.add(prodotto);
                        if(cp.getProduct().getSconto()!=0){
                            prezzo = (cp.getProduct().getPrezzo() * cp.getProduct().getSconto()) /100;
                        }
                        else {
                            prezzo = cp.getProduct().getPrezzo();
                        }
                        totale = totale + (prezzo * cp.getQuantity());
                    }

                    order.setProducts(products);
                    
                    order.setId(id_ordine);
                    order.setClient(client);
                    order.setPrezzo_totale(totale);
                    //System.out.println(order.getData());
                    order.setDestinatario(request.getParameter("destinatario"));
                    order.setMetodo_di_pagamento(request.getParameter("pagamento"));
                    order.setIndirizzo_di_spedizione(request.getParameter("indirizzo"));

                    Random r = new Random();
                    int low = 100000;
                    int high = 10000000;
                    String result = Integer.toString(r.nextInt(high-low) + low);

                    order.setNumero_di_tracking(result);
                    order.setNote(request.getParameter("note"));
                    order.setData(new java.sql.Date(Calendar.getInstance().getTime().getTime()));
                    order.setMetodo_di_spedizione(request.getParameter("spedizione"));
                    order.setConfezione_regalo(Boolean.parseBoolean(request.getParameter("regalo")));

                    try {
                        //controllo che la quantità di prodotti inserita nel carrello sia ancora disponibile
                        for (CartProduct cp : cart.getProducts()){
                            if(cp.getQuantity() > cp.getProduct().getDisponibilita() ){
                                check = false;
                            }
                        }
                        if (check != false){
                            orderModel.doSave(order);
                            for(CartProduct cp : cart.getProducts()){
                                JewelBean jewel = jewelModel.doRetrieveByKey(cp.getProduct().getId());
                                jewelModel.updateQuantity(jewel.getId(), jewel.getDisponibilita() - cp.getQuantity());
                            }
                        }
                        else{
                            //scritta di errore generale oppure dispatch alla pagina di errore generale 
                            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/generalError.jsp");
                            dispatcher.forward(request, response);
                        }
                        

                    } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                    }


                    request.getSession().removeAttribute("cart");
                    request.getSession().setAttribute("cart", null);


                    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/catalog.jsp");
                    dispatcher.forward(request, response);

                }

            else {

                //rimanda a pagina di errore (carrello vuoto)  cambia login error obv
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cartError.jsp");
                dispatcher.forward(request, response);
            }

            }    
        }
    }    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
}
