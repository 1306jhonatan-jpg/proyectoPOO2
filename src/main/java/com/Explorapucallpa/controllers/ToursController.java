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

import com.Explorapucallpa.beans.Tours;
import com.Explorapucallpa.models.ToursModel;

/**
 * Servlet implementation class ToursController
 */
@WebServlet("/ToursController")
@MultipartConfig
public class ToursController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ToursModel modelo = new ToursModel();
	
    public ToursController() {
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
			
		case "listarTours":
			listarTours(request, response);
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

		case "desactivar":
			desactivar(request, response);
			break;
			
		default:
			listar(request, response);
			break;
		}
	}
	
	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listaTours", modelo.listarTours());
			request.getRequestDispatcher("/tours/listaTours.jsp").forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ToursController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void listarTours(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listaTours", modelo.listarTours());
			request.getRequestDispatcher("/tours/vistaCarrusel.jsp").forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ToursController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;
			String jsp = esModal
					? "/tours/fragments/formNuevo.jsp"
					: "/tours/nuevoTours.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(ToursController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Tours tour = modelo.obtenerTour(Integer.parseInt(id));
			if (tour != null) {
				request.setAttribute("tour", tour);
				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal
						? "/tours/fragments/formEditar.jsp"
						: "/tours/editarTours.jsp";
				request.getRequestDispatcher(jsp).forward(request, response);
			}else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(ToursController.class.getName()).log(Level.SEVERE, null, e);			
		}
	}
	
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Tours tour = new Tours();
			tour.setNombreTours(request.getParameter("nombreTours"));
			tour.setDescripcion(request.getParameter("descripcion"));
			tour.setServicios(request.getParameter("servicios"));
			tour.setDuracionTours(request.getParameter("duracionTours"));
			tour.setImagen(request.getParameter("imagen"));
			int resultado = modelo.insertarTour(tour);
			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Tour registrado correctamente" : "Error al registrar Tour");
			}else {
				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Tour registrado correctamente");
				}else {
					request.getSession().setAttribute("mensaje", "Error al registrar Tour");
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
	
	private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Tours tour = new Tours();
			tour.setIdTours(Integer.parseInt(request.getParameter("id")));
			tour.setNombreTours(request.getParameter("nombreTours"));
			tour.setDescripcion(request.getParameter("descripcion"));
			tour.setServicios(request.getParameter("servicios"));
			tour.setDuracionTours(request.getParameter("duracionTours"));
			tour.setEstado(request.getParameter("estado"));
			tour.setImagen(request.getParameter("imagen"));	
			int resultado = modelo.modificarTour(tour);
			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Tour modificado exitosamente" : "Error al modificar tour");
			}else {
				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Tour modificado exitosamente");
				}else {
					request.getSession().setAttribute("mensaje", "Error al modificar tour");
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
			int resultado = modelo.eliminarTour(id);
			String mensaje = resultado > 0 ? "Tour eliminado correctamente" : "Error al eliminar tour";
			request.getSession().setAttribute("mensaje", mensaje);
		} catch (Exception e) {
			Logger.getLogger(ToursController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
		}
		listar(request, response);
	}
	
	private void desactivar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));
			int resultado = modelo.desactivarTour(id);
			String mensaje = resultado > 0 ? "Tour desactivado correctamente" : "Error al desactivar tour";
			request.getSession().setAttribute("mensaje", mensaje);
		} catch (Exception e) {
			Logger.getLogger(ToursController.class.getName()).log(Level.SEVERE, null, e);
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
