######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Library Functions
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################


Lib.NameByMap    <-  function(Data, NameMap){
  
  Names.Base                          <-  names(Data)
  
  Match                               <-  match(Names.Base, names(NameMap))
  
  Names.New                           <-  NameMap[Match]
  
  Which                               <-  which(is.na(Names.New))
  
  Names.New[Which]                    <-  Names.Base[Which]
  
  return(as.character(Names.New))
  
}




######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Setup Stuff [Step 1: Identify data]
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

# source("/data/rab3/Playground/Justin/Code/R Library/Start.R")

library(data.table)

Dir.Individuals   <-  "/data/rab3/Playground/Justin/SyntheticThinking/AICoLab/SyntheticTest/ALife_Individuals/"


setwd(Dir.Individuals)

Files         <- list.files()
Get.Vars      <-  c("alife_id_001", 
                    "c_age_30_june", 
                    "c_gender",
                    "c_birth_fy",
                    "i_salary_wage",
                    "ic_total_income_loss",
                    "ic_taxable_income_loss")


Get.Years     <-  seq(2015, 2025)
N.Get.Years   <-  length(Get.Years)


######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Data Load & Merge [Step 2: Organise data]
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

#====================================================================================================#
# ALife
#====================================================================================================#


setwd(Dir.Individuals)

Data          <-  list()

for(i in 1:N.Get.Years){
  
  
  i.Year                    <-  Get.Years[i]
  FileName                  <-  paste0("aLife10_tax_", Get.Years[i], ".csv")
  Temp                      <-  fread(FileName, integer64 = "numeric", select = Get.Vars)
  
  NameMap                   <-  paste0(Get.Vars, "_" , i.Year)
  names(NameMap)            <-  Get.Vars
  
  NameMap["alife_id_001"]   <-  "alife_id_001"
  
  names(Temp)               <-  Lib.NameByMap(Temp, NameMap)
  
  
  Temp[[paste0('lodger_', i.Year)]]  <-  1
  
  Data[[i]]                 <-  Temp
  
  print(i)
}



F.Merge   <-  function(x, y){
  
  return(merge(x, y, by = "alife_id_001", all = TRUE))
  
}


Data     <-  data.frame(Reduce(F.Merge, Data))

