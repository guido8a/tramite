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
        def procesoDocumento


        if(params.id){
            proceso = Proceso.get(params.id)
            procesoDocumento = ProcesoDocumento.findByProceso(proceso)
        }

        return [proceso: proceso, procesoDocumento: procesoDocumento]
    }

    def saveProceso_ajax () {
//        println("params save pro " + params)

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

//        println("params da" + params)

        def fase = Fase.get(params.id)
        def datos = Dato.findAllByFase(fase)
        def proceso = Proceso.get(params.idPro)

        return [datos: datos, proceso: proceso]

    }

    def tablaDatos_ajax () {
//        println("tabla datos " + params)
        def dato = Dato.get(params.id)
        def proceso = Proceso.get(params.idPro)
        def detalleProceso = DetalleProceso.findByDatoAndProceso(dato, proceso)

        return [detalleProceso: detalleProceso, dato: dato, proceso: proceso]

    }


    def saveDetalle_ajax() {

//        println("save deta " + params)

        def dato = Dato.get(params.idD)
        def proceso = Proceso.get(params.idP)
        def detalleProceso
        def cadena

        if(params.idDP){
        detalleProceso = DetalleProceso.get(params.idDP)
        detalleProceso.etiqueta = params.etiqueta
        detalleProceso.orden = params.orden.toInteger()
        if(dato?.tipo == 'String'){
            cadena = (params.desde + "," + params.hasta)
            detalleProceso.rango = cadena
        }else{
            detalleProceso.numericoMinimo = params.desde
            detalleProceso.numericoMaximo = params.hasta

        }

        detalleProceso.aporte = params.aporte.toDouble()
        detalleProceso.posicionReporte = params.posicion.toInteger()
        detalleProceso.observacion = params.observacion

        if(params.nulo == 'false'){
            detalleProceso.nulo = '0'
        }else{
            detalleProceso.nulo = '1'
        }
        if(params.ruta == 'false'){
                detalleProceso.ruta = '0'
        }else{
                detalleProceso.ruta = '1'
        }

        detalleProceso.fechaModificacion = new Date()

            try {
                detalleProceso.save(flush: true)
                render "ok_" + detalleProceso?.id
                println("de act " + detalleProceso.id)
            }catch(e){
                println("error actualizar detalleproceso" + detalleProceso.errors)
                render "no"
            }

        }else{

            detalleProceso = new DetalleProceso();
            detalleProceso.dato = dato
            detalleProceso.proceso = proceso
            detalleProceso.etiqueta = params.etiqueta
            detalleProceso.orden = params.orden
            if(dato?.tipo == 'String'){
                cadena = (params.desde + "," + params.hasta)
                detalleProceso.rango = cadena
                detalleProceso.numericoMaximo = 0
                detalleProceso.numericoMinimo = 0
            }else{
                detalleProceso.rango = 'numerico'
                detalleProceso.numericoMinimo = params.desde
                detalleProceso.numericoMaximo = params.hasta
            }

            detalleProceso.aporte = params.aporte.toDouble()
            detalleProceso.posicionReporte = params.posicion
            detalleProceso.observacion = params.observacion
            if(params.nulo == false){
                detalleProceso.nulo = '0'
            }else{
                detalleProceso.nulo = '1'
            }
            if(params.ruta == false){
                detalleProceso.ruta = '0'
            }else{
                detalleProceso.ruta = '1'
            }

            detalleProceso.fecha = new Date()
            detalleProceso.fechaModificacion = new Date()

            try {
                detalleProceso.save(flush: true)
                detalleProceso.refresh();
                render "ok_" + detalleProceso?.id
            }catch(e){
                println("error al guardar detalleproceso" + detalleProceso.errors)
                render "no"
            }

        }

    }

    def lista_ajax () {

        def detalle = DetalleProceso.get(params.idDetalle);

        return [detalle: detalle]
    }

    def tablaLista_ajax () {

        def detalle = DetalleProceso.get(params.id);
        def listaDetalle = ListaValores.findAllByDetalleProceso(detalle);

        return [lista: listaDetalle, detalle: detalle]
    }

    def saveItems_ajax () {

        def detalleProceso = DetalleProceso.get(params.idDetalle);
        def itemLista

        itemLista = new ListaValores()
        itemLista.detalleProceso = detalleProceso
        itemLista.descripcion = params.descripcion
        itemLista.defecto = '0'

        try {
            itemLista.save(flush: true)
            render "ok"
        }catch(e){
            render "no"
            print("error al guardar el item de la lista " + itemLista.errors)
        }

    }

    def saveDefecto_ajax () {

//        println("params " + params)

        def lista = ListaValores.get(params.id)
        def detalle = DetalleProceso.get(lista.detalleProceso.id)
        def otrosItems = ListaValores.findAllByDetalleProceso(detalle)

        if(otrosItems != null || otrosItems != ''){
            otrosItems.each { t->
                t.defecto = '0'
                t.save(flush: true)
            }
        }

        lista.defecto = '1'
        try {
            lista.save(flush: true)
            render "ok"
        }catch(e){
            render "no"
        }
    }

    def borrarLista_ajax () {

        def item = ListaValores.get(params.id)

        try{
            item.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al borrar el item " + item.errors)
        }

    }

}
