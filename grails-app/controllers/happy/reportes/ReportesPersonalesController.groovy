package happy.reportes

import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.Paragraph
import com.lowagie.text.Phrase
import com.lowagie.text.pdf.PdfWriter
import happy.proceso.DetalleProceso
import happy.proceso.Fase
import happy.proceso.Proceso
import happy.proceso.ProcesoPersona
import happy.proceso.TramiteProceso
import happy.proceso.ValorProceso
import happy.seguridad.Persona;
import happy.seguridad.Shield
import happy.tramites.RolPersonaTramite

import java.awt.Color;

class ReportesPersonalesController extends Shield {

    def reportesPdfService
    def dbConnectionService

    Font font = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);
    Font fontBold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
    Font fontTh = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);

    def personal() {
        def usu = Persona.get(session.usuario.id)
        return [persona: usu]
    }


    def reporteProceso () {

        println("reporte proceso params " + params)

        def paramsCenter = [align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bg: Color.WHITE, borderColor: Color.GRAY]
        def paramsLeft = [align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, bg: Color.WHITE, borderColor: Color.GRAY]
        def paramsLeftColor = [align: Element.ALIGN_CENTER, valign: Element.ALIGN_CENTER, bg: Color.DARK_GRAY, borderColor: Color.GRAY]
        def paramsRight = [align: Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT, bg: Color.WHITE, borderColor: Color.GRAY ]

        def tramiteProceso = TramiteProceso.get(params.id)
        def datos = DetalleProceso.findAllByProceso(tramiteProceso?.procesoPersona?.proceso, [sort: 'orden', order: 'asc'])

        def sql
        def cn = dbConnectionService.getConnection()

        sql= "select fasedscr, datodscr, dtpcetqt, vlpcvlor\n" +
                "from dtpc left join vlpc on vlpc.dtpc__id = dtpc.dtpc__id, fase, dato\n" +
                "where dato.dato__id = dtpc.dato__id and fase.fase__id = dato.fase__id and  prcs__id = '${tramiteProceso?.procesoPersona?.proceso?.id}' "


        def fileName = "reporte_proceso_${tramiteProceso?.procesoPersona?.proceso?.nombre}"
        def title = tramiteProceso?.procesoPersona?.proceso?.nombre
        def title2 = tramiteProceso?.procesoPersona?.persona?.nombre + " " + tramiteProceso?.procesoPersona?.persona?.apellido

        def usuario = Persona.get(params.id)


        def baos = new ByteArrayOutputStream()
        def name = fileName + "_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";

        Document document = reportesPdfService.crearDocumento("v", [top: 2.5, right: 2.5, bottom: 1.5, left: 2.5])
        def pdfw = PdfWriter.getInstance(document, baos);

        session.tituloReporte = "Proceso: " + title

        reportesPdfService.membrete(document)
        document.open();
        reportesPdfService.propiedadesDocumento(document, "trámite")

        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_LEFT);
        paragraph.add(new Phrase('Cliente: ' + title2, fontBold));
        document.add(paragraph)

//        def tabla = reportesPdfService.crearTabla(reportesPdfService.arregloEnteros([17, 13, 19, 13, 13]), 10, 0)

        def faseUno

        cn.eachRow(sql.toString()){
            println(it)

            if(faseUno != it.fasedscr){

                def tablaCabecera = reportesPdfService.crearTabla(reportesPdfService.arregloEnteros([100]), 10,0)
                reportesPdfService.addCellTabla(tablaCabecera, new Paragraph(it?.fasedscr, fontBold), paramsLeftColor)
                document.add(tablaCabecera)

                faseUno = it.fasedscr

            }

            def tablaDatos = reportesPdfService.crearTabla(reportesPdfService.arregloEnteros([30,70]), 0,0)
            reportesPdfService.addCellTabla(tablaDatos, new Paragraph(it?.dtpcetqt + ": ", fontBold), paramsRight)
            reportesPdfService.addCellTabla(tablaDatos, new Paragraph(it?.vlpcvlor, font), paramsCenter)
            document.add(tablaDatos)


//            Paragraph dato = new Paragraph();
//            dato.setAlignment(Element.ALIGN_LEFT);
//            dato.add(new Phrase(it?.dtpcetqt, fontBold));
//            document.add(dato)

        }


        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)


    }

}
