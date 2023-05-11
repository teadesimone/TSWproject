package it.unisa.model;

public class JewelBean {
  
  private int id;
  private String nome;
  private String categoria;
  private String pietra;
  private String immagine;
  private int disponibilita;
  private float IVA;
  private float prezzo;
  private String descrizione;
  private String materiale;
  private int sconto;
  private boolean personalizzato;
  
  public JewelBean(){
    //costruttore vuoto
  }
  
  public int getId(){
    return id;
  }
  
  public void setId(int id){
    this.id = id;
  }
  
  public String getNome(){
    return nome;  
  }
  
  public void setNome(String nome){
    this.nome = nome;
  }
  
  public String getCategoria(){
    return categoria;  
  }

  public void setCategoria(String categoria){
    this.categoria = categoria;
  }
  
  public String getPietra(){
    return pietra;  
  }

  public void setPietra(String pietra){
    this.pietra = pietra;
  }
  
  public String getImmagine(){
    return immagine;  
  }

  public void setImmagine(String immagine){
    this.immagine = immagine;
  }
  
  public int getDisponibilita(){
    return disponibilita;  
  }

  public void setDisponibilita(int disponibilita){
    this.disponibilita = disponibilita;
  }
  
  public float getIVA(){
    return IVA;
  }

  public void setIVA(float IVA){
    this.IVA = IVA;
  }
  
  public float getPrezzo(){
    return prezzo;  
  }

  public void setPrezzo(float prezzo){
    this.prezzo = prezzo;
  }
  
  public String getDescrizione(){
    return descrizione;  
  }

  public void setDescrizione(String descrizione){
    this.descrizione = descrizione;
  }
  
  public String getMateriale(){
    return materiale;  
  }

  public void setMateriale(String materiale){
    this.materiale = materiale;
  }
  
  public int getSconto(){
    return sconto;  
  }

  public void setSconto(int sconto){
    this.sconto = sconto;
  }
  
  public boolean getPersonalizzato(){
    return personalizzato;  
  }

  public void setPersonalizzato(boolean personalizzato){
    this.personalizzato = personalizzato;
  }
  
}