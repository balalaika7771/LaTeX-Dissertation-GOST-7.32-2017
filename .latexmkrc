$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

$out_dir = 'build';
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=build %O %S';
$biber = 'biber build/%B';

$cleanup_includes_generated = 1;
$cleanup_includes = 1;

$pdf_previewer = 'open -a Preview';
