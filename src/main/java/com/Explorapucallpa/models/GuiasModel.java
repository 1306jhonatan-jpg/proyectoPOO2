package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.beans.Guias;


public class GuiasModel extends Conexion{

    CallableStatement cs;
    ResultSet rs;
    
    /**
     * Lista todos los guias
     */
    public List<Guias> listarGuias() {
        try {
            ArrayList<Guias> guias = new ArrayList<>();
            String sql = "CALL sp_listarGuias()";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            rs = cs.executeQuery();
            
            while (rs.next()) {
            	Guias guia = new Guias();
                guia.setIdguia(rs.getInt("idguia"));
                guia.setNombreGuia(rs.getString("nombre_guia"));
                guia.setApellidoGuia(rs.getString("apellido_guia"));
                guia.setDniGuia(rs.getString("dni_guia"));
                guia.setPago(rs.getDouble("pago"));
                guia.setCelular(rs.getString("celular"));
                guia.setEmpresa(rs.getString("empresa"));
                
                guias.add(guia);
            }
            
            this.cerrarConexion();
            return guias;
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return null;
        }
    }

    /**
     * Inserta un nuevo guia
     */
    public int insertarGuia(Guias guia) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_insertarGuia(?,?,?,?,?,?)";
            
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setString(1, guia.getNombreGuia());
            cs.setString(2, guia.getApellidoGuia());
            cs.setString(3, guia.getDniGuia());
            cs.setDouble(4, guia.getPago());
            cs.setString(5, guia.getCelular());
            cs.setString(6, guia.getEmpresa());
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
     * Obtiene un guia por ID
     */
    public Guias obtenerGuia(int idGuia) {
    	Guias guia = new Guias();
        try {
            String sql = "CALL sp_obtenerGuia(?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idGuia);
            rs = cs.executeQuery();
            
            if (rs.next()) {
                guia.setIdguia(rs.getInt("idguia"));
                guia.setNombreGuia(rs.getString("nombre_guia"));
                guia.setApellidoGuia(rs.getString("apellido_guia"));
                guia.setDniGuia(rs.getString("dni_guia"));
                guia.setPago(rs.getDouble("pago"));
                guia.setCelular(rs.getString("celular"));
                guia.setEmpresa(rs.getString("empresa"));
            }
            this.cerrarConexion();
        } catch (Exception e) {
            e.printStackTrace();
            this.cerrarConexion();
            return null;
        }
        return guia;
    }

    /**
     * Modifica un guia
     */
    public int modificarGuia(Guias guia) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_modificarGuia(?,?,?,?,?,?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, guia.getIdguia());
            cs.setString(2, guia.getNombreGuia());
            cs.setString(3, guia.getApellidoGuia());
            cs.setString(4, guia.getDniGuia());
            cs.setDouble(5, guia.getPago());
            cs.setString(6, guia.getCelular());
            cs.setString(7, guia.getEmpresa());
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
     * Elimina un guia
     */
    public int eliminarGuia(int idGuia) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_eliminarGuia(?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idGuia);
            filasAfectadas = cs.executeUpdate();
            
            this.cerrarConexion();
            return filasAfectadas;
            
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return 0;
        }
    }
}
