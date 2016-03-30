package happy.proceso

import happy.tramites.TipoDocumento

class ProcesoDocumento {

    static auditable = true
    Proceso proceso
    TipoDocumento tipoDocumento

    static mapping = {
        table 'pctd'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'pctd__id'
            proceso column: 'prcs__id'
            tipoDocumento column: 'tpdc__id'
        }
    }

    static constraints = {

    }
}
