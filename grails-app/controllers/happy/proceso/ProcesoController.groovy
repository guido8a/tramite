package happy.proceso


class ProcesoController extends happy.seguridad.Shield {

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
            def c = Proceso.createCriteria()
            lista = c.list(params) {
                or {
                    ilike("nombre", "%" + params.search + "%")
                    ilike("objetivo", "%" + params.search + "%")
                }
                order("nombre", "asc")
            }
        } else {
            lista = Proceso.list(params)
            lista = lista.sort{it.nombre}
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def procesoInstanceList = getLista(params, false)
        def procesoInstanceCount = getLista(params, true).size()
        if (procesoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        procesoInstanceList = getLista(params, false)
        return [procesoInstanceList: procesoInstanceList, procesoInstanceCount: procesoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def procesoInstance = Proceso.get(params.id)
            if (!procesoInstance) {
                notFound_ajax()
                return
            }
            return [procesoInstance: procesoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def procesoInstance = new Proceso(params)
        if (params.id) {
            procesoInstance = Proceso.get(params.id)
            if (!procesoInstance) {
                notFound_ajax()
                return
            }
        }
        return [procesoInstance: procesoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def procesoInstance = new Proceso()
        if (params.id) {
            procesoInstance = Proceso.get(params.id)
            if (!procesoInstance) {
                notFound_ajax()
                return
            }
        } //update
        procesoInstance.properties = params
        if (!procesoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Proceso."
            msg += renderErrors(bean: procesoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Proceso exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def procesoInstance = Proceso.get(params.id)
            if (procesoInstance) {
                try {
                    procesoInstance.delete(flush: true)
                    render "OK_Eliminación de Proceso exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Proceso."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Proceso."
    } //notFound para ajax

}
