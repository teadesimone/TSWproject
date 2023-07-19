package it.unisa.control;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
    static AddressDAO addressmodel = new AddressDAO();
    static PaymentMethodDAO paymentmodel = new PaymentMethodDAO();
    static InvoiceDAO invoicemodel = new InvoiceDAO();

    public PaymentServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
        boolean check = true;
        AddressBean bean =  null;
        InvoiceBean invoice = new InvoiceBean();
        
        if( action == null || action.equals("buy") || action.equals("")){
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/checkout.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        int idcarta;
        int idindirizzo;
        
        if(request.getParameter("carta").equals(""))
            idcarta = 0;
        else
            idcarta = Integer.parseInt(request.getParameter("carta"));

        if(request.getParameter("indirizzo").equals(""))
            idindirizzo = 0;
        else
            idindirizzo = Integer.parseInt(request.getParameter("indirizzo"));
        
        
        String destinatario = request.getParameter("destinatario");
        String note = request.getParameter("note");
        String spedizione= request.getParameter("spedizione");
        String metpag = request.getParameter("metodo_di_pagamento");
        
        if(destinatario.equals("") || destinatario== null || !destinatario.matches("^[A-Za-z ]+$")){
            sendError(request, response);
            return;
        }
        if(spedizione.equals("") || spedizione== null || (!spedizione.equals("Express") && !spedizione.equals("Standard") && !spedizione.equals("Economic") )){
            sendError(request, response);
            return;
        }
        if(note.equals("") || note== null || !note.matches("^[A-Za-z ]+$")){
            sendError(request, response);
            return;
        }
        if(metpag.equals("") || metpag== null || (!metpag.equals("carta_di_credito") && !metpag.equals("carta_di_debito") && !metpag.equals("Paypal"))){
            sendError(request, response);
            return;
        }
        
        int id_ordine;
        
        OrderBean lastorder = new OrderBean();
		try {
			lastorder = orderModel.lastOrder();
		} catch (SQLException e) {
			LOGGER.log( Level.SEVERE, e.toString(), e );
		}
        
        if (lastorder== null){
            id_ordine = 0;
        }
        else{
            id_ordine = lastorder.getId();
        }
        

            if (cart != null && cart.getProducts().size() != 0){
                
			     if(action != null && action.equalsIgnoreCase("confirm_buy")) {

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
                    if (spedizione.equalsIgnoreCase("Express")){
                        
                        totale = totale + 5;
                    }
                    
                    order.setPrezzo_totale(totale);
                    order.setDestinatario(destinatario);
                    order.setMetodo_di_pagamento(metpag);
                     
                    try {
						order.setCircuito(paymentmodel.doRetrieveByKey(idcarta).getCircuito());
					} catch (SQLException e) {
						LOGGER.log( Level.SEVERE, e.toString(), e );
					}
                    
                    try {
						order.setNumero_carta(paymentmodel.doRetrieveByKey(idcarta).getNumero_carta());
					} catch (SQLException e) {
						LOGGER.log( Level.SEVERE, e.toString(), e );
					}
                    
                    try {
						bean = addressmodel.doRetrieveByKey(idindirizzo);
					} catch (SQLException e) {
						LOGGER.log( Level.SEVERE, e.toString(), e );
					}
                    
                    String indirizzospedizione = bean.getVia() + "," + bean.getCitta();
                    order.setIndirizzo_di_spedizione(indirizzospedizione);

                    SecureRandom r = new SecureRandom();
                    int low = 100000;
                    int high = 10000000;
                    String result = Integer.toString(r.nextInt(high-low) + low);
                    order.setNumero_di_tracking(result);
                    
                    order.setNote(note);
                    order.setData(new java.sql.Date(Calendar.getInstance().getTime().getTime()));
                    order.setMetodo_di_spedizione(spedizione);
                    order.setConfezione_regalo(Boolean.parseBoolean(request.getParameter("regalo")));

                    try {
                        //controllo che la quantit� di prodotti inserita nel carrello sia ancora disponibile
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
                            response.sendRedirect("generalError.jsp");
                            return;
                        }
                        

                    } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                    }
                    
                    //GENERAZIONE DELLA FATTURA
                    SecureRandom n = new SecureRandom();
                    int low1 = 1000000;
                    int high2 = 9999999;
                    String sdi = Integer.toString(n.nextInt(high2-low1) + low1);
                    
                    Date date = Calendar.getInstance().getTime();  
                    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");  
                    String data_emissione = dateFormat.format(date);
                    
                    String data_scadenza = (data_emissione.substring(0, 9)+"4");
                    
                    invoice.setSdi(sdi);
                    invoice.setImporto(totale);
                    invoice.setData_emissione(data_emissione);
                    invoice.setData_scadenza(data_scadenza);
                    invoice.setStato_pagamento("Paid");
                    invoice.setIva(22);
                    invoice.setId(id_ordine);
                    
                    try {
						invoicemodel.doSave(invoice);
					}  catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                    }
                    
                    //IL CARRELLO ADESSO E' VUOTO
                    request.getSession().removeAttribute("cart");
                    request.getSession().setAttribute("cart", null);
                    
                    response.sendRedirect("catalog");
                    return;
                }

            }else {
                response.sendRedirect("cartError.jsp");
                return;
            }
        
    }    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
    
    public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        request.setAttribute("error", "JadeTear encountered a problem during the payment. Please, try to fill up the form correctly and check your data before submitting.");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/checkout.jsp");
        dispatcher.forward(request, response);
    }
}
