package happy.proceso

import happy.tramites.Tramite
import static org.apache.commons.collections.CollectionUtils.*


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

        def vlpc = ValorProceso.findAllByDetalleProcesoInListAndProcesoPersona(datos,pccl)


        return [trpc: trpc, datos: datos, pccl: pccl, vlpc: vlpc, pro: params.proceso]

    }

    def editarValores () {
        println("params asignar valor" + params)
        def pccl = ProcesoPersona.get(params.id);

        def datos = DetalleProceso.findAllByProceso(pccl?.proceso, [sort: 'orden', order: 'asc'])

        def vlpc = ValorProceso.findAllByDetalleProcesoInListAndProcesoPersona(datos, pccl)

        println "editarValores, pccl: ${pccl?.persona}"
//        render view: asignarValor(action: "asignarValor", datos: datos, pccl: pccl, vlpc: vlpc, pro: pccl.proceso)
        render view: "asignarValor", model: [datos: datos, pccl: pccl, vlpc: vlpc, pro: pccl.proceso]
    }

    def procesos_ajax() {

    }

    def saveValor_ajax () {

        println("params save valor " + params)

        def procesoPersona = ProcesoPersona.get(params.pccl)
        def detalleProceso = DetalleProceso.get(params.dtpc)
        def valorProceso

        if(params.vlpc){
            valorProceso = ValorProceso.get(params.vlpc)
            valorProceso.valor =  params.val
            valorProceso.observaciones = params.obs
            valorProceso.fechaModificacion = new Date();

            try{
                valorProceso.save(flush: true)
                render "ok"
            }catch(e){
                render "no"
                println("error al guardar el valor " + valorProceso.errors)
            }

        }else{
            valorProceso = new ValorProceso()
            valorProceso.procesoPersona = procesoPersona
            valorProceso.detalleProceso = detalleProceso
            valorProceso.valor =  params.val
            valorProceso.observaciones = params.obs
            valorProceso.fecha = new Date();
            valorProceso.fechaModificacion = new Date();

            try{
                valorProceso.save(flush: true)
                render "ok"
            }catch(e){
                render "no"
                println("error al guardar el valor " + valorProceso.errors)
            }

        }

    }


    def guardarListaMarcada_ajax () {

        println("params lista " + params)

        def arr = []

        def detalleProceso = DetalleProceso.get(params.dtpc)
        def pccl = ProcesoPersona.get(params.pccl)
        def listaCompleta = ListaValores.findAllByDetalleProceso(detalleProceso)
        def marcados = []
        def arreglo



        if(!params.arreglo){
            marcados = []
        }else{
            arreglo = params.arreglo
            marcados = arreglo.split(",").toList()
        }

        println("marcados " + marcados)

        def listaValores = ValorProceso.findAllByDetalleProceso(detalleProceso).valor

        def comunes
        def borrar
        def vlpc
        def errores = ''

        println("lista valores " + listaValores)

        if(!listaValores){
            if(marcados){
                println("agrega todos")

                marcados.each { m->
                   vlpc = new ValorProceso()
                    vlpc.detalleProceso = detalleProceso
                    vlpc.procesoPersona = pccl
                    vlpc.valor = m
                    vlpc.fecha = new Date()
                    vlpc.fechaModificacion = new Date()

                    try{
                        vlpc.save(flush: true)
                    }catch(e){
                        errores += vlpc.errors
                        println("agregar todos - error")
                    }

                }

                if(errores == ''){
                    render "ok"
                }else{
                    render "no"
                }
            }else{
                println("no pasa nada")
                render "ok"
            }
        }else{
            if(marcados){
                if(disjunction(marcados,listaValores)){
                    comunes = marcados.intersect(listaValores)
                    marcados.removeAll(comunes)
                    listaValores.removeAll(comunes)

                    def mb
                    listaValores.each {b->
                        mb = ValorProceso.findByValorAndDetalleProceso(b,detalleProceso)
                        try{
                            mb.delete(flush: true)
                        }catch(e){
                            errores += mb.errors
                            println("borrados dis - error")
                        }
                    }


                    marcados.each { n->
                        vlpc = new ValorProceso()
                        vlpc.detalleProceso = detalleProceso
                        vlpc.procesoPersona = pccl
                        vlpc.valor = n
                        vlpc.fecha = new Date()
                        vlpc.fechaModificacion = new Date()
                        try{
                            vlpc.save(flush: true)
                        }catch(e){
                            errores += vlpc.errors
                            println("agregar marcados - error")
                        }

                    }


                    if(errores == ''){
                        render "ok"
                    }else{
                        render "no"
                    }


                }else{
                    render "ok"
                    println("no pasa nada")
                }

            }else{
                println("borra todos")

                def pb
                listaValores.each {b->
                pb = ValorProceso.findByValorAndDetalleProceso(b,detalleProceso)
                try{
                    pb.delete(flush: true)
                }catch(e){
                    errores += pb.errors
                    println("borrados todos - error")
                }
                }


                if(errores == ''){
                    render "ok"
                }else{
                    render "no"
                }

            }
        }


    }




}
