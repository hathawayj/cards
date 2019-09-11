#'	@title PDF to image conversion (imagemagick)
#'	@param magick_path the full character path to the imagemagick convert command.  For example, "C:\\Program Files\\ImageMagick-6.9.2-Q16\\convert.exe" is the default.
#'  @param image_type the type of image format to use in the conversion. Will only do one conversion time per function call.  Input as character and 'jpg' is the default.
#'	@param files the files to be converted.  Input as a list of character strings.  The working directory will be pre appended to the file names.
#'  @examples pdf_2image(files=file.choose())
#'
#'	@export
pdf_2image <-  function(file = file.choose(), image_type = "jpg", path_out = NULL){
  if(is.null(path_out)) path_out <- fs::path_dir(file)
  pdf_dat <- magick::image_read_pdf(file)
  pages <- length(pdf_dat)
  purrr::map(1:pages, ~magick::image_write(magick::image_convert(pdf_dat[.x], image_type),
                                           path = fs::path(path_out, stringr::str_c("page_", .x), ext = image_type)))
  path_out
}
