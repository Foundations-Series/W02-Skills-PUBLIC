# source("/data/rab3/Playground/Justin/Code/R Library/Start.R")

library(data.table)

Dir.SynthData   <-  "C:/Users/justi/OneDrive/Work/CoLab_Workshop_2/SynthData"
Dir.Main        <-  "C:/Users/justi/OneDrive/Work/CoLab_Workshop_2"


SizeFactor      <-  1000

N.ID.Indiv     <- round(2500000 / SizeFactor)
N.ID.Business  <- round(1000000 / SizeFactor)


setwd(Dir.Main)
load(file = "SynthPackage.Rdata")


######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Library Fucnctions
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

Lib.RangeMap  <-  function(X,R, Closed.Right){ 
  
  if(missing(Closed.Right)){Closed.Right   <-  FALSE}  
  
  Cut     <-  cut(X, breaks = R, right = Closed.Right, include.lowest = TRUE )
  Levels  <-  levels(Cut)
  
  Value   <-  Lib.NA.To.Zero(as.numeric(Cut))
  Value[which(is.na(X))]  <-  NA
  
  return(Value)
  
  
}



Lib.NA.To.Zero   <-  function(X){
  
  X[which(is.na(X))]  <-  0
  
  return(X)
  
}

######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Method Definitions
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

#====================================================================================================#
# F.Method.Numeric
#====================================================================================================#

F.Method.Numeric    <-  function(VarDets, N.Gen){
  
  Quants      <-  VarDets$Dist$Quants
  
  N.Quants    <-  length(Quants)
  
  Min         <-  as.numeric(round(Quants[1] * Quants[1] /  Quants[2]))
  Max         <-  as.numeric(round(Quants[N.Quants] * Quants[N.Quants] /  Quants[N.Quants-1]))
  
  Q           <-  c(Min, as.numeric(Quants), Max)
  P           <-  c(0, as.numeric(gsub(pattern = "%", replacement = "", names(Quants) )), 100) / 100
  
  U           <-  runif(N.Gen)   
  
  Map         <-  Lib.RangeMap(U, P)
  P.Lower     <-  P[Map]       
  P.Upper     <-  P[Map + 1]  
  Q.Lower     <-  Q[Map]       
  Q.Upper     <-  Q[Map + 1]  
  
  X           <-  round(Q.Lower + (Q.Upper - Q.Lower) * (U - P.Lower) / (P.Upper - P.Lower))
  
  return(X)
  
  
}

#====================================================================================================#
# F.Method.Categorical
#====================================================================================================#

F.Method.Categorical    <-  function(VarDets, N.Gen){
  
  Table       <-  VarDets$Dist$Table
   
  P           <-  c(0, cumsum(as.numeric(Table)))
  V           <-  names(Table)
  
  U           <-  runif(N.Gen)
  
  Map         <-  Lib.RangeMap(U, P)
  
  X           <-  V[Map]
    
  return(X)
  
}


#====================================================================================================#
# F.Method.Identifier   
#====================================================================================================#

F.Method.Identifier   <- function(VarDets, N.Gen){
  
  Type        <-  VarDets$Dist$Type
  
  Split       <-  strsplit(Type,"_")[[1]]

  Individual  <-  Split[[1]] == "individual"
  Single      <-  Split[[2]] == "single"
  
  
  if(Individual){ID.Set <- ID.Set.Indiv} else {ID.Set <- ID.Set.Business}
  
  N.ID.Set     <-  length(ID.Set)
  
  if(Single){
    
    U               <-  runif(N.ID.Set)
    
    ID.Set.Sorted   <-  ID.Set[order(U)]
    
    X               <-  ID.Set.Sorted[1:N.Gen]
    
  } else {
    
    U               <-  runif(N.Gen)
    
    X               <-  ID.Set[ceiling(N.ID.Set * U)]
    
  }
  
  return(X)
  
}


######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Identifier Sets 
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

# This is not clever, just j=need to find one ID distirubtion file to use as the structural guide


SynthPackage[[1]][[1]][[1]]

Temp             <- SynthPackage[[c(1,1)]]
IDPackage        <- Temp$DataPackage[[1]]

ID.Set.Indiv     <-  sort(unique(F.Method.Numeric(IDPackage, N.ID.Indiv)))
ID.Set.Business  <-  sort(unique(F.Method.Numeric(IDPackage, N.ID.Business)))


######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# Generation 
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

N.SynthPackage    <-  length(SynthPackage)

for(i in 1:N.SynthPackage){
  
  
  FolderPackage    <-  SynthPackage[[i]]
  
  N.Files          <-  length(FolderPackage) 
  
  for(j in 1:N.Files){
    
   FilePackage    <-  FolderPackage[[j]]
    
   FileName       <-  FilePackage$FileName
   Folder         <-  FilePackage$Folder
   Rows           <-  FilePackage$Rows
   
   N.Gen          <-  ceiling(Rows / SizeFactor)
   
   setwd(Dir.SynthData)
   if(!dir.exists(Folder)){dir.create(Folder)}
   
   
   DataPackage    <-  FilePackage$DataPackage
   
   N.Vars         <-  length(DataPackage)
   
   DataSet        <-  list()
   
   for(k in 1:N.Vars){
     
     VarDets             <-  DataPackage[[k]]
     VarName             <-  VarDets$VarName
     Method              <-  VarDets$Method
     
     X                   <-  do.call(Method, list(VarDets, N.Gen))
     
     DataSet[[VarName]]  <-  X
   
  }
  
   DataSet  <-  data.frame(DataSet)
  
   setwd(paste0(Dir.SynthData, "/", Folder))
   fwrite(DataSet, file = FileName)
  
  
}

}
  
  


