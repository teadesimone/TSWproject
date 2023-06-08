package it.unisa.model;
import java.sql.Date;
import java.util.*;

public class OrderBean { 
    
    private ArrayList<OrderProductBean> products;
    private int id;
    private ClientBean client;
    private float prezzo_totale;
    private String destinatario;
    private String metodo_di_pagamento;
    private String indirizzo_di_spedizione;
    private String numero_di_tracking;
    private String note;
    private Date data;
    private String metodo_di_spedizione;
    private boolean confezione_regalo;
    
   
    //costruttore per le inizializzazioni nulle
    public OrderBean() {
        products = new ArrayList<OrderProductBean>();
        this.id = 0;
        this.client = null;
        this.prezzo_totale = 0;
        this.destinatario = null; 
        this.metodo_di_pagamento = null;
        this.indirizzo_di_spedizione = null;
        this.numero_di_tracking = null;
        this.note = null;
        this.data = null;
        this.metodo_di_spedizione = null;
        this.confezione_regalo = false;
    }
    
    //costruttore con prodotti pronti
    public OrderBean(ArrayList<OrderProductBean> products) {
        setProducts(products);
        this.id = 0;
        this.client = null;
        this.prezzo_totale = 0;
        this.destinatario = null;
        this.metodo_di_pagamento = null;
        this.indirizzo_di_spedizione = null;
        this.numero_di_tracking = null;
        this.note = null;
        this.data = null;
        this.metodo_di_spedizione = null;
        this.confezione_regalo = false;
    }
    
    //costruttore con cliente pronto
    public OrderBean(ClientBean client) {
        products = new ArrayList<OrderProductBean>();
        this.id = 0;
        setClient(client);
        this.prezzo_totale = 0;
        this.destinatario = null;
        this.metodo_di_pagamento = null;
        this.indirizzo_di_spedizione = null;
        this.numero_di_tracking = null;
        this.note = null;
        this.data = null;
        this.metodo_di_spedizione = null;
        this.confezione_regalo = false;
    }
    
    public ArrayList<OrderProductBean> getProducts(){
        return products;
    }
    
    public void setProducts(ArrayList<OrderProductBean> products){
        this.products = products;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public ClientBean getClient() {
        return client;
    }
    
    public void setClient(ClientBean client) {
        this.client = client;
    }
    
    public float getPrezzo_totale() {
        return prezzo_totale;
    }
    
    public void setPrezzo_totale(float prezzo_totale) {
        this.prezzo_totale = prezzo_totale;
    }
    
    public String getDestinatario() {
        return destinatario;
    }
    
    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }
    
    public String getMetodo_di_pagamento() {
        return metodo_di_pagamento;
    }
    
    public void setMetodo_di_pagamento(String metodo_di_pagamento) {
        this.metodo_di_pagamento = metodo_di_pagamento;
    }
    
    public String getIndirizzo_di_spedizione() {
        return indirizzo_di_spedizione;
    }
    
    public void setIndirizzo_di_spedizione(String indirizzo_di_spedizione) {
        this.indirizzo_di_spedizione = indirizzo_di_spedizione;
    }
    
    public String getNumero_di_tracking() {
        return numero_di_tracking;
    }
    
    public void setNumero_di_tracking(String numero_di_tracking) {
        this.numero_di_tracking = numero_di_tracking;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public Date getData() {
        return data;
    }
    
    public void setData(Date data) {
        this.data = data;
    }
    
    public String getMetodo_di_spedizione() {
        return metodo_di_spedizione;
    }
    
    public void setMetodo_di_spedizione(String metodo_di_spedizione) {
        this.metodo_di_spedizione = metodo_di_spedizione;
    }
    
    public boolean getConfezione_regalo() {
        return confezione_regalo;
    }
    
    public void setConfezione_regalo(boolean confezione_regalo) {
        this.confezione_regalo = confezione_regalo;
    }
}