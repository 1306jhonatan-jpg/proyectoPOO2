package com.Explorapucallpa.dto;

public class TourGuiaDTO {
	private int idreserva;
    private String nombre;
    private String fecha;
    private String tours;
    private String guia;

    public TourGuiaDTO(int idreserva, String nombre, String fecha, String tours, String guia) {
        this.idreserva = idreserva;
        this.nombre = nombre;
        this.fecha = fecha;
        this.tours = tours;
        this.guia = guia;
    }

    public int getIdreserva() {
        return idreserva;
    }

    public String getNombre() {
        return nombre;
    }

    public String getFecha() {
        return fecha;
    }

    public String getTours() {
        return tours;
    }

    public String getGuia() {
        return guia;
    }
}
