#'	@title Pictorial Class Roll to by student
#'	@param plot_color plot the color shading values for the pixels while data is being digested in the function. Defaults to TRUE
#'	@param image_files the image files that are to be converted
#'	@notes requires the jpeg package
#' 	@example pdata = jpeg_roll()
#'	@export
jpeg_roll <-  function(image_files,plot_color=TRUE){

  all_names <-  vector("list",length(image_files))
  all_faces <-  vector("list",length(image_files))
  names(all_names) <-  gsub(".jpg","",image_files)
  names(all_faces) <-  gsub(".jpg","",image_files)

  for (files in image_files){
    browser()
    class = jpeg::readJPEG(files)
    # rows are multiple pixels
    average_color_row = apply(class[,,3],1,mean)
    row_lines3 = c(1:nrow(class))[average_color_row<min(average_color_row)+.035]
    row_lines = c(row_lines3[diff(row_lines3)!=1],row_lines3[length(row_lines3)])

    average_color_column = apply(class[,,3],2,mean)
    col_lines3 = c(1:ncol(class))[average_color_column<min(average_color_column)+.035]
    if(plot_color==TRUE) plot(c(apply(class[,,3],1,mean),apply(class[,,3],2,mean)))
    col_lines = c(col_lines3[diff(col_lines3)!=1],col_lines3[length(col_lines3)])


    students = vector("list",length=(length(row_lines)-1)*(length(col_lines)-1))
    students_picture = vector("list",length=(length(row_lines)-1)*(length(col_lines)-1))

    loc = 1
    for (i in 1:c(length(row_lines)-1)){
      print(i)
      rows = row_lines[i]:row_lines[i+1]
      rows_picture = row_lines[i]:c(row_lines[i]+420)
      for (j in 1:c(length(col_lines)-1)){
        #print(j)
        #print(loc)
        students[[loc]] = class[rows,col_lines[j]:col_lines[j+1],] # picture with text
        students_picture[[loc]] = class[rows_picture,col_lines[j]:col_lines[j+1],]    # picture only
        loc = loc + 1
      } # end j
    } # end i

    all_names[[gsub(".jpg","",files)]] = students
    all_faces[[gsub(".jpg","",files)]] = students_picture

    print(files)
  }
  list(all_names=all_names,all_faces=all_faces)

}  # end funtion
