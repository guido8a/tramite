package happy.proceso

import happy.seguridad.Persona

class ProcesoPersona {

    static auditable = true
    Proceso proceso
    Persona persona
    String estado


    static mapping = {
        table 'pccl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'pccl__id'
            proceso column: 'prcs__id'
            persona column: 'prsn__id'
            estado column: 'pccletdo'
        }
    }


    static constraints = {
        estado (nullable: true, blank: true)
    }
}
