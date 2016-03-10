package happy.proceso

class Fase {

    static auditable = true
    String descripcion
    String objetivo

    static mapping = {

        table 'fase'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'fase__id'
            descripcion column: 'fasedscr'
            objetivo column: 'faseobjt'
        }


    }

    static constraints = {
        descripcion(nullable: false, blank: false, size: 1..1023)
        objetivo(nullable: false, blank: false, size: 1..1023)
    }
}
