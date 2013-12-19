/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package angeldx.manager;
import angeldx.to.Estudiante;
import angeldx.util.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
/**
 *
 * @author AngelDX
 */

public class EstudianteManager {

    public List<Estudiante> listar(){
	 List<Estudiante> list = new ArrayList<Estudiante>();
	 Session session = HibernateUtil.openSession();
	 Transaction tran = null;	
	 try {
		 tran = session.getTransaction();
		 tran.begin();
		 list = session.createQuery("from Estudiante").list(); //from Estudiante de llama de la persitencia de datos (to)					
		 tran.commit();
	 } catch (Exception e) {
		 e.printStackTrace();
	 } finally {
                 session.flush();
		 session.close();
	 }
	 return list;
    }

    public boolean registrar(Estudiante est){
	 Session session = HibernateUtil.openSession();	
	 Transaction tran = null;	
	 try {
		 tran = session.getTransaction();
		 tran.begin();                 
		 session.saveOrUpdate(est);		
		 tran.commit();                 
	 } catch(Exception e) {
		 if (tran!=null) {
                    tran.rollback();
		 }
                 e.printStackTrace();
	 } finally {
                session.flush();
		session.close();
	 }	
	 return true;
    }    
    
    public Estudiante buscarPorId(int id) {
        Estudiante est = null;
        Transaction tran = null;
        Session session = HibernateUtil.openSession();
        try {
            tran = session.beginTransaction();
            String queryString = "from Estudiante where id = :id";
            Query query = session.createQuery(queryString);
            query.setInteger("id", id);
            est = (Estudiante) query.uniqueResult();
        } catch (RuntimeException e) {
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
        return est;
    }
   
    public boolean eliminar(int id) {
        Session session = HibernateUtil.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Estudiante est = (Estudiante) session.load(Estudiante.class, new Integer(id));
            session.delete(est);
            tx.commit();
        } catch (RuntimeException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.flush();
            session.close();
        }
        return true;
    }    
}
