package it.unisa.model;

public class PaymentMethodBean {
	
	private int id;
	private String numero_carta;
	private String cvv;
	private String data_scadenza;
	private String circuito;
	private String username;
	
	public PaymentMethodBean() {
		//costruttore vuoto
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumero_carta() {
		return numero_carta;
	}

	public void setNumero_carta(String numero_carta) {
		this.numero_carta = numero_carta;
	}

	public String getCvv() {
		return cvv;
	}

	public void setCvv(String cvv) {
		this.cvv = cvv;
	}

	public String getData_scadenza() {
		return data_scadenza;
	}

	public void setData_scadenza(String data_scadenza) {
		this.data_scadenza = data_scadenza;
	}

	public String getCircuito() {
		return circuito;
	}

	public void setCircuito(String circuito) {
		this.circuito = circuito;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	@Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (!(obj instanceof PaymentMethodBean)) {
            return false;
        }

        PaymentMethodBean other = (PaymentMethodBean) obj;
        return this.getId() == other.getId();
    }
}
