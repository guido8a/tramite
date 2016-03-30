package happy.proceso

import happy.tramites.Tramite


class ValorProcesoController extends happy.seguridad.Shield {

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
            def c = ValorProceso.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ValorProceso.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def valorProcesoInstanceList = getLista(params, false)
        def valorProcesoInstanceCount = getLista(params, true).size()
        if (valorProcesoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        valorProcesoInstanceList = getLista(params, false)
        return [valorProcesoInstanceList: valorProcesoInstanceList, valorProcesoInstanceCount: valorProcesoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def valorProcesoInstance = ValorProceso.get(params.id)
            if (!valorProcesoInstance) {
                notFound_ajax()
                return
            }
            return [valorProcesoInstance: valorProcesoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def valorProcesoInstance = new ValorProceso(params)
        if (params.id) {
            valorProcesoInstance = ValorProceso.get(params.id)
            if (!valorProcesoInstance) {
                notFound_ajax()
                return
            }
        }
        return [valorProcesoInstance: valorProcesoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def valorProcesoInstance = new ValorProceso()
        if (params.id) {
            valorProcesoInstance = ValorProceso.get(params.id)
            if (!valorProcesoInstance) {
                notFound_ajax()
                return
            }
        } //update
        valorProcesoInstance.properties = params
        if (!valorProcesoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ValorProceso."
            msg += renderErrors(bean: valorProcesoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ValorProceso exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def valorProcesoInstance = ValorProceso.get(params.id)
            if (valorProcesoInstance) {
                try {
                    valorProcesoInstance.delete(flush: true)
                    render "OK_Eliminación de ValorProceso exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ValorProceso."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ValorProceso."
    } //notFound para ajax

    def asignarValor () {
        println("params asignar valor" + params)

        def tramite = Tramite.get(params.id);
        def pccl = ProcesoPersona.get(params.proceso);

        def trpc = TramiteProceso.findByTramiteAndProcesoPersona(tramite, pccl);

        if(!trpc){
         trpc = new TramiteProceso()
         trpc.tramite = tramite
         trpc.procesoPersona = pccl
            try{
                trpc.save(flush: true)
            }catch(e){
                println("error al guardar el tramiteProceso")
            }
        }

        def datos = DetalleProceso.findAllByProceso(trpc?.procesoPersona?.proceso, [sort: 'orden', order: 'asc'])

        return [trpc: trpc, datos: datos]

    }

    def procesos_ajax() {

    }

}
