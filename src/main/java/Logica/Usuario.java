package Logica;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "usuario")
public class Usuario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "IDAFILIADO", nullable = false)
    private Afiliado afiliado;

    private String rol;
    private String contrasena;
    private boolean requiereCambioContrasena;

    @OneToOne(mappedBy = "usuario", cascade = CascadeType.ALL)
    private Instructor instructor;

    @OneToOne(mappedBy = "usuario", cascade = CascadeType.ALL)
    private Administrador administrador;

    @OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL)
    private List<Progreso> progreso;

    public Usuario() {}

    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public Afiliado getAfiliado() { 
        return afiliado; 
    }
    
    public void setAfiliado(Afiliado afiliado) { 
        this.afiliado = afiliado; 
    }

    public String getRol() { 
        return rol; 
    }
    
    public void setRol(String rol) { 
        this.rol = rol; 
    }

    public String getContrasena() { 
        return contrasena; 
    }
    
    public void setContrasena(String contrasena) { 
        this.contrasena = contrasena; 
    }

    public boolean isRequiereCambioContrasena() { 
        return requiereCambioContrasena; 
    }
    
    public void setRequiereCambioContrasena(boolean requiereCambioContrasena) {
        this.requiereCambioContrasena = requiereCambioContrasena;
    }

    public Instructor getInstructor() { 
        return instructor; 
    }
    public void setInstructor(Instructor instructor) { 
        this.instructor = instructor; 
    }

    public Administrador getAdministrador() { 
        return administrador; 
    }
    
    public void setAdministrador(Administrador administrador) { 
        this.administrador = administrador; 
    }

    public List<Progreso> getProgreso() { 
        return progreso; 
    }
    
    public void setProgreso(List<Progreso> progreso) { 
        this.progreso = progreso; 
    }
}
