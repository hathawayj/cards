# cards
Make Printable Flash cards from BYU-I Picture Rolls

To install the package.

```r
devtools::install_github("hathawayj/cards")
library(cards
```

load libraries

```r
library(tidyverse)
library(jpeg)
library(grid)
library(ggplot2)
```

The example works partially.  I have not had problems with the pdf files downloaded from BYU-I - <https://web.byui.edu/FacultyClasses/ClassList>. My tweaking of the file so for the example makes it not work as clear but the point of the functions and package is shown.

```r
# example file. pdf_path is the filepath to your pdf.
pdf_path <- system.file("extdata", "faces.pdf", package = "cards")

# this is the folder where you want the jpeg images written. May want to reset for each pdf.
temp_path <- fs::path_temp()

# if your pdf is in its own folder you can leave path_out as null.
dir_path <- pdf_2image(file = pdf_path, path_out = temp_path)
jpg_files <-  fs::dir_ls(dir_path, regexp =  "jpg")
pdata <-  jpeg_roll(image_files = jpg_files)

gg_object <-  ggplot_faces(faces = pdata$all_faces,faces_names = pdata$all_names)

flashcard_pdf(gg_object,pdf_name = fs::path("Fall_2019.pdf"))
flashcard_pdf(gg_object,pdf_name = fs::path(dir_path, "Fall_2019_oneside.pdf"),front_back = FALSE)

```
