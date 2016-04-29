package happy.proceso


class FaseController extends happy.seguridad.Shield {

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
            def c = Fase.createCriteria()
            lista = c.list(params) {
                or {
                    /* cambiar campos aqui segun sea necesario */
                    ilike("objetivo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
                order("descripcion", "asc")
            }
        } else {
            lista = Fase.list(params)
            lista = lista.sort{it.descripcion}
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def faseInstanceList = getLista(params, false)
        def faseInstanceCount = getLista(params, true).size()
        if(faseInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        faseInstanceList = getLista(params, false)
        return [faseInstanceList: faseInstanceList, faseInstanceCount: faseInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def faseInstance = Fase.get(params.id)
            if(!faseInstance) {
                notFound_ajax()
                return
            }
            return [faseInstance: faseInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def faseInstance = new Fase(params)
        if(params.id) {
            faseInstance = Fase.get(params.id)
            if(!faseInstance) {
                notFound_ajax()
                return
            }
        }
        return [faseInstance: faseInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def faseInstance = new Fase()
        if(params.id) {
            faseInstance = Fase.get(params.id)
            if(!faseInstance) {
                notFound_ajax()
                return
            }
        } //update
        faseInstance.properties = params
        if(!faseInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Fase."
            msg += renderErrors(bean: faseInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Fase exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def faseInstance = Fase.get(params.id)
            if(faseInstance) {
                try {
                    faseInstance.delete(flush:true)
                    render "OK_Eliminación de Fase exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Fase."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Fase."
    } //notFound para ajax

}
