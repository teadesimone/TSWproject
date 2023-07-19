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
            //PREMESSA: la Servlet dell'admin è collegata a più jsp:
            //1) la client.jsp (per la visualizzazione dei clienti),
            //2) la clientorders.jsp (per la visualizzaizone degli ordini degli utenti)
            //3) la admin.jsp (per le operazioni da admin, quali aggiunta, modifica ed eliminazione di gioielli)
            
            //controllo se è stato inserito il client nella sessione
            ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
            if(client==null || !client.getEmail().equals("JadeTear@gmail.com") ){
                  //se non lo è, si viene ridirezionati alla home
                  response.sendRedirect("home");	
                  return;
            }
            
            //viene preso il parametro action e settate le liste da passare nella request
            String action = request.getParameter("action");
            ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
            ArrayList<ClientBean> clients = new ArrayList<ClientBean>();

            //se l'azione è nulla o è una stringa vuota, vuol dire che si sta accedendo alla pagina stessa (anche da url) e si viene ridirezionati
            if(action == null || action.equals("")){
                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
                  dispatcher.forward(request, response);
                  return;
            }
            
            //azione di inserimento di un nuovo gioiello
            if (action.equals("insert")) {

                  //CODICE DELL'UPLOAD DELLE IMMAGINI NELLA CARTELLA
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

                  //controllo e set di tutti i parametri destinati al JewelBean prima di essere salvato nel database
                  int availability;
                  float IVA;
                  float price;
                  int discount;

                  if(request.getParameter("availability").equals(""))
                        availability = 0;
                  else
                        availability = Integer.parseInt(request.getParameter("availability"));

                  if(request.getParameter("IVA").equals(""))
                        IVA = 0;
                  else
                        IVA = Float.parseFloat(request.getParameter("IVA"));

                  if(request.getParameter("price").equals(""))
                        price = 0;
                  else
                        price = Float.parseFloat(request.getParameter("price"));

                  if(request.getParameter("discount").equals(""))
                        discount = 0;
                  else
                        discount = Integer.parseInt(request.getParameter("discount"));


                  String category = request.getParameter("category");
                  String gemstone = request.getParameter("gemstone");
                  String description = request.getParameter("description");
                  String material = request.getParameter("material");

                  if(nome==null || !nome.matches("^[A-Za-z ]+$")){
                       
                        sendError(request, response);
                        return;
                  }
                  if(category==null || category.equals("") || (!category.equals("Necklace") && !category.equals("Earrings") && !category.equals("Ring") && !category.equals("Bracelet"))){
                       
                        sendError(request, response);
                        return;
                  }
                  if(gemstone==null ||  gemstone.equals("") || (!gemstone.equals("Quarz") && !gemstone.equals("Jade") && !gemstone.equals("Amethyst") && !gemstone.equals("Citrine") && !gemstone.equals("Rose Quarz") && !gemstone.equals("Aquamarine"))){
                      
                        sendError(request, response);
                        return;
                  }
                  if(availability==0 || !(availability > 0 && availability < 100)){
                       
                        sendError(request, response);
                        return;
                  }
                  if(IVA==0 || !(IVA > 0 && IVA < 100)){
                        
                        sendError(request, response);
                        return;
                  }
                  if(price==0 || !(price > 0 && price <= 5000)){
                       
                        sendError(request, response);
                        return;
                  }
                  if(description==null || !description.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
                      
                        sendError(request, response);
                        return;
                  }
                  if(material==null || material.equals("") || (!material.equals("Gold") && !material.equals("Silver") && !material.equals("Rose Gold"))){
                        
                        sendError(request, response);
                        return;
                  }
                  if(discount==-1 || !(discount >= 0 && discount < 100)){
                       
                        sendError(request, response);
                        return;
                  }


                  //AGGIUNTA DEL PRODOTTO NEL DATABASE
                  JewelBean jewel = new JewelBean();
                  jewel.setNome(nome);
                  jewel.setCategoria(category);
                  jewel.setPietra(gemstone);
                  jewel.setImmagine(fileName);
                  jewel.setDisponibilita(availability);
                  jewel.setIVA(IVA);
                  jewel.setPrezzo(price);
                  jewel.setDescrizione(description);
                  jewel.setMateriale(material);
                  jewel.setSconto(discount);
                  jewel.setPersonalizzato(false);

                  try {
                        model.doSave(jewel);
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

            }
            
            //azione di caricamento di un gioiello dal suo id, avviene prima di poterlo modificare
            if (action.equals("load")) {
                  JewelBean jewelToModify = new JewelBean();

                  try {
                        jewelToModify = model.doRetrieveByKey(Integer.parseInt(request.getParameter("id")));
                  } catch (NumberFormatException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

                  request.setAttribute("jewel",jewelToModify);
            }
            
            //vengono presi dalla request tutti i parametri, da un form, controllati e settati
            if (action.equals("modify")) {
                  JewelBean jewel = new JewelBean();

                  int idM;
                  int availabilityM;
                  float IVAM;
                  float priceM;
                  int discountM;

                  if(request.getParameter("idM").equals(""))
                        idM = 0;
                  else
                        idM = Integer.parseInt(request.getParameter("idM"));

                  if(request.getParameter("availabilityM").equals(""))
                        availabilityM = 0;
                  else
                        availabilityM = Integer.parseInt(request.getParameter("availabilityM"));

                  if(request.getParameter("IVAM").equals(""))
                        IVAM = 0;
                  else
                        IVAM = Float.parseFloat(request.getParameter("IVAM"));

                  if(request.getParameter("priceM").equals(""))
                        priceM = 0;
                  else
                        priceM = Float.parseFloat(request.getParameter("priceM"));

                  if(request.getParameter("discountM").equals(""))
                        discountM = 0;
                  else
                        discountM = Integer.parseInt(request.getParameter("discountM"));

                  String nameM = request.getParameter("nameM");
                  String categoryM = request.getParameter("categoryM");
                  String gemstoneM = request.getParameter("gemstoneM");
                  String descriptionM = request.getParameter("descriptionM");
                  String materialM = request.getParameter("materialM");

                  if(idM==0 ){
                       
                        sendError(request, response);
                        return;
                  }
                  if(nameM==null || !nameM.matches("^[A-Za-z ]+$")){
                        
                        sendError(request, response);
                        return;
                  }
                  if(categoryM==null || categoryM.equals("") || (!categoryM.equals("Necklace") && !categoryM.equals("Earrings") && !categoryM.equals("Ring") && !categoryM.equals("Bracelet"))){
                       
                        sendError(request, response);
                        return;
                  }
                  if(gemstoneM==null || gemstoneM.equals("")|| (!gemstoneM.equals("Quarz") && !gemstoneM.equals("Jade") && !gemstoneM.equals("Amethyst") && !gemstoneM.equals("Citrine") && !gemstoneM.equals("Rose Quarz") && !gemstoneM.equals("Aquamarine"))){
                        
                        sendError(request, response);
                        return;
                  }
                  if(availabilityM==0 || !(availabilityM > 0 && availabilityM <= 100)){
                        
                        sendError(request, response);
                        return;
                  }
                  if(IVAM==0 || !(IVAM > 0 && IVAM < 100)){
                      
                        sendError(request, response);
                        return;
                  }
                  if(priceM==0 || !(priceM > 0 && priceM <= 5000)){
                        
                        sendError(request, response);
                        return;
                  }
                  if(descriptionM==null || !descriptionM.matches("^[a-zA-Z0-9\\s\\p{P}]{1,500}$")){
                        
                        sendError(request, response);
                        return;
                  }
                  if(materialM==null || materialM.equals("") ||( !materialM.equals("Gold") && !materialM.equals("Silver") && !materialM.equals("Rose Gold"))){
                        
                        sendError(request, response);
                        return;
                  }
                  if(discountM==-1 || !(discountM >= 0 && discountM < 100)){
                        
                        sendError(request, response);
                        return;
                  }


                  jewel.setId(idM);
                  jewel.setNome(nameM);
                  jewel.setCategoria(categoryM);
                  jewel.setPietra(gemstoneM);
                  jewel.setImmagine(request.getParameter("imageM"));
                  jewel.setDisponibilita(availabilityM);
                  jewel.setIVA(IVAM);
                  jewel.setPrezzo(priceM);
                  jewel.setDescrizione(descriptionM);
                  jewel.setMateriale(materialM);
                  jewel.setSconto(discountM);
                  jewel.setPersonalizzato(false);
                  
                  //effettiva modifica chiamando il DAO 
                  try {
                        model.doModify(jewel);
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

            }
            
            //azione di eliminazione: prende l'id di un gioiello e lo elimina
            if (action.equals("delete")) {
                  String id = request.getParameter("id");

                  try {
                        model.doDelete(Integer.parseInt(id));
                  } catch (NumberFormatException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

            }
            
            //azione che determina la vista di tutti gli ordini effettuati 
            if (action.equals("ordersNoFilter")){

                  try {
                        orders = orderModel.doRetrieveAll();
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

                  request.setAttribute("ordini", orders);
                  System.out.println(request.getAttribute("clientError"));
                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                  dispatcher.forward(request, response);
                  return;
            }

            //azione di ordinamento (due tipi: per data, per cliente) per la clientorders.jsp
            if (action.equals("orders")){
                  
                  //ordinamento per cliente
                  if (Boolean.parseBoolean(request.getParameter("Order By Client"))== true){

                        String user = request.getParameter("cliente");

                        try {
                              orders = orderModel.doRetrieveByClient(user);
                        } catch (SQLException e) {
                              LOGGER.log( Level.SEVERE, e.toString(), e );
                        }
                        
                        //controllo che l'utente inserito abbia effettuato degli ordini
                        if(orders.size()==0){
                              request.setAttribute("clientError", "This user doesn't have orders saved");
                              System.out.println((String)request.getAttribute("clientError")+1);
                              RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                              dispatcher.forward(request, response);
                              return;
                        }
                        

                  }//ordinamento per data
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
                          else { //se la data "da" è più recente della data "a"
                                request.setAttribute("dateError", "Insert valid dates");
                                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                                dispatcher.forward(request, response);
                                return;
                          } 
                  }
                  //ordinamento sia per data che per utente
                  if ((Boolean.parseBoolean(request.getParameter("Order By Date"))== true) && (Boolean.parseBoolean(request.getParameter("Order By Client"))== true)){

                        String user = request.getParameter("cliente");
                        String data_da = (String) request.getParameter("data_da");
                        String data_a = (String) request.getParameter("data_a");
                        try {
                              orders = orderModel.ClientDateOrders(user,data_da,data_a);
                        } catch (SQLException e) {
                              LOGGER.log( Level.SEVERE, e.toString(), e );
                              RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin?action=ordersNoFilter");
                              dispatcher.forward(request, response);
                              return;
                        }
                  }


                  request.setAttribute("ordini", orders);

                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                  dispatcher.forward(request, response);
                  return;

            }
            //action di ordinamento dei clienti senza alcun filtro per la client.jsp
            if (action.equals("clientsNoFilter")){

                  try {
                        clients = clientModel.doRetrieveAll();
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }


                  request.setAttribute("clienti", clients);

                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                  dispatcher.forward(request, response);

                  return;
            }

            if (action.equals("ByClient")){ //ordinamento per un particolare utente

                  String user = request.getParameter("cliente");
                  ClientBean person = null;

                  try {
                      person = (clientModel.doRetrieveByKey(user));
                  } catch (SQLException e) {
                	  
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                        
                  }
                  //controllo che l'utente esista
                  if (person==null) {
                      request.setAttribute("clientError", "This user doesn't exist");  
                      RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                      dispatcher.forward(request, response);
                      return;
                  }

                  clients.add(person);
                  request.setAttribute("clienti", clients);

                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                  dispatcher.forward(request, response);
                  return;
            }

            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
            dispatcher.forward(request, response);
      }

      protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
            doGet(request, response);
      }

      public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
            request.setAttribute("error", "JadeTear encountered a problem during submission. Please, try to fill up the form again.");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
            dispatcher.forward(request, response);
      }

}
