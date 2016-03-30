package happy.proceso

import happy.tramites.Tramite

class TramiteProceso {

    static auditable = true
    Tramite tramite
    ProcesoPersona procesoPersona

    static mapping = {
        table 'trpc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'trpc__id'
            tramite column: 'trmt__id'
            procesoPersona column: 'pccl__id'

        }
    }

    static constraints = {
    }
}
