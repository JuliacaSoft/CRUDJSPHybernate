<%-- 
    Document   : registro
    Created on : 14-jul-2013, 20:21:49
    Author     : AngelDX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="angeldx.to.Estudiante"%>
<%@page import="angeldx.manager.EstudianteManager"%>
<% 
    int id=Integer.parseInt(request.getParameter("id_est"));
    Estudiante est=null;
    String opt="";
    if(id!=0){
        opt="Actualizar";
        out.print("<h3>Editar Estudiante</h3>");
        EstudianteManager estma = new EstudianteManager();
	est=estma.buscarPorId(id);
    }else{
        opt="Registrar";
        out.print("<h3>Registrar Estudiante</h3>");
        
    }
%>
 
 <div class="navbar navbar-fixed-center">
    <div class="navbar-inner">
       <form method="POST" action="EstudianteServlet" id="formulario" class="form-inline" role="form"> 
        <input type="hidden" name="opt" value="<%=opt%>"/>
        <input type="hidden" name="id" value="<%=id%>"/>
        
        <div class="input-group input-group-lgp">
            <label class="sr-only" for="inputEmail">Nombres* :</label>
            <div class="controls">
                <input class="form-control input-lg" type="text" name="txtnombre" value="<%=(est!=null)?est.getNombres():"" %>" placeholder="Nombre"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Apellidos* : </label>
            <div class="controls">
                <input type="text" name="txtapellidos" value="<%=(est!=null)?est.getApellidos():"" %>" placeholder="Apellidos"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">DNI* : </label>
            <div class="controls">
                <input type="text" name="txtdni" value="<%=(est!=null)?est.getDni():"" %>" placeholder="DNI"/>
            </div>
        </div>
         <div class="control-group">
            <label class="control-label">Tipo de colegio *: </label>
            <div class="controls">
                <input type="radio" name="tcolegio" value="PARTICULAR" <%=(est!=null&&est.getTcolegio().equals("PARTICULAR"))?"checked":""%> /> Particular 
                <input type="radio" name="tcolegio" value="ESTATAL" <%=(est!=null&&est.getTcolegio().equals("ESTATAL"))?"checked":""%> /> Estatal        
            </div>
        </div>
      <div class="control-group">
            <label class="control-label">Nombre de colegio* :</label>
            <div class="controls">
                <input type="text" name="txtncolegio" value="<%=(est!=null)?est.getNcolegio():"" %>" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Categoria* :</label>
            <div class="controls">
                <select name="categoria">
                    <option <%=(est!=null&&est.getCategoria().equals("A"))?"selected":""%> >A</option>
                    <option <%=(est!=null&&est.getCategoria().equals("B"))?"selected":""%> >B</option>
                    <option <%=(est!=null&&est.getCategoria().equals("C"))?"selected":""%> >C</option>
                    <option <%=(est!=null&&est.getCategoria().equals("D"))?"selected":""%> >D</option>
                </select>
            </div>
        </div>  
      <div class="control-group">
        <div class="controls">
          <button type="submit" class="btn btn-primary"><%=opt%></button>
        </div>
      </div>
     </form>            
</div>
     <div id="msg"></div>
</div>
 
<script type="text/javascript">
$(document).ready(function(){
 $('#formulario').validate({
  errorElement: "span",
  rules: {
      txtnombre: {
          minlength: 3,
          required: true
      },
      txtapellidos: {
          minlength: 3,
          required: true  //email: true Para emails
      },
      txtdni: {
          minlength: 2,
          required: true,
          digits: true
      },
      txtcolegio: {
          minlength: 2,
          required: true
      }
  },
  messages: {
       txtnombre: {
       required: "Es necesario registrar el nombre de estudiante",
       minlength: jQuery.format("Son necesariost {0} caracteres!")
       }
  },
  highlight: function(element) {
   $(element).closest('.control-group')
   .removeClass('success').addClass('error');
  },
  success: function(element) {
   element
   .text('OK!').addClass('help-inline')
   .closest('.control-group')
   .removeClass('error').addClass('success');
  },
  submitHandler: function() { 
    msg=confirm('\xBFDesea realmente registrar el estudiante?');
    if(msg){        
	$.ajax({
            type: 'POST',
            url: $("#formulario").attr('action'),
            data: $("#formulario").serialize(),
            //beforeSend: loading,					
            success: function(data) {                                  
                $("#msg").html(data);
            }
        });
	return false;					
	}      
  }
 });
});
</script>