package it.unisa.model;

public class AddressBean {
	
	private int id;
	private String via;
	private String citta;
	private String CAP;
	private String username;
	
	public AddressBean() {
		//costruttore vuoto
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getVia() {
		return via;
	}
	
	public void setVia(String via) {
		this.via = via;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public void setCitta(String citta) {
		this.citta = citta;
	}
	
	public String getCAP() {
		return CAP;
	}
	
	public void setCAP(String CAP) {
		this.CAP = CAP;
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

        if (!(obj instanceof AddressBean)) {
            return false;
        }

        AddressBean other = (AddressBean) obj;
        return this.getId() == other.getId() && this.getUsername().equals(other.getUsername());
    }
	
}
