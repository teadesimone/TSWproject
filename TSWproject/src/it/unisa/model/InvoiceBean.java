package it.unisa.model;

public class InvoiceBean {

    private String sdi;
    private float importo;
    private String data_scadenza;
    private String data_emissione;
    private String stato_pagamento;
    private float iva;
    private int id;

    public InvoiceBean() {
        //COSTRUTTORE VUOTO
    }

	public String getSdi() {
		return sdi;
	}

	public void setSdi(String sdi) {
		this.sdi = sdi;
	}

	public float getImporto() {
		return importo;
	}

	public void setImporto(float importo) {
		this.importo = importo;
	}

	public String getData_scadenza() {
		return data_scadenza;
	}

	public void setData_scadenza(String data_scadenza) {
		this.data_scadenza = data_scadenza;
	}

	public String getData_emissione() {
		return data_emissione;
	}

	public void setData_emissione(String data_emissione) {
		this.data_emissione = data_emissione;
	}

	public String getStato_pagamento() {
		return stato_pagamento;
	}

	public void setStato_pagamento(String stato_pagamento) {
		this.stato_pagamento = stato_pagamento;
	}

	public float getIva() {
		return iva;
	}

	public void setIva(float iva) {
		this.iva = iva;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	} 
    
    
}