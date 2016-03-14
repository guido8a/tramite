package happy.proceso

class Proceso {

    static auditable = true
    String nombre
    String objetivo


    static mapping = {
        table 'prcs'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prcs__id'
            nombre column: 'prcsnmbr'
            objetivo column: 'prcsobjt'
        }
    }


    static constraints = {

        nombre (nullable: false, blank: false, size: 1..1023)
        objetivo(nullable: false, blank: false, size: 1..1023)
    }
}
