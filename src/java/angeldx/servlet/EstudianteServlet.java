/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package angeldx.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import angeldx.to.Estudiante;
import angeldx.manager.EstudianteManager;

/**
 *
 * @author AngelDX
 */
@WebServlet(name = "EstudianteServlet", urlPatterns = {"/EstudianteServlet"})
public class EstudianteServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
          String opt=request.getParameter("opt");
          
          if(opt.equals("Registrar")){
            String nom=request.getParameter("txtnombre");
            String ape=request.getParameter("txtapellidos");
            int dni=Integer.parseInt(request.getParameter("txtdni"));
            String tcol=request.getParameter("tcolegio");
            String ncol=request.getParameter("txtncolegio");
            String cat=request.getParameter("categoria");
            Estudiante est = new Estudiante(nom,ape,dni,tcol,ncol,cat,0,"NO");
            
            try {        
                EstudianteManager estma = new EstudianteManager();
                boolean result = estma.registrar(est);            
                if(result){
                    out.println("<h2 align='center'>Registro Satisfactorio</h2>");
                }else{
                    out.println("<h2 align='center'>Registro Insatisfactorio</h2>");
                }
            } finally {            
                out.close();
            }
                        
          }
          
          if(opt.equals("Actualizar")){
              
            int id=Integer.parseInt(request.getParameter("id"));
            String nom=request.getParameter("txtnombre");
            String ape=request.getParameter("txtapellidos");
            int dni=Integer.parseInt(request.getParameter("txtdni"));
            String tcol=request.getParameter("tcolegio");
            String ncol=request.getParameter("txtncolegio");
            String cat=request.getParameter("categoria");
            
            Estudiante est = new Estudiante(nom,ape,dni,tcol,ncol,cat,0,"NO");
            est.setId(id);
            
            try {        
                EstudianteManager estma = new EstudianteManager();
                boolean result = estma.registrar(est);            
                if(result){
                    out.println("<h2 align='center'>Registro Satisfactorio</h2>");
                }else{
                    out.println("<h2 align='center'>Registro Insatisfactorio</h2>");
                }
            }catch(Exception e){
                out.println(e.getMessage());
            }finally {            
                out.close();
            }
          }
          
          if(opt.equals("Eliminar")){
              int id=Integer.parseInt(request.getParameter("id_est"));
              
             try {        
                EstudianteManager estma = new EstudianteManager();
                boolean result = estma.eliminar(id);            
                if(result){
                    out.println("<h1 align='center'>Registro Eliminado</h1>");
                }else{
                    out.println("<h1 align='center'>Error: al procesar</h1>");
                }
            } finally {            
                out.close();
            }
          }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
