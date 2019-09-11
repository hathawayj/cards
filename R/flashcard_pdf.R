
#'	@title flashcards
#'	@param ggplot_object the object that is output from the ggplot_faces function
#'	@param pdf_name a character string with the name of the file to be saved.  Will be saved to working directory.
#'	@param front_back states wether to make the pdf output work for a front back printer or to create two pdfs for a basic printer.  Defaults to `TRUE` for a front and back printer.
#'	@example flashcard_pdf(gg_object,pdf_name="Fall_108_2015.pdf")
#'	@export
flashcard_pdf <-  function(ggplot_object, pdf_name = "student_cards.pdf", front_back = TRUE){
  ##### This set of code builds the printable pdfs
  Pstudents = ggplot_object$faces
  Pstudents_picture = ggplot_object$faces_names

  if (front_back == TRUE) {
    extra = 0
    pdf(file = pdf_name,width = 8.5, height = 11)

    for (p in 1:ceiling(length(Pstudents)/12) ) {

      if (extra + 12 <= length(Pstudents)) {
        multiplot(plotlist = Pstudents[1:12 + extra], layout = matrix(1:12, nrow = 3, byrow = T))
        multiplot(plotlist = Pstudents_picture[1:12 + extra], layout = matrix(c(4:1,8:5,12:9), nrow = 3, byrow = T))
      }
      if (extra + 12 > length(Pstudents)) {
        final_set = (extra):length(Pstudents)
        multiplot(plotlist = Pstudents[final_set], layout = matrix(1:12, nrow = 3, byrow = T))
        multiplot(plotlist = Pstudents_picture[final_set], layout = matrix(c(4:1,8:5,12:9), nrow = 3, byrow = T))
      }
      extra = extra + 12
      print(extra)

    } # end for p
    dev.off()
  } # end front_back if
  # one sided two times puts the faces out first then prints out the names in two different list objects
  if (front_back == FALSE) {
    extra = 0
    pdf(file = stringr::str_replace(pdf_name, ".pdf", "_front.pdf"), width = 8.5, height = 11)

    for (p in 1:ceiling(length(Pstudents)/12) ) {

      if (extra + 12 <= length(Pstudents)) {
        multiplot(plotlist = Pstudents[1:12 + extra], layout = matrix(1:12, nrow = 3, byrow = T))
      }
      if (extra + 12 > length(Pstudents)) {
        final_set = (extra):length(Pstudents)
        multiplot(plotlist = Pstudents[final_set], layout = matrix(1:12, nrow = 3, byrow = T))
      }
      extra = extra + 12
      print(extra)
    } # end for p
    dev.off()
    # now the back pdf
    extra = 0
    pdf(file = stringr::str_replace(pdf_name, ".pdf", "_back.pdf"), width = 8.5, height = 11)
    for (p in 1:ceiling(length(Pstudents)/12) ) {

      if (extra + 12 <= length(Pstudents)) {
        multiplot(plotlist = Pstudents_picture[1:12 + extra], layout = matrix(c(4:1,8:5,12:9), nrow = 3, byrow = T))
      }
      if (extra + 12 > length(Pstudents)) {
        final_set = (extra):length(Pstudents)
        multiplot(plotlist = Pstudents_picture[final_set], layout=matrix(c(4:1,8:5,12:9), nrow = 3, byrow = T))
      }
      extra = extra + 12
      print(extra)

    } # end for p
    dev.off()
  }

}
