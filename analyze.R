library(dplyr)
library(ggplot2)
library(readxl)

col_types <- rep("text", 166)
col_types[c(26, 27, 28, 165, 166)] <- "date"

voters_part1 <- read_excel("data/Reg Smith County_Part 1 of 2.xlsx", col_types = col_types)
voters_part2 <- read_excel("data/Reg Smith County_Part 2 of 2.xlsx", col_types = col_types)

voters <- rbind(voters_part1, voters_part2)

# District 5 City Council election
election_day <- as.POSIXct("2017-05-06")

eligible <- voters %>%
  filter(
    `CITY SINGLE MEMBER` == "CT5",
    eligible_date <= election_day,
    voter_status == "A"
  )

eligible$age <- as.numeric(election_day - eligible$birthdate) / 365

eligible$age_groups <- cut(
  eligible$age,
  include.lowest=TRUE,
  right=FALSE,
  breaks=c(15, 25, 35, 45, 55, 65, 75, 85, 120)
)

eligible$years_registered <- as.numeric(election_day - eligible$registration_date) / 365

eligible$voted_in_2016_general <- (!is.na(eligible$election_code1))
eligible$voted_in_2016_mayor <- (!is.na(eligible$election_code3))
eligible$voted_in_2015_city <- (!is.na(eligible$election_code8))
eligible$voted_in_2014_general <- (!is.na(eligible$election_code10)) 
eligible$voted_in_2012_general <- (!is.na(eligible$election_code22)) 
eligible$party <- as.factor(eligible$party_code4)

ggplot(data = eligible, aes(x = age)) +
  geom_histogram(binwidth = 1)

ggplot(data = eligible, aes(x = years_registered)) +
  geom_histogram(binwidth = 1)

ggplot(data = eligible, aes(x = age, y = years_registered)) +
  geom_point(size=0.2)
  
registered_since_election <- filter(eligible, registration_date > as.POSIXct("2016-11-06"))

ggplot(data = registered_since_election, aes(x = age)) +
  geom_histogram(binwidth = 1)

apartment_dwellers <- filter(eligible, unit_type == "APT")

ggplot(data = apartment_dwellers, aes(x = years_registered)) + 
  geom_histogram(binwidth = 1)

election_day16 <- as.POSIXct("2016-11-06")
election_day12 <- as.POSIXct("2012-11-06")
election_day08 <- as.POSIXct("2008-11-04")
election_day04 <- as.POSIXct("2004-11-02")
election_day00 <- as.POSIXct("2000-11-07")

after_16ge <- voters %>%
  filter(
    registration_date > election_day16,
    registration_date < election_day16 + as.difftime(24, units = "weeks")
  )

after_12ge <- voters %>%
  filter(
    registration_date > election_day12,
    registration_date < election_day12 + as.difftime(24, units = "weeks")
  )

after_08ge <- voters %>%
  filter(
    registration_date > election_day08,
    registration_date < election_day08 + as.difftime(24, units = "weeks")
  )

after_04ge <- voters %>%
  filter(
    registration_date > election_day04,
    registration_date < election_day04 + as.difftime(24, units = "weeks")
  )

after_00ge <- voters %>%
  filter(
    registration_date > election_day00,
    registration_date < election_day00 + as.difftime(24, units = "weeks")
  )

ages <- eligible %>%
  group_by(age_groups) %>%
  summarise(count = n())

