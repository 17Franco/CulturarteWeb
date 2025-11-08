
package webservices;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para dtoPropuesta complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="dtoPropuesta"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Titulo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="Descripcion" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="Imagen" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="Lugar" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="Fecha" type="{http://webServices/}localDate" minOccurs="0"/&gt;
 *         &lt;element name="Precio" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="MontoTotal" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="FechaPublicacion" type="{http://webServices/}localDate" minOccurs="0"/&gt;
 *         &lt;element name="fechaExpiracion" type="{http://webServices/}localDate" minOccurs="0"/&gt;
 *         &lt;element name="Retorno" type="{http://webServices/}tipoRetorno" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="cat" type="{http://webServices/}dtoCategoria" minOccurs="0"/&gt;
 *         &lt;element name="categoria" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="usr" type="{http://webServices/}dtoProponente" minOccurs="0"/&gt;
 *         &lt;element name="EstadoAct" type="{http://webServices/}estado" minOccurs="0"/&gt;
 *         &lt;element name="historialEstados" type="{http://webServices/}dtoRegistroEstado" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="aporte" type="{http://webServices/}dtoColaboracion" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="comentarios"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="entry" maxOccurs="unbounded" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="key" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *                             &lt;element name="value" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "dtoPropuesta", propOrder = {
    "titulo",
    "descripcion",
    "imagen",
    "lugar",
    "fecha",
    "precio",
    "montoTotal",
    "fechaPublicacion",
    "fechaExpiracion",
    "retorno",
    "cat",
    "categoria",
    "usr",
    "estadoAct",
    "historialEstados",
    "aporte",
    "comentarios"
})
public class DtoPropuesta {

    @XmlElement(name = "Titulo")
    protected String titulo;
    @XmlElement(name = "Descripcion")
    protected String descripcion;
    @XmlElement(name = "Imagen")
    protected String imagen;
    @XmlElement(name = "Lugar")
    protected String lugar;
    @XmlElement(name = "Fecha")
    protected LocalDate fecha;
    @XmlElement(name = "Precio")
    protected int precio;
    @XmlElement(name = "MontoTotal")
    protected int montoTotal;
    @XmlElement(name = "FechaPublicacion")
    protected LocalDate fechaPublicacion;
    protected LocalDate fechaExpiracion;
    @XmlElement(name = "Retorno", nillable = true)
    @XmlSchemaType(name = "string")
    protected List<TipoRetorno> retorno;
    protected DtoCategoria cat;
    protected String categoria;
    protected DtoProponente usr;
    @XmlElement(name = "EstadoAct")
    @XmlSchemaType(name = "string")
    protected Estado estadoAct;
    @XmlElement(nillable = true)
    protected List<DtoRegistroEstado> historialEstados;
    @XmlElement(nillable = true)
    protected List<DtoColaboracion> aporte;
    @XmlElement(required = true)
    protected DtoPropuesta.Comentarios comentarios;

    /**
     * Obtiene el valor de la propiedad titulo.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTitulo() {
        return titulo;
    }

    /**
     * Define el valor de la propiedad titulo.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTitulo(String value) {
        this.titulo = value;
    }

    /**
     * Obtiene el valor de la propiedad descripcion.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * Define el valor de la propiedad descripcion.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescripcion(String value) {
        this.descripcion = value;
    }

    /**
     * Obtiene el valor de la propiedad imagen.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getImagen() {
        return imagen;
    }

    /**
     * Define el valor de la propiedad imagen.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setImagen(String value) {
        this.imagen = value;
    }

    /**
     * Obtiene el valor de la propiedad lugar.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLugar() {
        return lugar;
    }

    /**
     * Define el valor de la propiedad lugar.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLugar(String value) {
        this.lugar = value;
    }

    /**
     * Obtiene el valor de la propiedad fecha.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getFecha() {
        return fecha;
    }

    /**
     * Define el valor de la propiedad fecha.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setFecha(LocalDate value) {
        this.fecha = value;
    }

    /**
     * Obtiene el valor de la propiedad precio.
     * 
     */
    public int getPrecio() {
        return precio;
    }

    /**
     * Define el valor de la propiedad precio.
     * 
     */
    public void setPrecio(int value) {
        this.precio = value;
    }

    /**
     * Obtiene el valor de la propiedad montoTotal.
     * 
     */
    public int getMontoTotal() {
        return montoTotal;
    }

    /**
     * Define el valor de la propiedad montoTotal.
     * 
     */
    public void setMontoTotal(int value) {
        this.montoTotal = value;
    }

    /**
     * Obtiene el valor de la propiedad fechaPublicacion.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getFechaPublicacion() {
        return fechaPublicacion;
    }

    /**
     * Define el valor de la propiedad fechaPublicacion.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setFechaPublicacion(LocalDate value) {
        this.fechaPublicacion = value;
    }

    /**
     * Obtiene el valor de la propiedad fechaExpiracion.
     * 
     * @return
     *     possible object is
     *     {@link LocalDate }
     *     
     */
    public LocalDate getFechaExpiracion() {
        return fechaExpiracion;
    }

