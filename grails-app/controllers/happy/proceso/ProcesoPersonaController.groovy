package happy.proceso

import happy.seguridad.Persona
import happy.tramites.TipoDocumento
import happy.tramites.Tramite


class ProcesoPersonaController extends happy.seguridad.Shield {

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
            def c = ProcesoPersona.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ProcesoPersona.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def procesoPersonaInstanceList = getLista(params, false)
        def procesoPersonaInstanceCount = getLista(params, true).size()
        if (procesoPersonaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        procesoPersonaInstanceList = getLista(params, false)
        return [procesoPersonaInstanceList: procesoPersonaInstanceList, procesoPersonaInstanceCount: procesoPersonaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def procesoPersonaInstance = ProcesoPersona.get(params.id)
            if (!procesoPersonaInstance) {
                notFound_ajax()
                return
            }
            return [procesoPersonaInstance: procesoPersonaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def procesoPersonaInstance = new ProcesoPersona(params)
        if (params.id) {
            procesoPersonaInstance = ProcesoPersona.get(params.id)
            if (!procesoPersonaInstance) {
                notFound_ajax()
                return
            }
        }
        return [procesoPersonaInstance: procesoPersonaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def procesoPersonaInstance = new ProcesoPersona()
        if (params.id) {
            procesoPersonaInstance = ProcesoPersona.get(params.id)
            if (!procesoPersonaInstance) {
                notFound_ajax()
                return
            }
        } //update
        procesoPersonaInstance.properties = params
        if (!procesoPersonaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ProcesoPersona."
            msg += renderErrors(bean: procesoPersonaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ProcesoPersona exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def procesoPersonaInstance = ProcesoPersona.get(params.id)
            if (procesoPersonaInstance) {
                try {
                    procesoPersonaInstance.delete(flush: true)
                    render "OK_Eliminación de ProcesoPersona exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ProcesoPersona."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ProcesoPersona."
    } //notFound para ajax

    def asignarProceso () {

    }

    def tablaAsignados_ajax () {

        def persona = Persona.get(params.id);
        def procesosPersona = ProcesoPersona.findAllByPersona(persona);

        return [procesos: procesosPersona, persona: persona]
    }

    def saveProcesoPersona_ajax () {
//        println("params save " + params)

        def persona = Persona.get(params.idC);
        def proceso = Proceso.get(params.idP);

        def procesoExistente = ProcesoPersona.findByPersonaAndProceso(persona, proceso)

        if(procesoExistente){

            render "no_" + "existente"

        }else{
            def procesoPersona = new ProcesoPersona();

            procesoPersona.persona = persona
            procesoPersona.proceso = proceso

            if(params.estado == 'Activo'){
                procesoPersona.estado = 1
            }else{
                procesoPersona.estado = 0
            }

            try{
                procesoPersona.save(flush: true)
                render "ok_"
            }catch(e){
                render "no_" + "error"
                println("error al asignar proceso a la persona" + procesoPersona.errors)
            }
        }




    }

    def borrarProcesoAsignado_ajax () {

//        println("params borrar proceso " + params)

        def procesoPersona = ProcesoPersona.get(params.id)

        try{
            procesoPersona.delete(flush: true)
            render "ok"
        }catch(e){
            render "no"
            println("error al borra proceso persona " + procesoPersona.delete())
        }
    }

    def revisarProcesos_ajax () {

        def tramite = Tramite.get(params.idTramite)
        def tipoDoc = tramite.tipoDocumento.codigo


        return[tramite: tramite, tipo: tipoDoc]
    }

    def procesos_ajax () {

        def cliente = Persona.get(params.idCliente)
        def tipoDoc = TipoDocumento.findByCodigo(params.tipoCodigo)
        def pctd = ProcesoDocumento.findAllByTipoDocumento(tipoDoc).proceso
        def pccl = ProcesoPersona.findAllByPersonaAndProcesoInList(cliente,pctd)

        return [proceso: pccl]
    }

}
