######################################################################################################
# Library Functions
######################################################################################################

Lib.NameByMap <- function(Data, NameMap) {
  Names.Base <- names(Data)
  Match <- match(Names.Base, names(NameMap))
  Names.New <- NameMap[Match]
  Which <- which(is.na(Names.New))
  Names.New[Which] <- Names.Base[Which]
  return(as.character(Names.New))
}


######################################################################################################
# Setup Stuff [Step 1: Identify data]
######################################################################################################

library(data.table)

Dir.Individuals <- "C:/Users/justi/OneDrive/Documents/GitHub/W02-Skills-PUBLIC/alife_material/SynthData/ALife_Individuals/"

setwd(Dir.Individuals)

Get.Vars <- c(
  "alife_id_001",
  "ic_taxable_income_loss",
  "tc_gross_tax"
)

Get.Years <- c(2015, 2025)
N.Get.Years <- length(Get.Years)


######################################################################################################
# Data Load & Merge [Step 2: Organise data]
######################################################################################################

Data <- vector("list", N.Get.Years)
Rows.Loaded <- integer(N.Get.Years)

for (i in seq_len(N.Get.Years)) {
  i.Year <- Get.Years[i]
  FileName <- paste0("aLife10_tax_", i.Year, ".csv")
  Temp <- fread(FileName, integer64 = "numeric", select = Get.Vars)
  Rows.Loaded[i] <- nrow(Temp)

  if (anyDuplicated(Temp$alife_id_001) > 0) {
    stop(paste("More than one row per alife_id_001 in", FileName))
  }

  NameMap <- paste0(Get.Vars, "_", i.Year)
  names(NameMap) <- Get.Vars
  NameMap["alife_id_001"] <- "alife_id_001"
  names(Temp) <- Lib.NameByMap(Temp, NameMap)

  Temp[[paste0("lodger_", i.Year)]] <- 1
  Data[[i]] <- Temp
}

F.Merge <- function(x, y) {
  return(merge(x, y, by = "alife_id_001", all = TRUE))
}

Rows.By.Year <- data.frame(
  income_year = Get.Years,
  rows_loaded = Rows.Loaded
)

Data <- as.data.frame(Reduce(F.Merge, Data))
Unique.IDs <- length(unique(Data$alife_id_001))
People.Missing.By.Year <- vapply(
  Get.Years,
  function(year) sum(is.na(Data[[paste0("lodger_", year)]])),
  integer(1)
)

cat("Rows loaded by year:\n")
print(Rows.By.Year, row.names = FALSE)
cat("Rows after full outer merge:", nrow(Data), "\n")
cat("Unique alife_id_001 values:", Unique.IDs, "\n")
cat("People missing from each year's file:\n")
print(data.frame(
  income_year = Get.Years,
  people_missing = People.Missing.By.Year
), row.names = FALSE)
