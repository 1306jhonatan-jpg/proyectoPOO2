package com.Explorapucallpa.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.Explorapucallpa.models.PagoModel;

/**
 * Servlet implementation class PagoController
 */
@WebServlet("/PagoController")
@MultipartConfig
public class PagoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    PagoModel model = new PagoModel();
	
    public PagoController() {
        super();
    }
    
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String operacion = request.getParameter("op");

		if (operacion == null) {
			listar(request, response);
			return;
		}
		switch (operacion) {
		case "listar":
			listar(request, response);
			break;

	
		}
	}
	
	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listaPagos", model.listarPago());
			request.getRequestDispatcher("/pago/listaPagos.jsp").forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(PagoController.class.getName()).log(Level.SEVERE, null, e);
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
