package com.Explorapucallpa.beans;

public class Guias {
    private int idguia;
    private String nombreGuia;
    private String apellidoGuia;
    private String dniGuia;
    private double pago;
    private String celular;
    private String empresa;
	
    public Guias() {
		super();
	}

	public Guias(int idguia, String nombreGuia, String apellidoGuia, String dniGuia, double pago, String celular,
			String empresa) {
		super();
		this.idguia = idguia;
		this.nombreGuia = nombreGuia;
		this.apellidoGuia = apellidoGuia;
		this.dniGuia = dniGuia;
		this.pago = pago;
		this.celular = celular;
		this.empresa = empresa;
	}

	public int getIdguia() {
		return idguia;
	}

	public void setIdguia(int idguia) {
		this.idguia = idguia;
	}

	public String getNombreGuia() {
		return nombreGuia;
	}

	public void setNombreGuia(String nombreGuia) {
		this.nombreGuia = nombreGuia;
	}

	public String getApellidoGuia() {
		return apellidoGuia;
	}

	public void setApellidoGuia(String apellidoGuia) {
		this.apellidoGuia = apellidoGuia;
	}

	public String getDniGuia() {
		return dniGuia;
	}

	public void setDniGuia(String dniGuia) {
		this.dniGuia = dniGuia;
	}

	public double getPago() {
		return pago;
	}

	public void setPago(double pago) {
		this.pago = pago;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getEmpresa() {
		return empresa;
	}

	public void setEmpresa(String empresa) {
		this.empresa = empresa;
	}

	
    
    
}
