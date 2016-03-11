package happy.proceso


class DatoController extends happy.seguridad.Shield {

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
            def c = Dato.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Dato.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def datoInstanceList = getLista(params, false)
        def datoInstanceCount = getLista(params, true).size()
        if (datoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        datoInstanceList = getLista(params, false)
        return [datoInstanceList: datoInstanceList, datoInstanceCount: datoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def datoInstance = Dato.get(params.id)
            if (!datoInstance) {
                notFound_ajax()
                return
            }
            return [datoInstance: datoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def datoInstance = new Dato(params)
        if (params.id) {
            datoInstance = Dato.get(params.id)
            if (!datoInstance) {
                notFound_ajax()
                return
            }
        }
        return [datoInstance: datoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def datoInstance = new Dato()
        if (params.id) {
            datoInstance = Dato.get(params.id)
            if (!datoInstance) {
                notFound_ajax()
                return
            }
        } //update
        datoInstance.properties = params
        if (!datoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Dato."
            msg += renderErrors(bean: datoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Dato exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def datoInstance = Dato.get(params.id)
            if (datoInstance) {
                try {
                    datoInstance.delete(flush: true)
                    render "OK_Eliminación de Dato exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Dato."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Dato."
    } //notFound para ajax



    def cargarDatos () {

    }


    def datos_ajax () {

        def datos = Dato.list()
        return datos
    }


    def tablaDatos_ajax () {

        def fase = Fase.get(params.idFase)
        def datos = Dato.findAllByFase(fase)

        return [datos: datos]
    }


    def saveDato_ajax() {
        println("params save" + params)

        def fase = Fase.get(params.id)

        def nuevoDato

        if(params.idDato){

            nuevoDato = Dato.get(params.idDato)

            nuevoDato.descripcion = params.descripcion
            nuevoDato.valor = params.valor
            nuevoDato.tipo = params.tipo

        }else{

            nuevoDato = new Dato();

            nuevoDato.fase =  fase
            nuevoDato.descripcion = params.descripcion
            nuevoDato.valor = params.valor
            nuevoDato.tipo = params.tipo
        }

        try {

            nuevoDato.save(flush: true)
            render "ok"

        }catch(e){
            println("error grabar datos " + nuevoDato.errors)
            render "no"

        }

    }

    def borrarDato_ajax() {
        println("params borrar" + params)
        def dato = Dato.get(params.id)

        try{
            dato.delete(flush: true)
            render "ok"
        }catch(e){
            println("errores borrado datos " + dato.errors)
            render "no"
        }
    }



}
