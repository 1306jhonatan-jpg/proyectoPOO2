package com.Explorapucallpa.beans;

import java.sql.Date;

public class Tours {
    private int idTours;
    private String nombreTours;
    private String descripcion;
    private String servicios;
    private Date fechaTours;
    private String duracionTours;
    private String estado;
	public Tours() {
		super();
	}
	public Tours(int idTours, String nombreTours, String descripcion, String servicios, Date fechaTours,
			String duracionTours, String estado) {
		super();
		this.idTours = idTours;
		this.nombreTours = nombreTours;
		this.descripcion = descripcion;
		this.servicios = servicios;
		this.fechaTours = fechaTours;
		this.duracionTours = duracionTours;
		this.estado = estado;
	}
	public int getIdTours() {
		return idTours;
	}
	public void setIdTours(int idTours) {
		this.idTours = idTours;
	}
	public String getNombreTours() {
		return nombreTours;
	}
	public void setNombreTours(String nombreTours) {
		this.nombreTours = nombreTours;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getServicios() {
		return servicios;
	}
	public void setServicios(String servicios) {
		this.servicios = servicios;
	}
	public Date getFechaTours() {
		return fechaTours;
	}
	public void setFechaTours(Date fechaTours) {
		this.fechaTours = fechaTours;
	}
	public String getDuracionTours() {
		return duracionTours;
	}
	public void setDuracionTours(String duracionTours) {
		this.duracionTours = duracionTours;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
    
    
}
