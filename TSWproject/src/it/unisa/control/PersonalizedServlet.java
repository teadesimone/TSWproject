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
        
        SecureRandom r = new SecureRandom();
        int low = 50;
        int high = 200;
        float result = (float)r.nextInt(high-low) + low;
        int id= -1;
        
        if (action.equals("insert")) {
            JewelBean jewel = new JewelBean();
            jewel.setNome("Customized");
            jewel.setCategoria(request.getParameter("category"));
            jewel.setPietra(request.getParameter("gemstone"));
            jewel.setImmagine("personalized jewel");
            jewel.setDisponibilita(1);
            jewel.setIVA(22);
            jewel.setPrezzo(result);
            jewel.setDescrizione(request.getParameter("description"));
            jewel.setMateriale(request.getParameter("material"));
            jewel.setSconto(0);
            jewel.setPersonalizzato(true);

            try {
                id = model.doSave(jewel);
            } catch (SQLException e) {
                LOGGER.log( Level.SEVERE, e.toString(), e );
            }
        }
        
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cart?action=add&id=" + id);
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        doGet(request, response);
    }
}