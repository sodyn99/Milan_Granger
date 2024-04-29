# packages: https://cran.r-project.org/src/contrib/Archive/

req_lib <- c('forecast', 'tidyverse', 'lmtest', 'xtable', 'coda', 'mvtnorm')
for (pkg in req_lib) {
  if (!(pkg %in% rownames(installed.packages()))) {
    install.packages(pkg)
  } else {
    # update.packages(pkg)
    library(pkg, character.only = TRUE) 
  }
}
# --- Windows
# install.packages("installr")
# installr::install.rtools()
# 
install.packages("http://cran.nexr.com/src/contrib/MSBVAR_0.9-3.tar.gz")
require(MSBVAR)

data <- read_table("sms-call-internet-mi-2013-11-01.txt", col_names=c('gridID', 'timeInterval', 'countryCode', 'smsIn', 'smsOut', 'callIn', 'callOut', 'Internet'))

print(">>>>> data")
print(head(as.data.frame(data)))
# print(ndiffs(data$smsIn, alpha=0.05, test=c("kpss")))
# print(ndiffs(data$callIn, alpha=0.05, test=c("kpss")))

diff1_smsIn <- diff(data$smsIn, 1)
diff1_callIn <- diff(data$callIn, 1)
plot.ts(diff1_smsIn)
plot.ts(diff1_callIn)

grangertest(diff1_smsIn ~ diff1_callIn, order=4)

# granger.test(data, p=6)

