package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.beans.Tours;

public class ToursModel extends Conexion{

    CallableStatement cs;
    ResultSet rs;
    
    /**
     * Lista todos los guias
     */
    public List<Tours> listarTours(){
    	try {
			ArrayList<Tours> tours = new ArrayList<>();
			String sql = "CALL sp_listarTours()";
			this.abrirConexion();
            cs = conexion.prepareCall(sql);
            rs = cs.executeQuery();
            while (rs.next()) {
            	Tours tour = new Tours();
            	tour.setIdTours(rs.getInt("idtours"));
            	tour.setNombreTours(rs.getString("nombre_tours"));
            	tour.setDescripcion(rs.getString("descripcion"));
            	tour.setServicios(rs.getString("servicios"));
            	tour.setFechaTours(rs.getDate("fecha_tours"));
            	tour.setDuracionTours(rs.getString("duracion_tours"));
            	tour.setEstado(rs.getString("estado"));
            	tours.add(tour);
            	
            }
            this.cerrarConexion();
            return tours;
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
    }
    
}
