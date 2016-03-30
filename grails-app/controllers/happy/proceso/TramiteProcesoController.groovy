package happy.proceso


class TramiteProcesoController extends happy.seguridad.Shield {

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
            def c = TramiteProceso.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = TramiteProceso.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tramiteProcesoInstanceList = getLista(params, false)
        def tramiteProcesoInstanceCount = getLista(params, true).size()
        if (tramiteProcesoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tramiteProcesoInstanceList = getLista(params, false)
        return [tramiteProcesoInstanceList: tramiteProcesoInstanceList, tramiteProcesoInstanceCount: tramiteProcesoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def tramiteProcesoInstance = TramiteProceso.get(params.id)
            if (!tramiteProcesoInstance) {
                notFound_ajax()
                return
            }
            return [tramiteProcesoInstance: tramiteProcesoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tramiteProcesoInstance = new TramiteProceso(params)
        if (params.id) {
            tramiteProcesoInstance = TramiteProceso.get(params.id)
            if (!tramiteProcesoInstance) {
                notFound_ajax()
                return
            }
        }
        return [tramiteProcesoInstance: tramiteProcesoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def tramiteProcesoInstance = new TramiteProceso()
        if (params.id) {
            tramiteProcesoInstance = TramiteProceso.get(params.id)
            if (!tramiteProcesoInstance) {
                notFound_ajax()
                return
            }
        } //update
        tramiteProcesoInstance.properties = params
        if (!tramiteProcesoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} TramiteProceso."
            msg += renderErrors(bean: tramiteProcesoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de TramiteProceso exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def tramiteProcesoInstance = TramiteProceso.get(params.id)
            if (tramiteProcesoInstance) {
                try {
                    tramiteProcesoInstance.delete(flush: true)
                    render "OK_Eliminación de TramiteProceso exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar TramiteProceso."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró TramiteProceso."
    } //notFound para ajax

}
