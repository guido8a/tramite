package happy.proceso

import happy.seguridad.Persona

class ValorProceso {

    static auditable = true
    DetalleProceso detalleProceso
    ProcesoPersona procesoPersona
    String valor
    String observaciones
    Date fecha
    Date fechaModificacion


    static mapping = {
        table 'vlpc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'vlpc__id'
            detalleProceso column: 'dtpc__id'
            procesoPersona column: 'pccl__id'
            valor          column: 'vlpcvlor'
            observaciones  column: 'vlpcobsr'
            fecha          column: 'vlpcfcha'
            fechaModificacion column: 'vlpcfcmd'
        }
    }


    static constraints = {
        valor (nullable: true, blank: true)
        observaciones(nullable: true, blank: true)
    }
}
