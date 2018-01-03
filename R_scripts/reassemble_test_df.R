setwd("~/Documents/wsdm_kkbox/data")

#/!\ Run subset_for_FM.R before this one !

used_test_rows = read.table(file = 'used_test_rows.txt')
used_test_rows = used_test_rows$x
unused_test_rows = read.table(file = 'unused_test_rows.txt')
unused_test_rows = unused_test_rows$x

ben_answers = read.table(file = 'ben_answers.csv', sep = ',', skip = 1)
FM_answers = read.table(file = 'FM_answers.csv', sep = ',')

ben_answers_s = ben_answers[ben_answers$V1 %in% unused_test_rows,]

full_length = dim(ben_answers_s)[1] + dim(FM_answers)[1]

ben_counter <-  1
FM_counter <-  1
df <- data.frame(matrix(data =0, ncol = 2))
for (i in 1:full_length){
  message('treating row ',i,' over ', full_length)
  if (i %in% unused_test_rows){
    df[i,] <- ben_answers_s[ben_counter,]
    ben_counter<-ben_counter+1
  }
  else{
    df[i,] <- c(i, FM_answers[FM_counter,])
    FM_counter <- FM_counter + 1 
  }
}
