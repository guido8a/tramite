package happy.proceso

class ListaValores {

    static auditable = true
    String descripcion
    String defecto
    DetalleProceso detalleProceso


    static mapping = {
        table 'lsvl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'lsvl__id'
            descripcion column: 'lsvldscr'
            detalleProceso column: 'dtpc__id'
            defecto column: 'lsvldfct'
        }
    }


    static constraints = {
        descripcion(nullable: true, blank: true, size: 1..255)
        defecto (nullable: true, blank: true)
    }
}
