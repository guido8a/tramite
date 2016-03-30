package happy.proceso

import happy.tramites.TipoDocumento


class ProcesoDocumentoController extends happy.seguridad.Shield {

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
            def c = ProcesoDocumento.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ProcesoDocumento.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def procesoDocumentoInstanceList = getLista(params, false)
        def procesoDocumentoInstanceCount = getLista(params, true).size()
        if (procesoDocumentoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        procesoDocumentoInstanceList = getLista(params, false)
        return [procesoDocumentoInstanceList: procesoDocumentoInstanceList, procesoDocumentoInstanceCount: procesoDocumentoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def procesoDocumentoInstance = ProcesoDocumento.get(params.id)
            if (!procesoDocumentoInstance) {
                notFound_ajax()
                return
            }
            return [procesoDocumentoInstance: procesoDocumentoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def procesoDocumentoInstance = new ProcesoDocumento(params)
        if (params.id) {
            procesoDocumentoInstance = ProcesoDocumento.get(params.id)
            if (!procesoDocumentoInstance) {
                notFound_ajax()
                return
            }
        }
        return [procesoDocumentoInstance: procesoDocumentoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def procesoDocumentoInstance = new ProcesoDocumento()
        if (params.id) {
            procesoDocumentoInstance = ProcesoDocumento.get(params.id)
            if (!procesoDocumentoInstance) {
                notFound_ajax()
                return
            }
        } //update
        procesoDocumentoInstance.properties = params
        if (!procesoDocumentoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ProcesoDocumento."
            msg += renderErrors(bean: procesoDocumentoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ProcesoDocumento exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def procesoDocumentoInstance = ProcesoDocumento.get(params.id)
            if (procesoDocumentoInstance) {
                try {
                    procesoDocumentoInstance.delete(flush: true)
                    render "OK_Eliminación de ProcesoDocumento exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ProcesoDocumento."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ProcesoDocumento."
    } //notFound para ajax


    def saveProcesoDocumento_ajax () {
        println("params save proceso doc " + params)

        def tipoDocumento = TipoDocumento.get(params.tipo)
        def proceso = Proceso.get(params.id)
        def procesoDocumento


        def pd = ProcesoDocumento.findByProceso(proceso)

        if(pd){
            procesoDocumento = ProcesoDocumento.get(pd.id)
            procesoDocumento.tipoDocumento = tipoDocumento

            try {
                procesoDocumento.save(flush: true)
                render "ok"
            }catch (e){
                render "no"
                println("error al guardar el tipo de documento en el proceso" + procesoDocumento.errors)
            }

        }else{

            procesoDocumento = new ProcesoDocumento()
            procesoDocumento.tipoDocumento = tipoDocumento
            procesoDocumento.proceso = proceso

            try {
                procesoDocumento.save(flush: true)
                render "ok"
            }catch (e){
                render "no"
                println("error al guardar el tipo de documento en el proceso" + procesoDocumento.errors)
            }
        }
    }

}
