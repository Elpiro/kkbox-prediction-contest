setwd("../data/")

library(dplyr)

members <- read.csv("members.csv", stringsAsFactors = F,encoding = "UTF-8")
songs <- read.csv("songs.csv", stringsAsFactors = F,encoding = "UTF-8")
song_extra_info <- read.csv("song_extra_info.csv", stringsAsFactors = F,encoding = "UTF-8")
train <- read.csv("train.csv", stringsAsFactors = F,encoding = "UTF-8")


#merge members & train
MT <- left_join(members, train, by = c("msno" = "msno"))


#merge members_train & songs
MTS <- left_join(MT, songs, by = c("song_id" = "song_id"))


#merge MTS & song_extra_info
final_df <- left_join(MTS, song_extra_info, by = c("song_id" = "song_id"))


#delete excedent
rm(members)
rm(songs)
rm(song_extra_info)
rm(train)
rm(MT)
rm(MTS)

#save .csv to working dir
write.csv('kkbox.csv')
