# https://weavejl.mpastell.com/stable/

using Pkg
Pkg.activate("../")
Pkg.instantiate()

using Weave

filename = normpath("./julia/", "julia_installation.md")

# Julia markdown to HTML
weave(filename; doctype = "md2html", out_path = "./julia/")

# # Julia markdown to PDF
# weave(filename; doctype = "md2pdf", out_path = :pwd)

# # Julia markdown to Pandoc markdown
# weave(filename; doctype = "pandoc", out_path = :pwd)