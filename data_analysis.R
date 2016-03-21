setwd(tempdir())

# url <- "http://www.camara.gov.br/cotas/AnoAtual.zip"
url <- "http://cl.ly/0o023M340H1n/download/AnoAtual.zip"
file_name <- "AnoAtual.xml"
if(!file.exists(file_name)) {
  zip_name <- "AnoAtual.zip"
  if(!file.exists(zip_name))
    download.file(url, zip_name, method = "curl")
  unzip(zip_name)
}

# Run the following for generating the CSV file
#     $ pip install xmlutils
#     $ xml2csv --input AnoAtual.xml --output AnoAtual.csv --tag "DESPESA"

data <- read.csv("AnoAtual.csv")
data <- data[!is.na(data$vlrDocumento), ]

data <- data[data$txNomeParlamentar == "TIRIRICA", ]
nrow(data)
