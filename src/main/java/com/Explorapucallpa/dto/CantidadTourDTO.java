package com.Explorapucallpa.dto;

public class CantidadTourDTO {
     private String tours;
     private int cantidad;
     
	 public CantidadTourDTO(String tours, int cantidad) {
		this.tours = tours;
		this.cantidad = cantidad;
	 }

	 public String getTours() {
		 return tours;
	 }

	 public void setTours(String tours) {
		 this.tours = tours;
	 }

	 public int getCantidad() {
		 return cantidad;
	 }

	 public void setCantidad(int cantidad) {
		 this.cantidad = cantidad;
	 }
     
     
}
