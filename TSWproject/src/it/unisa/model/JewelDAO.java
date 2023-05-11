package it.unisa.model;

import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class JewelDAO {
  private static final String TABLE = "Prodotto";
  
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
  
  public JewelDAO(){
    //costruttore vuoto
  }
  
  public synchronized void doSave(JewelBean jewel) throws SQLException{
    //SALVARE NEL DATABASE
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    
    String insertSQL = "INSERT INTO " + JewelDAO.TABLE
                       + " (nome, categoria, pietra, immagine, disponibilita, IVA, prezzo, descrizione, materiale, sconto, personalizzato) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try {
      connection = ds.getConnection();
      preparedStatement = connection.prepareStatement(insertSQL);
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

      connection.commit();
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
  
  public synchronized JewelBean doRetrieveByKey(int id) throws SQLException{
    //PRENDE UN GIOIELLO DAL SUO ID
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    String selectSQL = "SELECT * FROM " + JewelDAO.TABLE + " WHERE id_prodotto = ?";
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
    
    String deleteSQL = "DELETE FROM " + JewelDAO.TABLE + " WHERE id_prodotto = ?";
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
    
    String selectSQL = "SELECT * FROM " + JewelDAO.TABLE;
    
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
    
    String updateSQL = "UPDATE "+ JewelDAO.TABLE+ " SET nome = ?, categoria = ?, pietra = ?, immagine = ?, disponibilita = ?, IVA = ?, prezzo = ?, descrizione = ?, materiale = ?, sconto = ?, personalizzato = ? " + "WHERE id_prodotto = ?";
    
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
  
}