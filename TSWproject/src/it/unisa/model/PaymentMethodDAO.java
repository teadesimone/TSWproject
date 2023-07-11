package it.unisa.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class PaymentMethodDAO {
    
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
    private static final String TABLE_NAME = "Metodo_di_pagamento";

    public synchronized int doSave(PaymentMethodBean bean) throws SQLException {
        //SALVA NEL DATABASE UN'ISTANZA DELLA TABELLA METODO_DI_PAGAMENTO

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int id = -1;
        
        String insertSQL = "INSERT INTO " + TABLE_NAME + "(numero_carta, cvv, data_scadenza, circuito, username)" + 
                           " VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, bean.getNumero_carta());
            preparedStatement.setString(2, bean.getCvv());
            preparedStatement.setString(3, bean.getData_scadenza());
            preparedStatement.setString(4,bean.getCircuito()); 
            preparedStatement.setString(5, bean.getUsername());

            preparedStatement.executeUpdate();
            //connection.commit();
            
            ResultSet key = preparedStatement.getGeneratedKeys();

            while(key.next()) {
                id = key.getInt(1);
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

        return id;
    }
    
    public synchronized boolean doDelete(int id) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE id = ?";

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
    }

    public synchronized PaymentMethodBean doRetrieveByKey(int id) throws SQLException {
        //RITORNA UN PaymentMethodBean PRENDENDOLO IN BASE AL SUO ID
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        PaymentMethodBean bean = new PaymentMethodBean();
        
        String selectSQL = "SELECT * FROM " + TABLE_NAME + " where id = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                
                bean.setId(rs.getInt("id"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setCvv(rs.getString("cvv"));
                bean.setData_scadenza(rs.getString("data_scadenza"));
                bean.setCircuito(rs.getString("circuito")); 
                bean.setUsername(rs.getString("username"));
                
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


    public synchronized ArrayList<PaymentMethodBean> doRetrieveByClient(String username) throws SQLException {
        //PERMETTE AD UN CLIENTE DI PRENDERE TUTTI I SUOI PaymentMethodBean INSERITI (in base allo username)
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE username = ? ";

        ArrayList<PaymentMethodBean> beans = new ArrayList<PaymentMethodBean>();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                PaymentMethodBean bean = new PaymentMethodBean();

                bean.setId(rs.getInt("id"));
                bean.setNumero_carta(rs.getString("numero_carta"));
                bean.setCvv(rs.getString("cvv"));
                bean.setData_scadenza(rs.getString("data_scadenza"));
                bean.setCircuito(rs.getString("circuito")); 
                bean.setUsername(rs.getString("username"));
                
                beans.add(bean);
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
        return beans;
    }
    
}