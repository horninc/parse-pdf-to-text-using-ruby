# parse-pdf-to-text-using-ruby

Place your PDF files in folder /pdfs
and run code from command line using.

`ruby parse.rb`

Parsed text file will be placed in folder txts with name

pdfs/file_name.pdf -> txts/file_name.pdf.txt

In case a file with an extension \*.txt already exists within the folder txts it will be overwritten with a new file if th script is run more than once. 