package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.dto.CantidadTourDTO;
import com.Explorapucallpa.dto.TourGuiaDTO;





public class reporteModel extends Conexion{
	CallableStatement cs;
    ResultSet rs;
	public List<CantidadTourDTO> obtenerCantidadTours() {

		try {
			ArrayList<CantidadTourDTO> t = new ArrayList<>();
			String sql = "CALL sp_obtenerCantidadTours()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				t.add(new CantidadTourDTO(rs.getString("tour"), rs.getInt("veces_reservado")));
			}

			this.cerrarConexion();
			return t;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		

	}
	
	public List<TourGuiaDTO> obtenerTourGuia() {

	    List<TourGuiaDTO> lista = new ArrayList<>();

	    try {
	        String sql = "CALL sp_obtenerToursGuia()";
	        this.abrirConexion();

	        cs = conexion.prepareCall(sql);
	        rs = cs.executeQuery();

	        while (rs.next()) {
	            lista.add(new TourGuiaDTO(
	                rs.getInt("idreserva"),
	                rs.getString("nombre"),
	                rs.getString("fecha"),
	                rs.getString("tours"),
	                rs.getString("guia")
	            ));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // 🔒 CIERRE SEGURO DE RECURSOS
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (cs != null) cs.close(); } catch (Exception e) {}
	        this.cerrarConexion();
	    }

	    return lista;
	}


}
