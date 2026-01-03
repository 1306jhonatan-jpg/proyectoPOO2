package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.beans.ClienteCargo;

public class ClienteCargoModel extends Conexion{

	CallableStatement cs;
    ResultSet rs;
    
    /**
     * Lista todos los clientes
     */
    public List<ClienteCargo> listarCliente(){
    	try {
			ArrayList<ClienteCargo> clientes = new ArrayList<>();
			String sql ="CALL sp_listarClientes()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while(rs.next()) {
				ClienteCargo cliente = new ClienteCargo();
				cliente.setIdCliente(rs.getInt("idcliente"));
				cliente.setNombre(rs.getString("nombre"));
				cliente.setApellido(rs.getString("apellido"));
				cliente.setEdad(rs.getInt("edad"));
				cliente.setDni(rs.getString("dni"));
				cliente.setCelular(rs.getString("celular"));
				cliente.setCorreo(rs.getString("correo"));
				clientes.add(cliente);
			}
			this.cerrarConexion();
			return clientes;
		} catch (Exception e) {
			e.printStackTrace();
            this.cerrarConexion();
            return null;
		}
    }
    
    /**
     * Inserta un nuevo Cliente
     */
    public int insertarCliente(ClienteCargo clientes) {
    	try {
			int filasAfectadas =0;
			String sql = "CALL sp_insertarClientes(?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, clientes.getNombre());
			cs.setString(2, clientes.getApellido());
			cs.setInt(3, clientes.getEdad());
			cs.setString(4, clientes.getDni());
			cs.setString(5, clientes.getCelular());
			cs.setString(6, clientes.getCorreo());
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
     * Obtiene un Cliente por ID
     */
    public ClienteCargo obtenerCliente(int idCliente) {
    	ClienteCargo cliente = new ClienteCargo();
    	try {
			String sql = "CALL sp_obtenerCliente(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idCliente);
			rs = cs.executeQuery();
			
			if (rs.next()) {
				cliente.setIdCliente(rs.getInt("idcliente"));
				cliente.setNombre(rs.getString("nombre"));
				cliente.setApellido(rs.getString("apellido"));
				cliente.setEdad(rs.getInt("edad"));
				cliente.setDni(rs.getString("dni"));
				cliente.setCelular(rs.getString("celular"));
				cliente.setCorreo(rs.getString("correo"));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
            this.cerrarConexion();
            return null;
		}
    	return cliente;
    }
    
    /**
     * Modifica un guia
     */
    public int modificarCliente(ClienteCargo clientes) {
    	try {
			int filasAfectadas = 0;
			String sql = "CALL sp_modificarCliente(?,?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, clientes.getIdCliente());
			cs.setString(2, clientes.getNombre());
			cs.setString(3, clientes.getApellido());
			cs.setInt(4, clientes.getEdad());
			cs.setString(5, clientes.getDni());
			cs.setString(6, clientes.getCelular());
			cs.setString(7, clientes.getCorreo());
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
    public int eliminarCliente(int idCliente) {
    	try {
			int filasAfectadas = 0;
			String sql = "CALL sp_eliminarCliente(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idCliente);
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
