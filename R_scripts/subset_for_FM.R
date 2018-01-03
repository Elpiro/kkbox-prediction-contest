setwd("~/Documents/wsdm_kkbox/data")


train <- read.csv('train.csv', stringsAsFactors = F,encoding = 'UTF-8')

train_s <- train[,c('msno', 'song_id', 'target')]
rm(train)

train_s <- train_s[order(train_s$msno),]

unique_msno = unique(train_s$msno)
unique_song_id = unique(train_s$song_id)

test <- read.csv('test.csv', stringsAsFactors = F, encoding = 'UTF-8')
test_s <- test[,c('msno', 'song_id')]

test_s <- test_s[test_s$msno %in% unique_msno,]
test_s <- test_s[test_s$song_id %in% unique_song_id,]

#unused test rows
#test_s2 <- test[,c('msno', 'song_id')]
#test_s2 <- test_s2[ ! ( (test_s2$msno %in% unique_msno) & (test_s2$song_id %in% unique_song_id)),]


df = rbind(train_s[,c(1,2)], test_s)

write.table(df, file='df_FM.csv', sep = ',')
write.table(train_s$target, file = 'train_target.csv', sep =',')
