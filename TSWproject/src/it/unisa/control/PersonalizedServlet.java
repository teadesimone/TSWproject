package it.unisa.control;

import java.io.IOException;
import java.security.SecureRandom;
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

public class PersonalizedServlet extends HttpServlet {
    
    static  JewelDAO model = new JewelDAO();

    private static final Logger LOGGER = Logger.getLogger( AdminServlet.class.getName() );

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

        String action = request.getParameter("action");
        
        SecureRandom r = new SecureRandom(); // utilizzo di un SecureRandom per generare il prezzo del gioiello personalizzato
        int low = 50;
        int high = 200;
        float result = (float)r.nextInt(high-low) + low;
        int id= -1;
        
        if(action == null || action.equals("")){
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/personalized.jsp");
            dispatcher.forward(request, response);
            return;
        }
        else if (action.equals("insert")) { // controllo dei form server side della personalized.jsp 
            
            String category = request.getParameter("category");
            String gemstone = request.getParameter("gemstone");
            String description = request.getParameter("description");
            String material =request.getParameter("material");
            
            if(category==null || (!category.equals("Necklace") && !category.equals("Earrings") && !category.equals("Ring") && !category.equals("Bracelet"))){
                sendError(request, response);
                return;
            }
            if(gemstone==null || (!gemstone.equals("Quarz") && !gemstone.equals("Jade") && !gemstone.equals("Amethyst") && !gemstone.equals("Citrine") && !gemstone.equals("Rose Quarz") && !gemstone.equals("Aquamarine"))){
                sendError(request, response);
                return;
            }
            if(description==null || !description.matches("^[a-zA-Z\\s]{1,100}$")){
                sendError(request, response);
                return;
            }
            if(material==null || (!material.equals("Gold") && !material.equals("Silver") && !material.equals("Rose Gold"))){
                sendError(request, response);
                return;
            }
            
            JewelBean jewel = new JewelBean(); // si crea un gioiello con nome, immagine, disponibilità e sconto predefiniti
            jewel.setNome("Customized");
            jewel.setCategoria(category);
            jewel.setPietra(gemstone);
            jewel.setImmagine("Customized.jpg");
            jewel.setDisponibilita(1);
            jewel.setIVA(22);
            jewel.setPrezzo(result);
            jewel.setDescrizione(description);
            jewel.setMateriale(material);
            jewel.setSconto(0);
            jewel.setPersonalizzato(true);

            try {
                id = model.doSave(jewel);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
                response.sendRedirect("generalError.jsp");
                return;
            }
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cart?action=add&id=" + id); //se l'insert è andata a buon fine si aggiunge il gioiello al carrello
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }
    
    public void sendError(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        request.setAttribute("error", "JadeTear encountered a problem during submission. Please, try to fill up the form again.");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/personalized.jsp");
        dispatcher.forward(request, response);
    }
}