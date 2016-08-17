package happy.pdf

import org.xhtmlrenderer.pdf.ITextRenderer

class PdfService {

    boolean transactional = false

/*  A Simple fetcher to turn a specific URL into a PDF.  */

    byte[] buildPdf(url) {
        println("url --->" + url)
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ITextRenderer renderer = new ITextRenderer();
        try {
            println("entro")
            renderer.setDocument(url.toString());
            println("entro 2")
            renderer.layout();
            renderer.createPDF(baos);
            println("3 ")
            byte[] b = baos.toByteArray();
            println("bbb " + b)
            return b
        }
        catch (Throwable e) {
            println "error pdf service "+e
        }
    }

/*
  A Simple fetcher to turn a well formated XHTML string into a PDF
  The baseUri is included to allow for relative URL's in the XHTML string
*/

    byte[] buildPdfFromString(content, baseUri) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ITextRenderer renderer = new ITextRenderer();
        try {
            renderer.setDocumentFromString(content, baseUri);
            renderer.layout();
            renderer.createPDF(baos);
            byte[] b = baos.toByteArray();
            return b
        }
        catch (Throwable e) {
            log.error e
        }
    }

}


