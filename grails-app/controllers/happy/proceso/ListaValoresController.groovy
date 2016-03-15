package happy.proceso


class ListaValoresController extends happy.seguridad.Shield {

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
            def c = ListaValores.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ListaValores.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def listaValoresInstanceList = getLista(params, false)
        def listaValoresInstanceCount = getLista(params, true).size()
        if (listaValoresInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        listaValoresInstanceList = getLista(params, false)
        return [listaValoresInstanceList: listaValoresInstanceList, listaValoresInstanceCount: listaValoresInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def listaValoresInstance = ListaValores.get(params.id)
            if (!listaValoresInstance) {
                notFound_ajax()
                return
            }
            return [listaValoresInstance: listaValoresInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def listaValoresInstance = new ListaValores(params)
        if (params.id) {
            listaValoresInstance = ListaValores.get(params.id)
            if (!listaValoresInstance) {
                notFound_ajax()
                return
            }
        }
        return [listaValoresInstance: listaValoresInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def listaValoresInstance = new ListaValores()
        if (params.id) {
            listaValoresInstance = ListaValores.get(params.id)
            if (!listaValoresInstance) {
                notFound_ajax()
                return
            }
        } //update
        listaValoresInstance.properties = params
        if (!listaValoresInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ListaValores."
            msg += renderErrors(bean: listaValoresInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ListaValores exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def listaValoresInstance = ListaValores.get(params.id)
            if (listaValoresInstance) {
                try {
                    listaValoresInstance.delete(flush: true)
                    render "OK_Eliminación de ListaValores exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ListaValores."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ListaValores."
    } //notFound para ajax

}
