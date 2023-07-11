package it.unisa.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class OrderDAO {

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
    private static final String TABLE_NAME = "Ordine";

    public synchronized void doSave(OrderBean order) throws SQLException {
        //SALVA NEL DATABASE UN'ISTANZA DELLA TABELLA ORDINE E DELLA RELAZIONE COMPOSIZIONE

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        OrderProductDAO model = new OrderProductDAO();


        String insertSQL = "INSERT INTO " + TABLE_NAME +
                           " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setInt(1, order.getId());
            preparedStatement.setString(2, order.getClient().getUsername());
            preparedStatement.setFloat(3, order.getPrezzo_totale());
            preparedStatement.setString(4, order.getDestinatario());
            preparedStatement.setString(5,order.getMetodo_di_pagamento());
            preparedStatement.setString(6, order.getCircuito());
            preparedStatement.setString(7, order.getNumero_carta());
            preparedStatement.setString(8, order.getIndirizzo_di_spedizione());
            preparedStatement.setString(9, order.getNumero_di_tracking());
            preparedStatement.setString(10, order.getNote());
            preparedStatement.setDate(11, order.getData());
            preparedStatement.setString(12, order.getMetodo_di_spedizione());
            preparedStatement.setBoolean(13, order.getConfezione_regalo());

            preparedStatement.executeUpdate();
            //connection.commit();
            
            for (OrderProductBean prodotto : (ArrayList<OrderProductBean>) order.getProducts()){
                model.doSave(prodotto);
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
        
       
    }

    public synchronized OrderBean doRetrieveByKey(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        OrderProductDAO ordermodel = new OrderProductDAO();
        ArrayList<OrderProductBean> products = ordermodel.doRetrieveByKey(id); 
        
        ClientDAO userModel = new ClientDAO(); 
        
        OrderBean bean = new OrderBean(products);

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " where id = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
               bean.setId(rs.getInt("id"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("username")) );
                bean.setPrezzo_totale(rs.getFloat("prezzo_totale"));
                bean.setDestinatario(rs.getString("destinatario"));
                bean.setMetodo_di_pagamento(rs.getString("metodo_di_pagamento"));
                bean.setCircuito(rs.getString("circuito"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setIndirizzo_di_spedizione(rs.getString("indirizzo_di_spedizione"));
                bean.setNumero_di_tracking(rs.getString("numero_di_tracking"));
                bean.setNote(rs.getString("note"));
                bean.setData(rs.getDate("data"));
                bean.setMetodo_di_spedizione(rs.getString("metodo_di_spedizione"));
                bean.setConfezione_regalo(rs.getBoolean("confezione_regalo"));
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
        
        
        return bean;
    }

    public synchronized OrderBean lastOrder() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ClientDAO userModel = new ClientDAO(); 
        
        OrderBean bean = new OrderBean();

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " ORDER BY id DESC LIMIT 1";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                bean.setId(rs.getInt("id"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("username")) );
                bean.setPrezzo_totale(rs.getFloat("prezzo_totale"));
                bean.setDestinatario(rs.getString("destinatario"));
                bean.setMetodo_di_pagamento(rs.getString("metodo_di_pagamento"));
                bean.setCircuito(rs.getString("circuito"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setIndirizzo_di_spedizione(rs.getString("indirizzo_di_spedizione"));
                bean.setNumero_di_tracking(rs.getString("numero_di_tracking"));
                bean.setNote(rs.getString("note"));
                bean.setData(rs.getDate("data"));
                bean.setMetodo_di_spedizione(rs.getString("metodo_di_spedizione"));
                bean.setConfezione_regalo(rs.getBoolean("confezione_regalo"));
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
        return bean;
    } 

    public synchronized ArrayList<OrderBean> doRetrieveByClient(String username) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ClientDAO userModel = new ClientDAO(); 
        

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " where username = ? ORDER BY id DESC";

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("id"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("username")) );
                bean.setPrezzo_totale(rs.getFloat("prezzo_totale"));
                bean.setDestinatario(rs.getString("destinatario"));
                bean.setMetodo_di_pagamento(rs.getString("metodo_di_pagamento"));
                bean.setCircuito(rs.getString("circuito"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setIndirizzo_di_spedizione(rs.getString("indirizzo_di_spedizione"));
                bean.setNumero_di_tracking(rs.getString("numero_di_tracking"));
                bean.setNote(rs.getString("note"));
                bean.setData(rs.getDate("data"));
                bean.setMetodo_di_spedizione(rs.getString("metodo_di_spedizione"));
                bean.setConfezione_regalo(rs.getBoolean("confezione_regalo"));

                orders.add(bean);
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
        return orders;
    }

    public synchronized ArrayList<OrderBean> ClientDateOrders(String username, String data_da, String data_a) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ClientDAO userModel = new ClientDAO(); 
        

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " where username = ? and data >= ? and data <= ? ORDER BY id DESC";

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, data_da);
            preparedStatement.setString(3, data_a);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("id"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("username")) );
                bean.setPrezzo_totale(rs.getFloat("prezzo_totale"));
                bean.setDestinatario(rs.getString("destinatario"));
                bean.setMetodo_di_pagamento(rs.getString("metodo_di_pagamento"));
                bean.setCircuito(rs.getString("circuito"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setIndirizzo_di_spedizione(rs.getString("indirizzo_di_spedizione"));
                bean.setNumero_di_tracking(rs.getString("numero_di_tracking"));
                bean.setNote(rs.getString("note"));
                bean.setData(rs.getDate("data"));
                bean.setMetodo_di_spedizione(rs.getString("metodo_di_spedizione"));
                bean.setConfezione_regalo(rs.getBoolean("confezione_regalo"));

                orders.add(bean);
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

        return orders;
    }

    public synchronized ArrayList<OrderBean> DateOrders(String data_da, String data_a) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ClientDAO userModel = new ClientDAO(); 
       

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " where data >= ? and data <= ? ORDER BY id DESC";

        ArrayList<OrderBean> orders = new ArrayList<OrderBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, data_da);
            preparedStatement.setString(2, data_a);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

              bean.setId(rs.getInt("id"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("username")) );
                bean.setPrezzo_totale(rs.getFloat("prezzo_totale"));
                bean.setDestinatario(rs.getString("destinatario"));
                bean.setMetodo_di_pagamento(rs.getString("metodo_di_pagamento"));
                bean.setCircuito(rs.getString("circuito"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setIndirizzo_di_spedizione(rs.getString("indirizzo_di_spedizione"));
                bean.setNumero_di_tracking(rs.getString("numero_di_tracking"));
                bean.setNote(rs.getString("note"));
                bean.setData(rs.getDate("data"));
                bean.setMetodo_di_spedizione(rs.getString("metodo_di_spedizione"));
                bean.setConfezione_regalo(rs.getBoolean("confezione_regalo"));

                orders.add(bean);
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
    

        return orders;
    }


    /*
    public synchronized boolean doDelete(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String deleteSQL = "DELETE * FROM " + TABLE_NAME + "where id = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(deleteSQL);
            preparedStatement.setInt(1, id);

            result = preparedStatement.executeUpdate();

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        return (result != 0);
    }*/



    public synchronized ArrayList < OrderBean > doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList < OrderBean > orders = new ArrayList < OrderBean > ();

        ClientDAO userModel = new ClientDAO();
        
        String selectSQL = "SELECT * FROM " + TABLE_NAME;
       

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

              bean.setId(rs.getInt("id"));
                bean.setClient(userModel.doRetrieveByKey(rs.getString("username")) );
                bean.setPrezzo_totale(rs.getFloat("prezzo_totale"));
                bean.setDestinatario(rs.getString("destinatario"));
                bean.setMetodo_di_pagamento(rs.getString("metodo_di_pagamento"));
                bean.setCircuito(rs.getString("circuito"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setIndirizzo_di_spedizione(rs.getString("indirizzo_di_spedizione"));
                bean.setNumero_di_tracking(rs.getString("numero_di_tracking"));
                bean.setNote(rs.getString("note"));
                bean.setData(rs.getDate("data"));
                bean.setMetodo_di_spedizione(rs.getString("metodo_di_spedizione"));
                bean.setConfezione_regalo(rs.getBoolean("confezione_regalo"));


                orders.add(bean);
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
        return orders;
    }
}
