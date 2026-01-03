package com.Explorapucallpa.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import com.Explorapucallpa.beans.ClienteCargo;
import com.Explorapucallpa.models.ClienteCargoModel;


@WebServlet("/ClientesCargoController")
@MultipartConfig
public class ClientesCargoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    ClienteCargoModel model = new ClienteCargoModel();
	
    public ClientesCargoController() {
        super();

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

		case "editar":
			cargarFormularioEditar(request, response);
			break;

		case "insertarAjax":
		case "insertar":
			insertar(request, response, esAjax);
			break;

		case "modificarAjax":
		case "modificar":
			modificar(request, response, esAjax);
			break;

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
			request.setAttribute("listaClientes", model.listarCliente());
			request.getRequestDispatcher("/clientes/listaClientes.jsp").forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ClientesCargoController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;
			String jsp = esModal
					? "/clientes/fragments/formNuevo.jsp"
					: "/clientes/nuevoGuia.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ClientesCargoController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			ClienteCargo cliente = model.obtenerCliente(Integer.parseInt(id));

			if (cliente != null) {
				request.setAttribute("cliente", cliente);
				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal
						? "/clientes/fragments/formEditar.jsp"
						: "/clientes/editarGuia.jsp";
				request.getRequestDispatcher(jsp).forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(ClientesCargoController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			ClienteCargo cliente = new ClienteCargo();
			cliente.setNombre(request.getParameter("nombre"));
			cliente.setApellido(request.getParameter("apellido"));
			cliente.setEdad(Integer.parseInt(request.getParameter("edad")));
			cliente.setDni(request.getParameter("dni"));
			cliente.setCelular(request.getParameter("celular"));
			cliente.setCorreo(request.getParameter("correo"));

			int resultado = model.insertarCliente(cliente);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Cliente registrado exitosamente" : "Error al registrar Cliente");
			} else {
				 response.setContentType("text/html; charset=UTF-8");
	                if (resultado > 0) {
	                    request.getSession().setAttribute("mensaje", "Cliente registrado exitosamente");
	                } else {
	                    request.getSession().setAttribute("mensaje", "Error al registrar Cliente");
	                }
	                listar(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            } else {
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
	
	private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			ClienteCargo cliente = new ClienteCargo();
			cliente.setIdCliente(Integer.parseInt(request.getParameter("id")));
			cliente.setNombre(request.getParameter("nombre"));
			cliente.setApellido(request.getParameter("apellido"));
			cliente.setEdad(Integer.parseInt(request.getParameter("edad")));
			cliente.setDni(request.getParameter("dni"));
			cliente.setCelular(request.getParameter("celular"));
			cliente.setCorreo(request.getParameter("correo"));

			int resultado = model.modificarCliente(cliente);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Cliente modificado exitosamente" : "Error al modificar Cliente");
			} else {
				 response.setContentType("text/html; charset=UTF-8");
	                if (resultado > 0) {
	                    request.getSession().setAttribute("mensaje", "Cliente modificado exitosamente");
	                } else {
	                    request.getSession().setAttribute("mensaje", "Error al modificar Cliente");
	                }
	                listar(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            } else {
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
			int resultado = model.eliminarCliente(id);
			 String mensaje = resultado > 0 ? "Cliente eliminado exitosamente" : "Error al eliminar Cliente";
	            request.getSession().setAttribute("mensaje", mensaje);

			

		} catch (Exception e) {
			Logger.getLogger(ClientesCargoController.class.getName()).log(Level.SEVERE, null, e);
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
		processRequest(request, response);;
	}

@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
