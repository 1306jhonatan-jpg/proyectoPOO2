package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.beans.Reserva;

public class ReservaModel extends Conexion{
	CallableStatement cs;
    ResultSet rs;
    
    /**
     * Lista todas las reservas
     */
    
    public List<Reserva> listarReserva(){
    	try {
			ArrayList<Reserva> reserva = new ArrayList<>();
			String sql = "CALL sp_listarReserva()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while(rs.next()) {
				Reserva res = new Reserva();
				res.setIdreserva(rs.getInt("idreserva"));
				res.setCantidadAdulto(rs.getInt("cantidad_adulto"));
				res.setCantidadNino(rs.getInt("cantidad_nino"));
				res.setFechaReserva(rs.getDate("fecha_reserva"));
				res.setPrecioAdulto(rs.getDouble("precio_adulto"));
				res.setPrecioNino(rs.getDouble("precio_menores"));
				res.setTotalReserva(rs.getDouble("total_reserva"));
				res.setToursIdtours(rs.getInt("tours_guia_tours_idtours"));
				res.setGuiaIdguia(rs.getInt("tours_guia_guia_idguia"));
				res.setPagoIdpago(rs.getInt("pago_idpago"));
				res.setClienteIdcliente(rs.getInt("cliente_cargo_idcliente"));
				reserva.add(res);
			}
			this.cerrarConexion();
			return reserva;
		} catch (Exception e) {
			e.printStackTrace();
            this.cerrarConexion();
            return null;
		}
    }
    
    /**
     * Inserta una nueva reserva
     */
    
    public boolean insertarReserva(Reserva reserva) {

        String sql = "{CALL sp_insertarReserva(?,?,?,?,?,?,?,?,?,?)}";

        try {
        	this.abrirConexion();
        	cs = conexion.prepareCall(sql);
            cs.setInt(1, reserva.getCantidadAdulto());
            cs.setInt(2, reserva.getCantidadNino());
            cs.setDate(3, reserva.getFechaReserva());
            cs.setDouble(4, reserva.getPrecioAdulto());
            cs.setDouble(5, reserva.getPrecioNino());
            cs.setDouble(6, reserva.getTotalReserva());
            cs.setInt(7, reserva.getToursIdtours());
            cs.setInt(8, reserva.getGuiaIdguia());
            cs.setInt(9, reserva.getPagoIdpago());
            cs.setInt(10, reserva.getClienteIdcliente());

            cs.execute();
            this.cerrarConexion();
            return true;

        } catch (Exception e) {
        	e.printStackTrace();
            this.cerrarConexion();
            return false;
        }
    }
    
    /**
     * Elimina una reserva
     */
    public int eliminarReserva(int idReserva) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_eliminarReserva(?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idReserva);
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
