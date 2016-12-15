# setwd(tempdir())
setwd("~/Downloads")

install.packages(c("ggplot2", "plyr"))
library(ggplot2)
library(plyr)

# url <- "http://www.camara.gov.br/cotas/AnoAtual.zip"
# url <- "http://cl.ly/0o023M340H1n/download/AnoAtual.zip"
# file_name <- "AnoAtual.xml"
# if(!file.exists(file_name)) {
#   zip_name <- "AnoAtual.zip"
#   if(!file.exists(zip_name))
#     download.file(url, zip_name, method = "curl")
#   unzip(zip_name)
# }

url <- "https://dl.dropboxusercontent.com/content_link/qduZUagnhcj25NDbcnIC4sJa3p4DJxgIlUhKVzSPX5poL9oDn9eeJRgXmdUYNMF3/file?dl=1"
file.name <- "AnoAtual.zip"
if(!file.exists(file.name))
  download.file(url, file.name, method = "curl")

# Run the following for generating the CSV file
#     $ pip install xmlutils
#     $ xml2csv --input AnoAtual.xml --output AnoAtual.csv --tag "DESPESA"

data <- read.csv("AnoAtual.csv")
data <- data[!is.na(data$vlrDocumento), ]

##########
## Monthly expenses
##########

sorted.by.expenses <- ddply(data,
                            "txNomeParlamentar",
                            summarize,
                            vlrDocumento = sum(vlrDocumento / 12))
sorted.by.expenses <- sorted.by.expenses[with(sorted.by.expenses, order(-vlrDocumento)), ]

data.mean <- mean(sorted.by.expenses$vlrDocumento)
ggplot(sorted.by.expenses) +
    geom_histogram(aes(vlrDocumento), binwidth = 500) +
    ggtitle("Gastos mensais") +
    xlab("Gasto mensal (R$)") +
    ylab("Deputados") +
    scale_x_continuous(labels = comma) +
    geom_vline(aes(xintercept = data.mean), size = 1) +
    geom_vline(aes(xintercept = data.mean + -sd(vlrDocumento))) +
    geom_vline(aes(xintercept = data.mean + sd(vlrDocumento)))


# data <- data[data$txNomeParlamentar == "TIRIRICA", ]
# nrow(data)
