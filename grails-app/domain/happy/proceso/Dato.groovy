package happy.proceso

class Dato {

    static auditable = true
    String descripcion
    String valor
    String tipo
    Fase fase


    static mapping = {
        table 'dato'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dato__id'
            descripcion column: 'datodscr'
            valor column: 'datovlor'
            tipo column: 'datotipo'
            fase column: 'fase__id'
        }
    }

    static constraints = {
        descripcion(nullable: false, blank: false, size: 1..255)
        valor(nullable: false, blank: false, size: 1..255)
        tipo(nullable: false, blank: false, size: 1..63)
    }
}
