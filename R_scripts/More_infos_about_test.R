library(dplyr)

#7.19% (184,018 lines) msno of test are not in train. 
# ==> That quantity of prediction must be made without knowing a particular user's taste
sum( ! (test$msno) %in% train$msno)) / length(test$msno)

# in terms of unique users, 14.5% of unique msno in test are not in train
sum( ! (unique(test$msno) %in% unique(train$msno))) / length(unique(test$msno))

#Yet, all test data subjects are referenced in members
#of course, each msno in members is unique
sum(unique(test$msno) %in% members$msno) / length(unique(test$msno))


#What infos do we know about these users just from members dataset ?
users_unknown_tastes <- train[which(! (unique(test$msno) %in% unique(train$msno))) , ]$msno
users_unknown_tastes <- members[(members$msno %in% users_unknown_tastes), ]

#checks quality of attributes globally. If equals 0, then all infos are
#for city
sum(sapply(X = users_unknown_tastes$city, FUN = is.na)) / length(users_unknown_tastes$city)
sum(sapply(X = users_unknown_tastes$city, FUN = is.null)) / length(users_unknown_tastes$city)

#for bd
sum(sapply(X = users_unknown_tastes$bd, FUN = is.na)) / length(users_unknown_tastes$bd)
sum(sapply(X = users_unknown_tastes$bd, FUN = is.null)) / length(users_unknown_tastes$bd)

#for gender
#39% of genders are incomplete :(
sum(users_unknown_tastes$gender == "") / length(users_unknown_tastes$gender)

#for registered_via
sum(sapply(X = users_unknown_tastes$registered_via, FUN = is.na)) / length(users_unknown_tastes$registered_via)
sum(sapply(X = users_unknown_tastes$registered_via, FUN = is.null)) / length(users_unknown_tastes$registered_via)

#for registration_init_time
sum(sapply(X = users_unknown_tastes$registration_init_time, FUN = is.na)) / length(users_unknown_tastes$registration_init_time)
sum(sapply(X = users_unknown_tastes$registration_init_time, FUN = is.null)) / length(users_unknown_tastes$registration_init_time)

#for expiration_date
sum(sapply(X = users_unknown_tastes$expiration_date, FUN = is.na)) / length(users_unknown_tastes$expiration_date)
sum(sapply(X = users_unknown_tastes$expiration_date, FUN = is.null)) / length(users_unknown_tastes$expiration_date)


#gender is the only one incomplete, so depending of its correlation with the prediction, we give it a smaller weight ?
