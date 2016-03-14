package happy.proceso

class DetalleProceso {

    static auditable = true

    Dato dato
    Proceso proceso
    String etiqueta
    int orden
    String rango
    Double numericoMinimo
    Double numericoMaximo
    String defecto
    String nulo
    Double aporte
    String observacion
    int posicionReporte
    Date fecha
    Date fechaModificacion
    String ruta



    static mapping = {
        table 'dtpc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtpc__id'
            dato column: 'dato__id'
            proceso column: 'prcs__id'
            etiqueta column: 'dtpcetqt'
            orden column: 'dtpcordn'
            rango column: 'dtpcrngo'
            numericoMinimo column: 'dtpcnmmn'
            numericoMaximo column: 'dtpcmnmx'
            defecto column: 'dtpcdfct'
            nulo column: 'dtpcnulo'
            aporte column: 'dtpcaprt'
            observacion column: 'dtpcobsr'
            posicionReporte column: 'dtpcpsrp'
            fecha column: 'dtpcfcha'
            fechaModificacion column: 'dtpcfcmd'
            ruta column: 'dtpcruta'

        }
    }

    static constraints = {

        etiqueta(nullable: true, blank: true, size: 1..255)
        orden(nullable: true, blank: true)
        rango(nullable: true, blank: true, size: 1..63)
        defecto(nullable: true, blank: true, size: 1..63)
        observacion(nullable: true, blank: true, size: 1..255)
        ruta(nullable: true, blank: true)

    }
}