    /**
     * Define el valor de la propiedad fechaExpiracion.
     * 
     * @param value
     *     allowed object is
     *     {@link LocalDate }
     *     
     */
    public void setFechaExpiracion(LocalDate value) {
        this.fechaExpiracion = value;
    }

    /**
     * Gets the value of the retorno property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the retorno property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRetorno().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TipoRetorno }
     * 
     * 
     */
    public List<TipoRetorno> getRetorno() {
        if (retorno == null) {
            retorno = new ArrayList<TipoRetorno>();
        }
        return this.retorno;
    }

    /**
     * Obtiene el valor de la propiedad cat.
     * 
     * @return
     *     possible object is
     *     {@link DtoCategoria }
     *     
     */
    public DtoCategoria getCat() {
        return cat;
    }

    /**
     * Define el valor de la propiedad cat.
     * 
     * @param value
     *     allowed object is
     *     {@link DtoCategoria }
     *     
     */
    public void setCat(DtoCategoria value) {
        this.cat = value;
    }

    /**
     * Obtiene el valor de la propiedad categoria.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCategoria() {
        return categoria;
    }

    /**
     * Define el valor de la propiedad categoria.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCategoria(String value) {
        this.categoria = value;
    }

    /**
     * Obtiene el valor de la propiedad usr.
     * 
     * @return
     *     possible object is
     *     {@link DtoProponente }
     *     
     */
    public DtoProponente getUsr() {
        return usr;
    }

    /**
     * Define el valor de la propiedad usr.
     * 
     * @param value
     *     allowed object is
     *     {@link DtoProponente }
     *     
     */
    public void setUsr(DtoProponente value) {
        this.usr = value;
    }

    /**
     * Obtiene el valor de la propiedad estadoAct.
     * 
     * @return
     *     possible object is
     *     {@link Estado }
     *     
     */
    public Estado getEstadoAct() {
        return estadoAct;
    }

    /**
     * Define el valor de la propiedad estadoAct.
     * 
     * @param value
     *     allowed object is
     *     {@link Estado }
     *     
     */
    public void setEstadoAct(Estado value) {
        this.estadoAct = value;
    }

    /**
     * Gets the value of the historialEstados property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the historialEstados property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getHistorialEstados().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DtoRegistroEstado }
     * 
     * 
     */
    public List<DtoRegistroEstado> getHistorialEstados() {
        if (historialEstados == null) {
            historialEstados = new ArrayList<DtoRegistroEstado>();
        }
        return this.historialEstados;
    }

    /**
     * Gets the value of the aporte property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the aporte property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAporte().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DtoColaboracion }
     * 
     * 
     */
    public List<DtoColaboracion> getAporte() {
        if (aporte == null) {
            aporte = new ArrayList<DtoColaboracion>();
        }
        return this.aporte;
    }

    /**
     * Obtiene el valor de la propiedad comentarios.
     * 
     * @return
     *     possible object is
     *     {@link DtoPropuesta.Comentarios }
     *     
     */
    public DtoPropuesta.Comentarios getComentarios() {
        return comentarios;
    }

    /**
     * Define el valor de la propiedad comentarios.
     * 
     * @param value
     *     allowed object is
     *     {@link DtoPropuesta.Comentarios }
     *     
     */
    public void setComentarios(DtoPropuesta.Comentarios value) {
        this.comentarios = value;
    }


    /**
     * <p>Clase Java para anonymous complex type.
     * 
     * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="entry" maxOccurs="unbounded" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="key" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
     *                   &lt;element name="value" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "entry"
    })
    public static class Comentarios {

        protected List<DtoPropuesta.Comentarios.Entry> entry;

        /**
         * Gets the value of the entry property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the entry property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getEntry().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link DtoPropuesta.Comentarios.Entry }
         * 
         * 
         */
        public List<DtoPropuesta.Comentarios.Entry> getEntry() {
            if (entry == null) {
                entry = new ArrayList<DtoPropuesta.Comentarios.Entry>();
            }
            return this.entry;
        }


        /**
         * <p>Clase Java para anonymous complex type.
         * 
         * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
         * 
         * <pre>
         * &lt;complexType&gt;
         *   &lt;complexContent&gt;
         *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *       &lt;sequence&gt;
         *         &lt;element name="key" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
         *         &lt;element name="value" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
         *       &lt;/sequence&gt;
         *     &lt;/restriction&gt;
         *   &lt;/complexContent&gt;
         * &lt;/complexType&gt;
         * </pre>
         * 
         * 
         */
        @XmlAccessorType(XmlAccessType.FIELD)
        @XmlType(name = "", propOrder = {
            "key",
            "value"
        })
        public static class Entry {

            protected String key;
            protected String value;

            /**
             * Obtiene el valor de la propiedad key.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getKey() {
                return key;
            }

            /**
             * Define el valor de la propiedad key.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setKey(String value) {
                this.key = value;
            }

            /**
             * Obtiene el valor de la propiedad value.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getValue() {
                return value;
            }

            /**
             * Define el valor de la propiedad value.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setValue(String value) {
                this.value = value;
            }

        }

    }

}
