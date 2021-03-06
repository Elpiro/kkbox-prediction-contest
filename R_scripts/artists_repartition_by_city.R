final_df = read.csv("../data/kkbox.csv")
#most listened artists
head(sort(table(df$artist_name), decreasing = TRUE))

#cities ordered by number of users (descending order)
sorted_cities <- as.data.frame(sort(table(df$city), decreasing = T), stringsAsFactors = F)
sorted_cities["Freq"] <- sorted_cities["Freq"]/sum(sorted_cities["Freq"])
names(sorted_cities) <- c("city", "density")

#city 1 = Taipei represents 35% of all observations
#if the repartition of listened artists in Taipei is a lot différent than in other cities
  #city 1 users taste should be predicted with a different machine learning algorithm
#note that sorted cities follows an exponential distribution
barplot(sorted_cities$density)

#analysis of density repartition of all artists names
artists_all <- table(df$artist_name)
artists_all <- sort(artists_all, decreasing = T)
artists_all <- as.data.frame(artists_all, stringsAsFactors = F)
artists_all["Freq"] <- artists_all["Freq"]/sum(artists_all["Freq"])
names(artists_all) <- c("artist", "density")
artists_order <- as.data.frame(artists_all$artist, stringsAsFactors = F)
names(artists_order) <- c("artist")


#analysis of density of artists names in Taipei
artists_taipei <- df[,c(7,15)]
artists_taipei <- (artists_taipei[(artists_taipei["city"] == 1),])[,2]
artists_taipei <- table(artists_taipei)
artists_taipei <- as.data.frame(artists_taipei,  stringsAsFactors = F)
artists_taipei["Freq"] <- artists_taipei["Freq"]/sum(artists_taipei["Freq"])
names(artists_taipei) <- c("artist", "density")

#merge density of all artists & artists_taipei in one for later plotting
library(dplyr) 
artists_densities <- left_join(artists_order,artists_all,  by = c('artist', 'artist'), stringsAsFactors = F)
artists_densities <- left_join(artists_densities,artists_taipei,  by = c('artist', 'artist'), stringsAsFactors = F)
names(artists_densities) <- c("artist", "all", "taipei")
artists_densities[sapply(X = artists_densities$taipei, FUN = is.na), 3] <- 0

#same procedure for the others cities
artists_othercities <- df[,c(7,15)]
artists_othercities <- (artists_othercities[(artists_othercities["city"] != 1),])[,2]
artists_othercities <- as.data.frame(table(artists_othercities), stringsAsFactors = F)
artists_othercities["Freq"] <- artists_othercities["Freq"]/sum(artists_othercities["Freq"])
names(artists_othercities) <- c("artist", "density")

#merge density of artists_densities & artists_othercities in one for later plotting
artists_densities <- left_join(artists_densities, artists_othercities, all = TRUE, by = c('artist', 'artist'), stringsAsFactors = F)
names(artists_densities) <- c("artist", "all", "taipei", "other cities")
artists_densities[sapply(X = artists_densities$`other cities`, FUN = is.na), 4] <- 0

#generate density plots
par(col = "red")
plot(artists_densities[c(1:1000), c(1,2)], type = "l")
par(new = TRUE, col = "blue")
plot(artists_densities[c(1:1000), c(1,3)], type = "l")
par(new = TRUE, col = "green")
plot(artists_densities[c(1:1000), c(1,4)], type = "l")
