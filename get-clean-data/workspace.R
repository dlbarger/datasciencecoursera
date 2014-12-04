file <-"c:\\workspace\\data\\x12\\x12-837.pdf"
if(all(file.exists(Sys.which(c("pdfinfo","pdftotext"))))) {
    pdf <- readPDF(control=list(text="-layout"))
    (elem=list(uri=file), language="en", id="id1")
    #content(pdf) [1:13]
}