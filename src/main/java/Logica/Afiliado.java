package Logica;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "afiliado")
public class Afiliado implements Serializable {

    @Id
    @Column(name = "IDAFILIADO", length = 20)
    private String idAfiliado;

    @Column(name = "NOMBRE", nullable = false, length = 100)
    private String nombre;

    @Column(name = "APELLIDOS", nullable = false, length = 100)
    private String apellidos;

    @Column(name = "TIPOPERSONA", nullable = false, length = 30)
    private String tipoPersona;

    public Afiliado() {}

    public Afiliado(String idAfiliado, String nombre, String apellidos, String tipoPersona) {
        this.idAfiliado  = idAfiliado;
        this.nombre      = nombre;
        this.apellidos   = apellidos;
        this.tipoPersona = tipoPersona;
    }

    public String getIdAfiliado() {
        return idAfiliado; 
    }
    
    public void setIdAfiliado(String idAfiliado) {
        this.idAfiliado = idAfiliado; 
    }

    public String getNombre() { 
        return nombre; 
    }
    
    public void setNombre(String nombre) { 
        this.nombre = nombre; 
    }

    public String getApellidos() { 
        return apellidos; 
    }
    
    public void setApellidos(String apellidos) { 
        this.apellidos = apellidos; 
    }

    public String getTipoPersona() { 
        return tipoPersona; 
    }
    
    public void setTipoPersona(String tipoPersona) { 
        this.tipoPersona = tipoPersona; 
    }
}
