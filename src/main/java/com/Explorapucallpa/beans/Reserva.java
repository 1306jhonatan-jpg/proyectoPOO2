package com.Explorapucallpa.beans;

import java.sql.Date;

public class Reserva {
	
	 	private int idreserva;
	    private int cantidadAdulto;
	    private int cantidadNino;
	    private Date fechaReserva;
	    private double precioAdulto;
	    private double precioNino;
	    private double totalReserva;
	    private int toursIdtours;
	    private int guiaIdguia;
	    private int pagoIdpago;
	    private int clienteIdcliente;
		public Reserva() {
			super();
		}
		public Reserva(int idreserva, int cantidadAdulto, int cantidadNino, Date fechaReserva, double precioAdulto,
				double precioNino, double totalReserva, int toursIdtours, int guiaIdguia, int pagoIdpago,
				int clienteIdcliente) {
			super();
			this.idreserva = idreserva;
			this.cantidadAdulto = cantidadAdulto;
			this.cantidadNino = cantidadNino;
			this.fechaReserva = fechaReserva;
			this.precioAdulto = precioAdulto;
			this.precioNino = precioNino;
			this.totalReserva = totalReserva;
			this.toursIdtours = toursIdtours;
			this.guiaIdguia = guiaIdguia;
			this.pagoIdpago = pagoIdpago;
			this.clienteIdcliente = clienteIdcliente;
		}
		public int getIdreserva() {
			return idreserva;
		}
		public void setIdreserva(int idreserva) {
			this.idreserva = idreserva;
		}
		public int getCantidadAdulto() {
			return cantidadAdulto;
		}
		public void setCantidadAdulto(int cantidadAdulto) {
			this.cantidadAdulto = cantidadAdulto;
		}
		public int getCantidadNino() {
			return cantidadNino;
		}
		public void setCantidadNino(int cantidadNino) {
			this.cantidadNino = cantidadNino;
		}
		public Date getFechaReserva() {
			return fechaReserva;
		}
		public void setFechaReserva(Date fechaReserva) {
			this.fechaReserva = fechaReserva;
		}
		public double getPrecioAdulto() {
			return precioAdulto;
		}
		public void setPrecioAdulto(double precioAdulto) {
			this.precioAdulto = precioAdulto;
		}
		public double getPrecioNino() {
			return precioNino;
		}
		public void setPrecioNino(double precioNino) {
			this.precioNino = precioNino;
		}
		public double getTotalReserva() {
			return totalReserva;
		}
		public void setTotalReserva(double totalReserva) {
			this.totalReserva = totalReserva;
		}
		public int getToursIdtours() {
			return toursIdtours;
		}
		public void setToursIdtours(int toursIdtours) {
			this.toursIdtours = toursIdtours;
		}
		public int getGuiaIdguia() {
			return guiaIdguia;
		}
		public void setGuiaIdguia(int guiaIdguia) {
			this.guiaIdguia = guiaIdguia;
		}
		public int getPagoIdpago() {
			return pagoIdpago;
		}
		public void setPagoIdpago(int pagoIdpago) {
			this.pagoIdpago = pagoIdpago;
		}
		public int getClienteIdcliente() {
			return clienteIdcliente;
		}
		public void setClienteIdcliente(int clienteIdcliente) {
			this.clienteIdcliente = clienteIdcliente;
		}
	    
	    
}
