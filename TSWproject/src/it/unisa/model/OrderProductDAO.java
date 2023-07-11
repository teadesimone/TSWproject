package it.unisa.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrderProductDAO {
    private static final String TABLE = "Composizione";

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/JadeTear");

        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }


    public OrderProductDAO(){
        //costruttore vuoto
    }

    public synchronized void doSave(OrderProductBean product) throws SQLException{
        //SALVARE NEL DATABASE
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + TABLE + " VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setInt(1, product.getId_ordine());
            preparedStatement.setInt(2, product.getId_prodotto());
            preparedStatement.setFloat(3, product.getPrezzo());
            preparedStatement.setInt(4, product.getQuantita());
            preparedStatement.setFloat(5, product.getIVA());


            preparedStatement.executeUpdate();

           // connection.commit();
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized ArrayList < OrderProductBean > doRetrieveByKey(int id_ordine) throws SQLException{
        //TROVA TUTTI I COLLEGAMENTI IN "COMPOSIZIONE" IN BASE ALL'ID DELL'ORDINE
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        ArrayList < OrderProductBean > products = new ArrayList < OrderProductBean > ();

        String selectSQL = "SELECT * FROM " + TABLE + " WHERE id = ?";
        

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id_ordine);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderProductBean product = new OrderProductBean();
                
                product.setId_ordine(rs.getInt("id"));
                product.setId_prodotto(rs.getInt("id_prodotto"));
                product.setPrezzo(rs.getFloat("prezzo"));
                product.setQuantita(rs.getInt("quantita"));
                product.setIVA(rs.getFloat("IVA"));
                
                products.add(product);


            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return products;
    }
}
