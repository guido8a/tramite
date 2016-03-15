package happy.proceso


class DetalleProcesoController extends happy.seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        params = params.clone()
        if (all) {
            params.remove("offset")
            params.remove("max")
        }
        def lista
        if (params.search) {
            def c = DetalleProceso.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = DetalleProceso.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def detalleProcesoInstanceList = getLista(params, false)
        def detalleProcesoInstanceCount = getLista(params, true).size()
        if (detalleProcesoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        detalleProcesoInstanceList = getLista(params, false)
        return [detalleProcesoInstanceList: detalleProcesoInstanceList, detalleProcesoInstanceCount: detalleProcesoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def detalleProcesoInstance = DetalleProceso.get(params.id)
            if (!detalleProcesoInstance) {
                notFound_ajax()
                return
            }
            return [detalleProcesoInstance: detalleProcesoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def detalleProcesoInstance = new DetalleProceso(params)
        if (params.id) {
            detalleProcesoInstance = DetalleProceso.get(params.id)
            if (!detalleProcesoInstance) {
                notFound_ajax()
                return
            }
        }
        return [detalleProcesoInstance: detalleProcesoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def detalleProcesoInstance = new DetalleProceso()
        if (params.id) {
            detalleProcesoInstance = DetalleProceso.get(params.id)
            if (!detalleProcesoInstance) {
                notFound_ajax()
                return
            }
        } //update
        detalleProcesoInstance.properties = params
        if (!detalleProcesoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} DetalleProceso."
            msg += renderErrors(bean: detalleProcesoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de DetalleProceso exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def detalleProcesoInstance = DetalleProceso.get(params.id)
            if (detalleProcesoInstance) {
                try {
                    detalleProcesoInstance.delete(flush: true)
                    render "OK_Eliminación de DetalleProceso exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar DetalleProceso."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró DetalleProceso."
    } //notFound para ajax

    def formulario () {

        def proceso
        if(params.id){
            proceso = Proceso.get(params.id)
        }

        return [proceso: proceso]
    }

    def saveProceso_ajax () {
        println("params save pro " + params)

        def proceso

        if(params.id){
            proceso = Proceso.get(params.id)
            proceso.objetivo = params.objetivo
            proceso.nombre = params.proceso

            try {
                proceso.save(flush: true)
                render "ok_${proceso?.id}"
            }catch(e){

                println("error al guardar proceso" + proceso.errors)
                render "no"
            }
        }else{
            proceso = new Proceso();
            proceso.objetivo = params.objetivo
            proceso.nombre = params.proceso

            try {
                proceso.save(flush: true)
                render "ok_${proceso?.id}"
            }catch(e){

                println("error al guardar proceso" + proceso.errors)
                render "no"
            }
        }

    }

    def cargarDatos_ajax () {

        println("params da" + params)

        def fase = Fase.get(params.id)
        def datos = Dato.findAllByFase(fase)
        def proceso = Proceso.get(params.idPro)

        return [datos: datos, proceso: proceso]

    }

    def tablaDatos_ajax () {
        println("tabla datos " + params)
        def dato = Dato.get(params.id)
        def proceso = Proceso.get(params.idPro)
        def detalleProceso = DetalleProceso.findByDatoAndProceso(dato, proceso)

        return [detalleProceso: detalleProceso, dato: dato, proceso: proceso]

    }


    def saveDetalle_ajax() {

        println("save deta " + params)

        def dato = Dato.get(params.idD)
        def proceso = Proceso.get(params.idP)
        def detalleProceso

        if(params.idDP){
        detalleProceso = DetalleProceso.get(params.idDP)
        detalleProceso.etiqueta = params.etiqueta
        detalleProceso.orden = params.orden




        }else{

        }

    }

}
