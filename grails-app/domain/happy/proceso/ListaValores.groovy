package happy.proceso

class ListaValores {

    static auditable = true
    String descripcion
    DetalleProceso detalleProceso



    static mapping = {
        table 'lslv'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'lslv__id'
            descripcion column: 'lslvdscr'
            detalleProceso column: 'dtpc__id'
        }
    }


    static constraints = {
        descripcion(nullable: true, blank: true, size: 1..255)
    }
}
