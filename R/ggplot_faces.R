
#' 	@title ggplot faces
#' 	@param faces This variable uses the all_faces object in the list ouput from the jpeg_roll function.
#' 	@param faces_names This variable uses the all_names object in the list ouput from the jpeg_roll function.
#'	@notes may only work if more than one image was digested in the jpeg_roll function. Requires that the ggplot2 and grid package are loaded.
#'	@example gg_object = ggplot_faces(faces=pdata$all_faces,faces_names=pdata$all_names)
#'	@export
ggplot_faces = function(faces,faces_names){
  ### The below for loop creates all the ggplot picture objects
  faces = unlist(faces,recursive=FALSE)
  faces_names = unlist(faces_names,recursive=FALSE)
  Pstudents = Pstudents_picture=NULL
  for (k in 1:length(faces_names)){
    Pstudents[[k]]=qplot(1:10, 1:10, geom="blank") +
      annotation_custom(rasterGrob(faces_names[[k]], interpolate=TRUE), xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)+
      theme(line = element_blank(),
            text = element_blank(),
            title = element_blank(),
            rect = element_blank(),
            plot.margin=unit(c(0,0,0,0),"mm"))+
      labs(x=NULL,y=NULL)

    Pstudents_picture[[k]]=qplot(1:10, 1:10, geom="blank") +
      annotation_custom(rasterGrob(faces[[k]], interpolate=TRUE), xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)+
      theme(line = element_blank(),
            text = element_blank(),
            title = element_blank(),
            rect = element_blank(),
            plot.margin=unit(c(0,0,0,0),"mm"))+
      labs(x=NULL,y=NULL)

    print(Pstudents[[k]])

  } # end for loop
  list(faces=Pstudents_picture,faces_names=Pstudents)
}
