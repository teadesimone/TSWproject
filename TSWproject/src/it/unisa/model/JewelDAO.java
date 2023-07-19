package it.unisa.model;

import java.util.logging.Level;
import java.util.logging.Logger;

import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class JewelDAO {
  
  private static final Logger LOGGER = Logger.getLogger(JewelDAO.class.getName() );
  private static final String TABLE = "Prodotto";
  
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
  
  public JewelDAO(){
    //costruttore vuoto
  }
  
  public synchronized int doSave(JewelBean jewel) throws SQLException{
    //SALVARE NEL DATABASE
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    int id = -1;
    
    String insertSQL = "INSERT INTO " + TABLE
                       + " (nome, categoria, pietra, immagine, disponibilita, IVA, prezzo, descrizione, materiale, sconto, personalizzato) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(insertSQL,Statement.RETURN_GENERATED_KEYS);
      preparedStatement.setString(1, jewel.getNome());
      preparedStatement.setString(2, jewel.getCategoria());
      preparedStatement.setString(3, jewel.getPietra());
      preparedStatement.setString(4, jewel.getImmagine());
      preparedStatement.setInt(5, jewel.getDisponibilita());
      preparedStatement.setFloat(6, jewel.getIVA());
      preparedStatement.setFloat(7, jewel.getPrezzo());
      preparedStatement.setString(8, jewel.getDescrizione());
      preparedStatement.setString(9, jewel.getMateriale());
      preparedStatement.setInt(10, jewel.getSconto());
      preparedStatement.setBoolean(11, jewel.getPersonalizzato());

      preparedStatement.executeUpdate();

      
      
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
  
  public synchronized JewelBean doRetrieveByKey(int id) throws SQLException{
    //PRENDE UN GIOIELLO DAL SUO ID
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    String selectSQL = "SELECT * FROM " + TABLE + " WHERE id_prodotto = ?";
    JewelBean jewel = new JewelBean();
    
    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);
      preparedStatement.setInt(1, id);

      ResultSet rs = preparedStatement.executeQuery();

      while (rs.next()) {
    
        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));
        
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
    return jewel;
  }
  
  public synchronized boolean doDelete(int id) throws SQLException{
    //ELIMINA UN GIOIELLO DAL DATABASE
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    
    int result = 0;
    
    String deleteSQL = "DELETE FROM " + TABLE + " WHERE id_prodotto = ?";
    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(deleteSQL);
      preparedStatement.setInt(1, id);

      result = preparedStatement.executeUpdate();

    } finally{
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
  
  public synchronized List<JewelBean> doRetrieveAll() throws SQLException{
    //PRENDE TUTTI I GIOIELLI
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    List<JewelBean> products = new ArrayList<JewelBean>();
    
    String selectSQL = "SELECT * FROM " + TABLE + " WHERE personalizzato = false";
    
    try{
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);
      
      ResultSet rs = preparedStatement.executeQuery();
      
      while(rs.next()){
        JewelBean jewel = new JewelBean();
        
        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));
        
        products.add(jewel);
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
  
  public synchronized ArrayList<JewelBean> doRetrieveAllLimit() throws SQLException{
    //PRENDE 10 GIOIELLI
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    ArrayList<JewelBean> products = new ArrayList<JewelBean>();

    String selectSQL = "SELECT * FROM " + TABLE + " WHERE personalizzato = false LIMIT 10";

    try{
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);

      ResultSet rs = preparedStatement.executeQuery();

      while(rs.next()){
        JewelBean jewel = new JewelBean();

        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));

        products.add(jewel);
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
  
  public synchronized boolean doModify(JewelBean jewel) throws SQLException{
    //MODIFICA UN GIOIELLO DAL SUO ID
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    
    int result = 0;
    
    String updateSQL = "UPDATE "+ TABLE+ " SET nome = ?, categoria = ?, pietra = ?, immagine = ?, disponibilita = ?, IVA = ?, prezzo = ?, descrizione = ?, materiale = ?, sconto = ?, personalizzato = ? " + "WHERE id_prodotto = ?";
    
    try{
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(updateSQL);

      preparedStatement.setString(1, jewel.getNome());
      preparedStatement.setString(2, jewel.getCategoria());
      preparedStatement.setString(3, jewel.getPietra());
      preparedStatement.setString(4, jewel.getImmagine());
      preparedStatement.setInt(5, jewel.getDisponibilita());
      preparedStatement.setFloat(6, jewel.getIVA());
      preparedStatement.setFloat(7, jewel.getPrezzo());
      preparedStatement.setString(8, jewel.getDescrizione());
      preparedStatement.setString(9, jewel.getMateriale());
      preparedStatement.setInt(10, jewel.getSconto());
      preparedStatement.setBoolean(11, jewel.getPersonalizzato());
      preparedStatement.setInt(12, jewel.getId());

      preparedStatement.executeUpdate();
      
    } finally{
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
  
  public synchronized ArrayList<JewelBean> doRetrieveAllByCategory(String category) throws SQLException {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    

    String selectSQL = "SELECT * FROM " + TABLE + " WHERE categoria = ? AND personalizzato=false";

    ArrayList<JewelBean> beans = new ArrayList<JewelBean>();

    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);
      preparedStatement.setString(1, category);

      ResultSet rs = preparedStatement.executeQuery();

      while (rs.next()) {
        JewelBean jewel = new JewelBean();
        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));
        
        beans.add(jewel);
      }
    } 
    finally {
      try {
        if (preparedStatement != null)
          preparedStatement.close();
      } 
      finally {
        if (connection != null)
          connection.close();
      }
    }
    return beans;
  }
  
  public synchronized ArrayList<JewelBean> doRetrieveAllByGemstone(String gemstone) throws SQLException {
    Connection connection = null;
    PreparedStatement preparedStatement = null;


    String selectSQL = "SELECT * FROM " + TABLE + " WHERE pietra = ? AND personalizzato=false";

    ArrayList<JewelBean> beans = new ArrayList<JewelBean>();

    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);
      preparedStatement.setString(1, gemstone);

      ResultSet rs = preparedStatement.executeQuery();

      while (rs.next()) {
        JewelBean jewel = new JewelBean();
        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));

        beans.add(jewel);
      }
    } 
    finally {
      try {
        if (preparedStatement != null)
          preparedStatement.close();
      } 
      finally {
        if (connection != null)
          connection.close();
      }
    }
    return beans;
  }
  
  public synchronized void updateQuantity (int id, int newQuantity) throws SQLException {  

    Connection connection = null;
    PreparedStatement preparedStatement = null; 

    String updateSQL = "UPDATE " + TABLE + " SET disponibilita = ? WHERE id_prodotto = ?";  

    try {
      connection = ds.getConnection(); 
      preparedStatement = connection.prepareStatement(updateSQL);
      preparedStatement.setInt(1, newQuantity);
      preparedStatement.setInt(2, id);

      preparedStatement.executeUpdate(); 

      
    }

    finally {
      try {
        if (preparedStatement != null)
          preparedStatement.close();
      } 

      finally {
        if (connection != null)
          connection.close();
      }
    }
  }
  
  public synchronized ArrayList<JewelBean> doRetrieveAllByKeyword(String keyword, String query) throws SQLException {
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    String selectSQL = "SELECT * FROM " + TABLE + " WHERE personalizzato = false AND descrizione LIKE " + "'%" + keyword + "%'" + query;

    ArrayList<JewelBean> beans = new ArrayList<JewelBean>();

    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);

      ResultSet rs = preparedStatement.executeQuery();

      while (rs.next()) {
         JewelBean jewel = new JewelBean();
        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));

        beans.add(jewel);
      }
    } 
    finally {
      try {
        if (preparedStatement != null)
          preparedStatement.close();
      } 
      finally {
        if (connection != null)
          connection.close();
      }
    }
    return beans;
  }
  
  public synchronized ArrayList<JewelBean> doRetrieveAllByName(String keyword) throws SQLException {
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    String selectSQL = "SELECT * FROM " + TABLE + " WHERE personalizzato = false AND nome LIKE '" + keyword + "%'" ;

    ArrayList<JewelBean> beans = new ArrayList<JewelBean>();

    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(selectSQL);

      ResultSet rs = preparedStatement.executeQuery();

      while (rs.next()) {
        JewelBean jewel = new JewelBean();
        jewel.setId(rs.getInt("id_prodotto"));
        jewel.setNome(rs.getString("nome"));
        jewel.setCategoria(rs.getString("categoria"));
        jewel.setPietra(rs.getString("pietra"));
        jewel.setImmagine(rs.getString("immagine"));
        jewel.setDisponibilita(rs.getInt("disponibilita"));
        jewel.setIVA(rs.getFloat("IVA"));
        jewel.setPrezzo(rs.getFloat("prezzo"));
        jewel.setDescrizione(rs.getString("descrizione"));
        jewel.setMateriale(rs.getString("materiale"));
        jewel.setSconto(rs.getInt("sconto"));
        jewel.setPersonalizzato(rs.getBoolean("personalizzato"));

        beans.add(jewel);
      }
    } 
    finally {
      try {
        if (preparedStatement != null)
          preparedStatement.close();
      } 
      finally {
        if (connection != null)
          connection.close();
      }
    }
    return beans;
  }
  
  
}