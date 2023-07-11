package it.unisa.model;

public class OrderProductBean {
    
    private int id_ordine;
    private int id_prodotto;
    private float prezzo;
    private int quantita;
    private float IVA;
    
    public OrderProductBean(){
        //costruttore vuoto
    }
    
    public int getId_ordine(){
        return id_ordine;
    }
    
    public void setId_ordine(int id_ordine){
        this.id_ordine = id_ordine;
    }
    
    public int getId_prodotto(){
        return id_prodotto;
    }
    
    public void setId_prodotto(int id_prodotto){
        this.id_prodotto = id_prodotto;
    }
    
    public float getPrezzo(){
        return prezzo;
    }
    
    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
    }
    
    public int getQuantita() {
        return quantita;
    }
    
    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }
            
    public float getIVA() {
        return IVA;
    }
    
    public void setIVA(float IVA) {
        this.IVA = IVA;
    }
}