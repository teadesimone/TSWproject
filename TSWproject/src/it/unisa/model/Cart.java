package it.unisa.model;

import java.util.ArrayList;


public class Cart {

	private ArrayList<CartProduct> products;
	
	public Cart() {
		products = new ArrayList<CartProduct>();
	}
	
	public void addProduct(JewelBean product) {
		
		int i, pos = -1;
		for (i = 0; i<products.size(); i++) {
			if (products.get(i).getProduct().getId() == product.getId()) {
				pos = i;
				break;
			}
		}
		
		//Elemento non presente nel carrello
		if (pos == -1) {
			CartProduct p = new CartProduct(product);
			this.products.add(p);
		}
		
		//Elemento presente
		else {
			CartProduct p = this.products.get(pos);
			p.setQuantity(p.getQuantity() + 1);
		}
		
	}
	
	public void changeQuantity (JewelBean product, int quantity) {
		for(CartProduct c : products) {
			if(c.getProduct().getId() == product.getId()) {
				c.setQuantity(quantity);
				break;
			}
		}
	}
	
	public void removeProduct(JewelBean product) {
		for(CartProduct c : products) {
			if(c.getProduct().getId() == product.getId()) {
				products.remove(c);
				break;
			}
		}
 	}
	
	public ArrayList<CartProduct> getProducts() {
		return products;
	}
}
