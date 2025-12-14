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


import com.Explorapucallpa.beans.Guias;
import com.Explorapucallpa.models.GuiasModel;

@WebServlet("/GuiasController")
@MultipartConfig
public class GuiasController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	GuiasModel model = new GuiasModel();

	public GuiasController() {
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
			request.setAttribute("listaGuias", model.listarGuias());
			request.getRequestDispatcher("/guias/listaGuias.jsp").forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(GuiasController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;
			String jsp = esModal
					? "/guias/fragments/formNuevo.jsp"
					: "/guias/nuevoGuia.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(GuiasController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Guias guia = model.obtenerGuia(Integer.parseInt(id));

			if (guia != null) {
				request.setAttribute("guia", guia);
				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal
						? "/guias/fragments/formEditar.jsp"
						: "/guias/editarGuia.jsp";
				request.getRequestDispatcher(jsp).forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(GuiasController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Guias guia = new Guias();
			guia.setNombreGuia(request.getParameter("nombreGuia"));
			guia.setApellidoGuia(request.getParameter("apellidoGuia"));
			guia.setDniGuia(request.getParameter("dniGuia"));
			guia.setPago(Double.parseDouble(request.getParameter("pago")));
			guia.setCelular(request.getParameter("celular"));
			guia.setEmpresa(request.getParameter("empresa"));

			int resultado = model.insertarGuia(guia);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Guía registrado exitosamente" : "Error al registrar guía");
			} else {
				 response.setContentType("text/html; charset=UTF-8");
	                if (resultado > 0) {
	                    request.getSession().setAttribute("mensaje", "Guia registrado exitosamente");
	                } else {
	                    request.getSession().setAttribute("mensaje", "Error al registrar guia");
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
			Guias guia = new Guias();
			guia.setIdguia(Integer.parseInt(request.getParameter("id")));
			guia.setNombreGuia(request.getParameter("nombreGuia"));
			guia.setApellidoGuia(request.getParameter("apellidoGuia"));
			guia.setDniGuia(request.getParameter("dniGuia"));
			guia.setPago(Double.parseDouble(request.getParameter("pago")));
			guia.setCelular(request.getParameter("celular"));
			guia.setEmpresa(request.getParameter("empresa"));

			int resultado = model.modificarGuia(guia);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Guía modificado exitosamente" : "Error al modificar guía");
			} else {
				 response.setContentType("text/html; charset=UTF-8");
	                if (resultado > 0) {
	                    request.getSession().setAttribute("mensaje", "Guia modificado exitosamente");
	                } else {
	                    request.getSession().setAttribute("mensaje", "Error al modificar guia");
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
			int resultado = model.eliminarGuia(id);
			 String mensaje = resultado > 0 ? "Guia eliminado exitosamente" : "Error al eliminar guia";
	            request.getSession().setAttribute("mensaje", mensaje);

			

		} catch (Exception e) {
			Logger.getLogger(GuiasController.class.getName()).log(Level.SEVERE, null, e);
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}
}
