package it.unisa.model;

import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class InvoiceDAO {
    
    private static final Logger LOGGER = Logger.getLogger(InvoiceDAO.class.getName() );
    private static final String TABLE = "Fattura";

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/JadeTear");

        } catch (NamingException e) {
            LOGGER.log( Level.SEVERE, e.toString(), e );
        }
    }

    public InvoiceDAO(){
        //costruttore vuoto
    }

    public synchronized void doSave(InvoiceBean invoice) throws SQLException{
        //SALVARE NEL DATABASE
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + TABLE
                           + " (sdi, importo, data_scadenza, data_emissione, stato_del_pagamento, IVA, id) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, invoice.getSdi());
            preparedStatement.setFloat(2, invoice.getImporto());
            preparedStatement.setString(3, invoice.getData_scadenza());
            preparedStatement.setString(4, invoice.getData_emissione());
            preparedStatement.setString(5, invoice.getStato_pagamento());
            preparedStatement.setFloat(6, invoice.getIva());
            preparedStatement.setInt(7, invoice.getId());

            preparedStatement.executeUpdate();

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

    public synchronized InvoiceBean doRetrieveByOrder(int id) throws SQLException{
        //RESTITUISCE UNA FATTURA DALL'ID DELL'ORDINE
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + TABLE + " WHERE id = ?";
        InvoiceBean invoice = new InvoiceBean();

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {

                invoice.setId(rs.getInt("id"));
                invoice.setSdi(rs.getString("sdi"));
                invoice.setImporto(rs.getFloat("importo"));
                invoice.setData_scadenza(rs.getString("data_scadenza"));
                invoice.setData_emissione(rs.getString("data_emissione"));
                invoice.setStato_pagamento(rs.getString("stato_del_pagamento"));
                invoice.setIva(rs.getFloat("IVA"));

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
        return invoice;
    }
}