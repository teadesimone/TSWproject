package it.unisa.model;

public class CartProduct {
  
    private JewelBean product;
    private int quantity;
    
    public CartProduct(JewelBean product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    
    public CartProduct (JewelBean product) {
        this.product = product;
        this.quantity = 1;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public int getQuantity () {
        return quantity;
    }
    
    public JewelBean getProduct() {
        return product;
    }
    
}