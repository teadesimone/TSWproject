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

            ClientBean client = (ClientBean) request.getSession().getAttribute("utente");
            if(client==null || !client.getEmail().equals("JadeTear@gmail.com") ){
                  System.out.println("cio sono nel controllo");
                  response.sendRedirect("home");	
                  return;
            }


            String action = request.getParameter("action");
            ArrayList<OrderBean> orders = new ArrayList<OrderBean>();
            ArrayList<ClientBean> clients = new ArrayList<ClientBean>();



            if(action == null || action.equals("")){
                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp");
                  dispatcher.forward(request, response);
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
String targetPath = tomcatBase + "//webapps//progettoTSW//images//" + fileName;
InputStream fileInputStream2 = filePart.getInputStream();

Path targetImagePath = Path.of(targetPath);
Files.copy(fileInputStream2, targetImagePath);*/


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
                        System.out.println("nome");
                        sendError(request, response);
                        return;
                  }
                  if(category==null || category.equals("") || (!category.equals("Necklace") && !category.equals("Earrings") && !category.equals("Ring") && !category.equals("Bracelet"))){
                        System.out.println("catego");
                        sendError(request, response);
                        return;
                  }
                  if(gemstone==null ||  gemstone.equals("") || (!gemstone.equals("Quarz") && !gemstone.equals("Jade") && !gemstone.equals("Amethyst") && !gemstone.equals("Citrine") && !gemstone.equals("Rose Quarz") && !gemstone.equals("Aquamarine"))){
                        System.out.println("gem");
                        sendError(request, response);
                        return;
                  }
                  if(availability==0 || !(availability > 0 && availability < 100)){
                        System.out.println("dis");
                        sendError(request, response);
                        return;
                  }
                  if(IVA==0 || !(IVA > 0 && IVA < 100)){
                        System.out.println("iva");
                        sendError(request, response);
                        return;
                  }
                  if(price==0 || !(price > 0 && price <= 5000)){
                        System.out.println("price");
                        sendError(request, response);
                        return;
                  }
                  if(description==null || !description.matches("^[a-zA-Z0-9 ]{1,100}$")){
                        System.out.println("descri");
                        sendError(request, response);
                        return;
                  }
                  if(material==null || material.equals("") || (!material.equals("Gold") && !material.equals("Silver") && !material.equals("Rose Gold"))){
                        System.out.println("mat");
                        sendError(request, response);
                        return;
                  }
                  if(discount==-1 || !(discount >= 0 && discount < 100)){
                        System.out.println("sconto");
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

                  if(idM==0 || !(idM==Integer.parseInt(request.getParameter("id")))){
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
                  if(descriptionM==null || !descriptionM.matches("^[a-zA-Z0-9]{1,100}$")){
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

                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
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
        else {
              request.setAttribute("dateError", "Insert valid dates");
              RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
              dispatcher.forward(request, response);
        } 
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

                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
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

                  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/client.jsp");
                  dispatcher.forward(request, response);

                  return;
            }

            if (action.equals("ByClient")){

                  String user = request.getParameter("cliente");

                  try {
                        clients.add(clientModel.doRetrieveByKey(user));
                  } catch (SQLException e) {
                        LOGGER.log( Level.SEVERE, e.toString(), e );
                        response.sendRedirect("generalError.jsp");
                        return;
                  }

                  if (clients.get(0)== null){  // si inserisce un cliente che non esiste
                        request.setAttribute("clientError", "Client not found");
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/clientorders.jsp");
                        dispatcher.forward(request, response);
                  }

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
