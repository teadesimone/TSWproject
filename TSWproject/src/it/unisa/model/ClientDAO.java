package it.unisa.model;

import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ClientDAO {
    
    private static final Logger LOGGER = Logger.getLogger(ClientDAO.class.getName() );
    private static final String TABLE = "Cliente";

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

    public ClientDAO(){
        //costruttore vuoto
    }

    public synchronized int doSave(ClientBean client) throws SQLException{
        //SALVA NEL DATABASE
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result = 0;

        String insertSQL = "INSERT INTO " + ClientDAO.TABLE
                           + " (username, psw, cf, nome, cognome, via, citta, provincia, cap, telefono, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, client.getUsername());
            preparedStatement.setString(2, client.getPassword());
            preparedStatement.setString(3, client.getCf());
            preparedStatement.setString(4, client.getNome());
            preparedStatement.setString(5, client.getCognome());
            preparedStatement.setString(6, client.getVia());
            preparedStatement.setString(7, client.getCitta());
            preparedStatement.setString(8, client.getProvincia());
            preparedStatement.setString(9, client.getCap());
            preparedStatement.setString(10, client.getTelefono());
            preparedStatement.setString(11, client.getEmail());

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
        return result;
    }

    public synchronized ClientBean doRetrieveByEmailAndPassword(String email, String password) throws SQLException{
        //PRENDE UN UTENTE DAL SUO EMAIL E PASSWORD
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + ClientDAO.TABLE + " WHERE email=? AND psw=SHA1(?)";
        ClientBean client = null;
        

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet rs = preparedStatement.executeQuery();
            
           

            while (rs.next()) {
            	
            	client = new ClientBean();

                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setVia(rs.getString("via"));
                client.setCitta(rs.getString("citta"));
                client.setProvincia(rs.getString("provincia"));
                client.setCap(rs.getString("cap"));
                client.setTelefono(rs.getString("telefono"));
                client.setEmail(rs.getString("email"));
                client.setPassword(rs.getString("psw"));

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
        
        
        return client;
    }
    
    public synchronized ClientBean doRetrieveByKey(String username) throws SQLException{
        //PRENDE UN UTENTE DAL SUO USERNAME
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + ClientDAO.TABLE + " WHERE username=?";
        ClientBean client = null;
        

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, username);

            ResultSet rs = preparedStatement.executeQuery();
            
           

            while (rs.next()) {
            	
            	client = new ClientBean();

                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setVia(rs.getString("via"));
                client.setCitta(rs.getString("citta"));
                client.setProvincia(rs.getString("provincia"));
                client.setCap(rs.getString("cap"));
                client.setTelefono(rs.getString("telefono"));
                client.setEmail(rs.getString("email"));
                client.setPassword(rs.getString("psw"));

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
        
        
        return client;
    }
    
    public synchronized int doModify(ClientBean client) throws SQLException{
        //SALVA LE MODIFICHE NEL DATABASE
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result = 0;

        String updateSQL = "UPDATE "+ TABLE+ " SET  cf = ?, nome = ?, cognome = ?, via = ?, citta = ?, provincia = ?, cap = ?, telefono = ?, email = ? " + "WHERE username = ?";
        

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setString(1, client.getCf());
            preparedStatement.setString(2, client.getNome());
            preparedStatement.setString(3, client.getCognome());
            preparedStatement.setString(4, client.getVia());
            preparedStatement.setString(5, client.getCitta());
            preparedStatement.setString(6, client.getProvincia());
            preparedStatement.setString(7, client.getCap());
            preparedStatement.setString(8, client.getTelefono());
            preparedStatement.setString(9, client.getEmail());
            preparedStatement.setString(10, client.getUsername());

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
        return result;
    }
    
    public synchronized ClientBean doRetrieveByEmail(String email) throws SQLException{
        //PRENDE UN UTENTE DAL SUO EMAIL E PASSWORD
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String selectSQL = "SELECT * FROM " + ClientDAO.TABLE + " WHERE email=?";
        ClientBean client = null;


        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);
            

            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {

                client = new ClientBean();

                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setVia(rs.getString("via"));
                client.setCitta(rs.getString("citta"));
                client.setProvincia(rs.getString("provincia"));
                client.setCap(rs.getString("cap"));
                client.setTelefono(rs.getString("telefono"));
                client.setEmail(rs.getString("email"));
                client.setPassword(rs.getString("psw"));

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


        return client;
    }
    
    public synchronized ArrayList < ClientBean > doRetrieveAll() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList < ClientBean > clients = new ArrayList < ClientBean > ();
     

        String selectSQL = "SELECT * FROM " + TABLE + " WHERE username <> 'JadeTear'" ;
        
        ClientBean client = null;

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	
                client = new ClientBean();

                client.setUsername(rs.getString("username"));
                client.setCf(rs.getString("cf"));
                client.setNome(rs.getString("nome"));
                client.setCognome(rs.getString("cognome"));
                client.setVia(rs.getString("via"));
                client.setCitta(rs.getString("citta"));
                client.setProvincia(rs.getString("provincia"));
                client.setCap(rs.getString("cap"));
                client.setTelefono(rs.getString("telefono"));
                client.setEmail(rs.getString("email"));
                client.setPassword(rs.getString("psw"));

                clients.add(client);
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
        return clients;
    }
}
