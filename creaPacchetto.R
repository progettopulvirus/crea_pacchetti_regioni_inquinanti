list.dirs()->listaDirectory
listaDirectory[grepl("^./[a-z]+_?[a-z]+$",listaDirectory)]->listaDirectory

purrr::walk(listaDirectory,.f=function(nomeDirectory){
  
  setwd(nomeDirectory)
  unlist(stringr::str_split(getwd(),"/"))->lista
  lista[length(lista)]->nomeRegione
  
  sink(".gitignore")
  cat(paste0("*.csv","\n"))
  cat(paste0("data-raw","\n"))
  cat(paste0("*.Rproj","\n"))
  sink()

  sink(".Rbuildignore")
  cat(paste0("^.+Rproj$","\n"))
  cat(paste0("^.Rproj.user$","\n"))
  cat(paste0("data-raw","\n"))
  cat(paste0("^LICENSE.md$","\n"))
  sink()  
  
  usethis::create_package(getwd())
  usethis::use_mit_license("Guido Fioravanti")
  usethis::use_tibble()
  sink(glue::glue("./R/{nomeRegione}-package.R"))
  cat("## usethis namespace: start\n")
  cat("#' @importFrom tibble tibble\n")
  cat("## usethis namespace: end\n")
  cat("NULL\n")
  sink()
  
  
  #lista inquinanti
  list.files(pattern="^.+csv$")->nomiInquinanti
  stopifnot(length(nomiInquinanti)>0)
  
  purrr::walk(nomiInquinanti,.f=function(nome){
    readr::read_delim(nome,delim=";",col_names=TRUE)->dati
    stringr::str_remove(nome,"_[a-z]+\\.csv$")->inquinante

    assign(eval(inquinante),dati)
    rm(dati)
    
    ncol(get(inquinante))->NCOL
    nrow(get(inquinante))->NROW
    
    length(unique(get(inquinante)$station_eu_code))->NSTAZIONI
        
    glue::glue("usethis::use_data({inquinante},overwrite=TRUE)")->stringa
    eval(parse(text=stringa))
    sink(glue::glue("./R/{inquinante}.R"))
    cat(paste0(glue::glue("#' Tibble con i dati di {inquinante} per {NSTAZIONI} stazioni della regione {toupper(nomeRegione)}"),"\n"))
    cat("#'\n")
    cat(paste0(glue::glue("#' @format Un tibble con {NCOL} colonne e {NROW} osservazioni"),"\n"))
    cat(paste0("#'","\n"))
    cat(paste0("#' @usage","\n"))
    cat(paste0(glue::glue("#' {inquinante}"),"\n"))
    cat(paste0(glue::glue('"{inquinante}"'),"\n"))
    sink()
    
  })
  
  devtools::load_all()
  devtools::document()
  devtools::check(cran=FALSE)
  
  setwd(dir="../")
  
  
})
