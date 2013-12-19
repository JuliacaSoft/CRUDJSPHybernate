<%-- 
    Document   : lista
    Created on : 13-jul-2013, 23:15:18
    Author     : AngelDX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="angeldx.to.Estudiante"%>
<%@page import="angeldx.manager.EstudianteManager"%>
	
<p><a href="javascript:fn_mostrar(0)" class="btn btn-primary">Registro Estudiante</a></p>
 <div class="navbar navbar-fixed-center">
    <div class="navbar-inner">      
         <div align="center" class="table table-bordered table-striped">              
            <table border="1" class="table">               
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Nombres y Apellidos</th>
                        <th>DNI</th>
                        <th>Tipo Colegio</th>
                        <th>Colegio</th>
                        <th>Categoria</th>
                        <th colspan="2">Opciones</th>
                    </tr>
                </thead>    
                    <tbody>
                   <%
			EstudianteManager estma = new EstudianteManager();
			List<Estudiante> lista = estma.listar();
			for (Estudiante u : lista) {
		   %>
                    <tr>
                        <td><%=u.getId()%></td>
                        <td><%=u.getApellidos()+" "+u.getNombres()%></td>
                        <td><%=u.getDni() %></td>
                        <td><%=u.getTcolegio() %></td>
                        <td><%=u.getNcolegio() %></td>
                        <td><%=u.getCategoria() %></td>
                        <td><a href="javascript:fn_mostrar(<%=u.getId()%>)" class="menuitem"><img src="resources/img/figuras/editar.png"></a></td>
                        <td><a href="javascript:fn_eliminar(<%=u.getId()%>)" class="menuitem"><img src="resources/img/figuras/eliminar.png"></a></td>
                    </tr>                    
                 <%}%>
                   </tbody>
                   <footer>
                       <tr><td colspan="8">Total registros:</td></tr>                       
                   </footer>
            </table>
           </div>
</div></div>                   
        <script type="text/javascript">
            function fn_mostrar(id){   
                $("#contenido").html('<img src="resources/img/spin.gif"/>Cargando...');
                //$("#contenido").load("registrar.htm",{id_est: id},success(data)); //no se puede usar porque va por post y el formcontroller lo detecta como submit
                $.post('estudiante/estudiante_add.jsp',{id_est: id},function(data) {
                    $('#contenido').html(data);                    
                });
            }
            function fn_eliminar(id){
                if(confirm("¿Desea eliminar el registro?")){
                $("#contenido").html('<img src="resources/img/spin.gif"/>Cargando...');
                //$("#contenido").load("registrar.htm",{id_est: id},success(data)); //no se puede usar porque va por post y el formcontroller lo detecta como submit
                $.post('EstudianteServlet',{id_est:id, opt:"Eliminar"},function(data) {
                    //if(data!="")alert(data);
                    $("#contenido").load("estudiante/estudiante_list.jsp");	
                });
                }else{
                    false;
                }
            }
        </script>