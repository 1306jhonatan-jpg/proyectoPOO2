package com.Explorapucallpa.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.Explorapucallpa.beans.ClienteCargo;
import com.Explorapucallpa.beans.Guias;
import com.Explorapucallpa.beans.Pago;
import com.Explorapucallpa.beans.Reserva;
import com.Explorapucallpa.beans.Tours;
import com.Explorapucallpa.models.ClienteCargoModel;
import com.Explorapucallpa.models.GuiasModel;
import com.Explorapucallpa.models.PagoModel;
import com.Explorapucallpa.models.ReservaModel;
import com.Explorapucallpa.models.ToursModel;

/**
 * Servlet implementation class ReservaController
 */
@WebServlet("/ReservaController")
@MultipartConfig
public class ReservaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ReservaModel model = new ReservaModel();
	
    public ReservaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String operacion = request.getParameter("op");

		if (operacion == null) {
			listar(request, response);
			return;
		}

		boolean esAjax = operacion.endsWith("Ajax");

		switch (operacion) {
		case "listar":
			listar(request, response);
			break;

		case "nuevo":
			cargarFormularioNuevo(request, response);
			break;

	//	case "editar":
			//		cargarFormularioEditar(request, response);
			//break;

		case "insertarAjax":
		case "insertar":
			insertar(request, response, esAjax);
			break;

			//	case "modificarAjax":
			//		case "modificar":
			//			modificar(request, response, esAjax);
			//break;

			case "eliminar":
			eliminar(request, response);
			break;
			
		default:
			listar(request, response);
			break;
		}
	}
	
	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listaReservas", model.listarReserva());
			request.getRequestDispatcher("/reserva/listaReservas.jsp").forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ReservaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			ToursModel toursModel = new ToursModel();
	        GuiasModel guiasModel = new GuiasModel();
	        PagoModel pagoModel = new PagoModel();
	        ClienteCargoModel clienteModel = new ClienteCargoModel();

	        List<Tours> listaTours = toursModel.listarTours();
	        List<Guias> listaGuias = guiasModel.listarGuias();
	        List<Pago> listaPagos = pagoModel.listarPago();
	        List<ClienteCargo> listaClientes = clienteModel.listarCliente();

	        request.setAttribute("listaTours", listaTours);
	        request.setAttribute("listaGuias", listaGuias);
	        request.setAttribute("listaPagos", listaPagos);
	        request.setAttribute("listaClientes", listaClientes);
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;
			String jsp = esModal
					? "/reserva/fragments/formNuevo.jsp"
					: "/reserva/nuevoReserva.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ReservaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Reserva r = new Reserva();
			r.setCantidadAdulto(Integer.parseInt(request.getParameter("cantidadAdulto")));
			r.setCantidadNino(Integer.parseInt(request.getParameter("cantidadNino")));
			r.setFechaReserva(Date.valueOf(request.getParameter("fechaReserva")));
			r.setPrecioAdulto(Double.parseDouble(request.getParameter("precioAdulto")));
			r.setPrecioNino(Double.parseDouble(request.getParameter("precioNino")));
			double total = (r.getCantidadAdulto() * r.getPrecioAdulto()) + (r.getCantidadNino() * r.getPrecioNino());
			r.setTotalReserva(total);
			r.setToursIdtours(Integer.parseInt(request.getParameter("toursIdtours")));
			r.setGuiaIdguia(Integer.parseInt(request.getParameter("guiaIdguia")));
			r.setPagoIdpago(Integer.parseInt(request.getParameter("pagoIdpago")));
			r.setClienteIdcliente(Integer.parseInt(request.getParameter("clienteIdcliente")));
			boolean resultado = model.insertarReserva(r);
			if (esAjax) {
				enviarJSON(response, resultado,
						resultado ? "Reserva registrado correctamente" : "Error al registrar Reserva");
			}else {
				response.setContentType("text/html; charset=UTF-8");
				if (resultado) {
					request.getSession().setAttribute("mensaje", "Reserva registrado correctamente");
				}else {
					request.getSession().setAttribute("mensaje", "Error al registrar Reserva");
				}
				listar(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			if (esAjax) {
				enviarJSON(response, false, "Error: " + e.getMessage());
			}else {
				try {
                    response.setContentType("text/html; charset=UTF-8");
                    request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
                    listar(request, response);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}
    
	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));
			int resultado = model.eliminarReserva(id);
			 String mensaje = resultado > 0 ? "Reserva eliminado exitosamente" : "Error al eliminar Reserva";
	            request.getSession().setAttribute("mensaje", mensaje);

			

		} catch (Exception e) {
			Logger.getLogger(ReservaController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
		}
		listar(request, response);
	}
	
	private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
		try {
			response.reset();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Cache-Control", "no-cache");

			String mensajeLimpio = mensaje.replace("\"", "'").replace("\n", " ").replace("\r", " ");
			String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensajeLimpio + "\"}";

			PrintWriter out = response.getWriter();
			out.write(json);
			out.flush();
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
