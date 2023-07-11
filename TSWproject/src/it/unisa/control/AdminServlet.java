package it.unisa.control;

import java.io.IOException; 
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.logging.Level;
import java.util.logging.Logger;


import it.unisa.model.*; 

@MultipartConfig
public class AdminServlet extends HttpServlet {
   private static final String CARTELLA_UPLOAD = "images"; 
  
	 static OrderDAO orderModel = new OrderDAO();
	 static  JewelDAO model = new JewelDAO();
   static ClientDAO clientModel = new ClientDAO();
	
	private static final Logger LOGGER = Logger.getLogger( AdminServlet.class.getName() );

  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    String action = request.getParameter("action");
    ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
    ArrayList<ClientBean> clients = new ArrayList<ClientBean>();
    
    ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
    if(!client.getEmail().equals("JadeTear@gmail.com")||client==null){
      response.sendRedirect("Error403.jsp");	
      return;
    }
    
    if (action.equals("insert")) {
      
      //UPLOAD DELLE IMMAGINI NELLA CARTELLA
      Part filePart = request.getPart("image");

      String nome = request.getParameter("name");
      String estensione ="jpg";
      String fileName = nome + "." + estensione;
      System.getProperty("user.dir");

      
      
      String destinazione = System.getProperty("user.dir") + File.separator + "TSWproject" + File.separator + "WebContent" + File.separator + CARTELLA_UPLOAD + File.separator + fileName;
      Path pathDestinazione = Path.of(destinazione);


      // se un file con quel nome esiste già, gli cambia nome
      for (int i = 2; Files.exists(pathDestinazione); i++) {
        String newFileName = i + "_" + nome + "." + estensione;
       
        
        destinazione = System.getProperty("user.dir") + File.separator + "TSWproject" + File.separator + "WebContent" + File.separator + CARTELLA_UPLOAD + File.separator+ newFileName;
        pathDestinazione = Path.of(destinazione);
      }

      InputStream fileInputStream = filePart.getInputStream();
      // crea CARTELLA_UPLOAD, se non esiste
      Files.createDirectories(pathDestinazione.getParent());

      // scrive il file
      Files.copy(fileInputStream, pathDestinazione);
      request.setAttribute("uploaded", destinazione);
      
      //UPLOAD NEL .war
      /*
        String tomcatBase = System.getProperty("catalina.base");
        String targetPath = tomcatBase + "//webapps//TSWproject//images//" + fileName;
        InputStream fileInputStream2 = filePart.getInputStream();

        Path targetImagePath = Path.of(targetPath);
        Files.copy(fileInputStream2, targetImagePath);
      */
      
      //AGGIUNTA DEL PRODOTTO NEL DATABASE
      JewelBean jewel = new JewelBean();
      jewel.setNome(request.getParameter("name"));
      jewel.setCategoria(request.getParameter("category"));
      jewel.setPietra(request.getParameter("gemstone"));
      jewel.setImmagine(fileName);
      jewel.setDisponibilita(Integer.parseInt(request.getParameter("availability")));
      jewel.setIVA(Float.parseFloat(request.getParameter("IVA")));
      jewel.setPrezzo(Float.parseFloat(request.getParameter("price")));
      jewel.setDescrizione(request.getParameter("description"));
      jewel.setMateriale(request.getParameter("material"));
      jewel.setSconto(Integer.parseInt(request.getParameter("discount")));
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
    
    if (action.equals("ordersNoFilter")){

      try {
        orders = orderModel.doRetrieveAll();
      } catch (SQLException e) {
        LOGGER.log( Level.SEVERE, e.toString(), e );
      }
      
      request.setAttribute("ordini", orders);
      
      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientorders.jsp");
      dispatcher.forward(request, response);
      return;
    }
      
    
    if (action.equals("orders")){
      
      if (Boolean.parseBoolean(request.getParameter("Order By Client"))== true){

        String user = request.getParameter("cliente");

        try {
          orders = orderModel.doRetrieveByClient(user);
        } catch (SQLException e) {
          LOGGER.log( Level.SEVERE, e.toString(), e );
        }

      }
      if(Boolean.parseBoolean(request.getParameter("Order By Date"))== true){

        String data_da = (String) request.getParameter("data_da");
        String data_a = (String) request.getParameter("data_a");
        
        if (data_da.compareTo(data_a)< 0){
          try {
            orders = orderModel.DateOrders(data_da,data_a);
          } catch (SQLException e) {
            LOGGER.log( Level.SEVERE, e.toString(), e );
          }
        }
        /*else {

        // pagina di errore
        } */
      }
      
      if ((Boolean.parseBoolean(request.getParameter("Order By Date"))== true) && (Boolean.parseBoolean(request.getParameter("Order By Client"))== true)){

        String user = request.getParameter("cliente");
        String data_da = (String) request.getParameter("data_da");
        String data_a = (String) request.getParameter("data_a");
        try {
        orders = orderModel.ClientDateOrders(user,data_da,data_a);
        } catch (SQLException e) {
        LOGGER.log( Level.SEVERE, e.toString(), e );
        }
      }
      
      
      request.setAttribute("ordini", orders);
      
      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientorders.jsp");
      dispatcher.forward(request, response);
      return;

      }
    
      if (action.equals("clientsNoFilter")){

        try {
         clients = clientModel.doRetrieveAll();
       } catch (SQLException e) {
         LOGGER.log( Level.SEVERE, e.toString(), e );
        }

        
        request.setAttribute("clienti", clients);

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/client.jsp");
        dispatcher.forward(request, response);
        
        return;
    }
    
    if (action.equals("ByClient")){

      String user = request.getParameter("cliente");

      try {
        clients.add(clientModel.doRetrieveByKey(user));
      } catch (SQLException e) {
        LOGGER.log( Level.SEVERE, e.toString(), e );
      }
      
      if (clients.get(0)== null){  // si inserisce un cliente che non esiste
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/generalError.jsp");
        dispatcher.forward(request, response);
        return;
        
      }
      
      request.setAttribute("clienti", clients);

      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/client.jsp");
      dispatcher.forward(request, response);
      return;
    }
      
    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin.jsp");
    dispatcher.forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    doGet(request, response);
  }

}
