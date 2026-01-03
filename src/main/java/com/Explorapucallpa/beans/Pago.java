package com.Explorapucallpa.beans;

public class Pago {
	
	private int idpago;
	private String metodoPago;
	private String estadoPago;
	public Pago() {
		super();
	}
	public Pago(int idpago, String metodoPago, String estadoPago) {
		super();
		this.idpago = idpago;
		this.metodoPago = metodoPago;
		this.estadoPago = estadoPago;
	}
	public int getIdpago() {
		return idpago;
	}
	public void setIdpago(int idpago) {
		this.idpago = idpago;
	}
	public String getMetodoPago() {
		return metodoPago;
	}
	public void setMetodoPago(String metodoPago) {
		this.metodoPago = metodoPago;
	}
	public String getEstadoPago() {
		return estadoPago;
	}
	public void setEstadoPago(String estadoPago) {
		this.estadoPago = estadoPago;
	}
	
	
}
