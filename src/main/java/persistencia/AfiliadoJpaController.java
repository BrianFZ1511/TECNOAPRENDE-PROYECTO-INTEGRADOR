package persistencia;

import Logica.Afiliado;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import persistencia.exceptions.NonexistentEntityException;

public class AfiliadoJpaController implements Serializable {

    private EntityManagerFactory emf;

    public AfiliadoJpaController() {
        this.emf = JPAUtil.getEMF();
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Afiliado afiliado) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(afiliado);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public void edit(Afiliado afiliado) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.merge(afiliado);
            em.getTransaction().commit();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (em != null) em.close();
        }
    }

    public void destroy(String idAfiliado) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Afiliado afiliado;
            try {
                afiliado = em.getReference(Afiliado.class, idAfiliado);
                afiliado.getIdAfiliado();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("El Afiliado con ID " + idAfiliado + " no existe.", enfe);
            }
            em.remove(afiliado);
            em.getTransaction().commit();
        } finally {
            if (em != null) em.close();
        }
    }

    public Afiliado findAfiliado(String idAfiliado) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Afiliado.class, idAfiliado);
        } finally {
            em.close();
        }
    }

    public List<Afiliado> findAll() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery<Afiliado> cq = em.getCriteriaBuilder().createQuery(Afiliado.class);
            cq.select(cq.from(Afiliado.class));
            return em.createQuery(cq).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Afiliado> findByTipoPersona(String tipoPersona) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery(
                "SELECT a FROM Afiliado a WHERE a.tipoPersona = :tipo", Afiliado.class
            ).setParameter("tipo", tipoPersona).getResultList();
        } finally {
            em.close();
        }
    }

    public boolean existeAfiliado(String idAfiliado) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(a) FROM Afiliado a WHERE a.idAfiliado = :id", Long.class
            ).setParameter("id", idAfiliado).getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    public boolean afiliadoTieneUsuario(String idAfiliado) {
        EntityManager em = getEntityManager();
        try {
            Long count = em.createQuery(
                "SELECT COUNT(u) FROM Usuario u WHERE u.afiliado.idAfiliado = :id", Long.class
            ).setParameter("id", idAfiliado).getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
}
