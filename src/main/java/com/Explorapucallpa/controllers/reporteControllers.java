package com.Explorapucallpa.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.Explorapucallpa.dto.CantidadTourDTO;
import com.Explorapucallpa.dto.TourGuiaDTO;
import com.Explorapucallpa.models.reporteModel;
import com.Explorapucallpa.utilitarios.UtilsJson;

/**
 * Servlet implementation class reporteControllers
 */
@WebServlet("/reporteControllers")
public class reporteControllers extends HttpServlet {
	private static final long serialVersionUID = 1L;
    reporteModel modelo = new reporteModel();
    public reporteControllers() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operacion = request.getParameter("op");

        // 👉 SIN op → mostrar la vista
        if (operacion == null) {
            request.getRequestDispatcher("/reportes/reporte.jsp")
                   .forward(request, response);
            return;
        }

        // 👉 CON op → SOLO JSON
        switch (operacion) {
            case "reporteTours":
                reporteTours(request, response);
                break;
            case "reporteToursGuia":
                reporteToursGuia(request, response); // tabla
                break;

            default:
                enviarJSON(response, false, "Operación no válida", null);
                break;
        }
    }
    private void reporteToursGuia(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<TourGuiaDTO> lista = modelo.obtenerTourGuia();

            if (lista == null || lista.isEmpty()) {
                enviarJSON(response, false, "No hay registros", null);
                return;
            }

            StringBuilder dataJson = new StringBuilder();
            dataJson.append("[");

            for (int i = 0; i < lista.size(); i++) {
                TourGuiaDTO d = lista.get(i);

                dataJson.append("{")
                    .append("\"idreserva\":").append(d.getIdreserva()).append(",")
                    .append("\"nombre\":\"").append(d.getNombre()).append("\",")
                    .append("\"fecha\":\"").append(d.getFecha()).append("\",")
                    .append("\"tours\":\"").append(d.getTours()).append("\",")
                    .append("\"guia\":\"").append(d.getGuia()).append("\"")
                    .append("}");

                if (i < lista.size() - 1) {
                    dataJson.append(",");
                }
            }

            dataJson.append("]");

            enviarJSON(response, true, "OK", dataJson.toString());

        } catch (Exception e) {
            e.printStackTrace();
            enviarJSON(response, false, "Error: " + e.getMessage(), null);
        }
    }

    private void reporteTours(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<CantidadTourDTO> datos = modelo.obtenerCantidadTours();

            if (datos == null) {
                enviarJSON(response, false, "No hay datos", null);
                return;
            }

            List<String> labels = new ArrayList<>();
            List<Integer> values = new ArrayList<>();

            for (CantidadTourDTO d : datos) {
                labels.add(d.getTours());
                values.add(d.getCantidad());
            }

            String dataJson = "{"
                    + "\"labels\":" + UtilsJson.jsonArrayStrings(labels) + ","
                    + "\"values\":" + UtilsJson.jsonArrayInts(values)
                    + "}";

            enviarJSON(response, true, "OK", dataJson);

        } catch (Exception e) {
            e.printStackTrace();
            enviarJSON(response, false, "Error: " + e.getMessage(), null);
        }
    }
    
		/**
		 * Envía una respuesta JSON con datos adicionales
		 * 
		 * @param success - true si la operación fue exitosa
		 * @param mensaje - mensaje a enviar
		 * @param dataJsonObject - objeto JSON con datos adicionales
		 */
		private void enviarJSON(HttpServletResponse response, boolean success, String mensaje,
				String dataJsonObject) {
			try {
				response.reset();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.setHeader("Cache-Control", "no-cache");

				String mensajeLimpio = mensaje.replace("\"", "'").replace("\n", " ").replace("\r", " ");

				StringBuilder sb = new StringBuilder(256);
				sb.append("{\"success\":").append(success).append(",\"mensaje\":\"").append(mensajeLimpio).append("\"");

				if (dataJsonObject != null && !dataJsonObject.isEmpty()) {
					sb.append(",\"data\":").append(dataJsonObject);
				}
				sb.append('}');

				try (PrintWriter out = response.getWriter()) {
					out.write(sb.toString());
					out.flush();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

}
