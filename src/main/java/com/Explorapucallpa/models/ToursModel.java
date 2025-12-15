package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.beans.Tours;

public class ToursModel extends Conexion{

    CallableStatement cs;
    ResultSet rs;
    
    /**
     * Lista todos los tours
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
    
    /**
     * Inserta un nuevo tour
     */
    public int insertarTour(Tours tour ) {
    	try {
			int filasAfectadas=0;
			String sql = "CALL sp_insertarTours(?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, tour.getNombreTours());
			cs.setString(2, tour.getDescripcion());
			cs.setString(3, tour.getServicios());
			cs.setDate(4, tour.getFechaTours());
			cs.setString(5, tour.getDuracionTours());
			cs.setString(6, tour.getEstado());
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;
			
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
    }
    
    /**
     * Obtiene un tour por ID
     */
    
    public Tours obtenerTour(int idTours) {
    	Tours tour = new Tours();
    	try {
			String sql = "CALL sp_obtenerTours(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idTours);
			rs = cs.executeQuery();
			if (rs.next()) {
				tour.setIdTours(rs.getInt("idtours"));
            	tour.setNombreTours(rs.getString("nombre_tours"));
            	tour.setDescripcion(rs.getString("descripcion"));
            	tour.setServicios(rs.getString("servicios"));
            	tour.setFechaTours(rs.getDate("fecha_tours"));
            	tour.setDuracionTours(rs.getString("duracion_tours"));
            	tour.setEstado(rs.getString("estado"));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
            this.cerrarConexion();
            return null;		
            }
    	return tour;
    }
    
    /**
     * Modifica un tour
     */
    
    public int modificarTour(Tours tour) {
    	try {
    		int filasAfectadas=0;
    		String sql = "CALL sp_modificarTours(?,?,?,?,?,?,?)";
    		this.abrirConexion();
    		cs = conexion.prepareCall(sql);
    		cs.setInt(1, tour.getIdTours());
    		cs.setString(2, tour.getNombreTours());
			cs.setString(3, tour.getDescripcion());
			cs.setString(4, tour.getServicios());
			cs.setDate(5, tour.getFechaTours());
			cs.setString(6, tour.getDuracionTours());
			cs.setString(7, tour.getEstado());
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;
			
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
    }
    
    /**
     * Elimina un guia
     */
    
    public int eliminarTour(int idTour) {
    	try {
    		int filasAfectadas = 0;
            String sql = "CALL sp_eliminarTours(?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idTour);
            filasAfectadas = cs.executeUpdate();
            
            this.cerrarConexion();
            return filasAfectadas;
            
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return 0;
        }
    }
    
    /**
     * desactiva un tour
     */
    
    public int desactivarTour(int idTour) {
    	try {
			int filasAfectadas = 0;
			String sql= "CALL sp_desactivarTour(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idTour);
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;
			
		} catch (Exception e) {
			e.printStackTrace();
            this.cerrarConexion();
            return 0;
		}
    	
    }
}
