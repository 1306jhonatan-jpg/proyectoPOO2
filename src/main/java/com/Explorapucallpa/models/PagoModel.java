package com.Explorapucallpa.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.beans.Pago;



public class PagoModel extends Conexion{

    CallableStatement cs;
    ResultSet rs;
    
    /**
     * Lista todos los Pagos
     */
    public List<Pago> listarPago() {
        try {
            ArrayList<Pago> p = new ArrayList<>();
            String sql = "CALL sp_listarPago()";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            rs = cs.executeQuery();
            
            while (rs.next()) {
                Pago pag = new Pago();
                pag.setIdpago(rs.getInt("idpago"));
                pag.setMetodoPago(rs.getString("metodo_pago"));
                pag.setEstadoPago(rs.getString("estado_pago"));
                p.add(pag);
            }
            
            this.cerrarConexion();
            return p;
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return null;
        }
    }
}
