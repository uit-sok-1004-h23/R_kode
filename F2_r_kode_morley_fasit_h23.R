# alle linjer som begynner med "#" er kommentarer. de blir ikke kjørt.

# TEMA: en forsmak på tibble, piping, og ggplot2

# slett minne, last inn tidyverse
rm(list=ls())
library(tidyverse)

# henter ferdiglagret data
data(morley)

# forklaring: https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/morley
# NB! Les denne.

# se på data i konsollen...
morley

# ... det var uoversiktlig!

# vi lagrer dataene som en tibble, se kapittel 10 i pensum
morley <- as_tibble(morley)

# se på data i konsollen igjen...
morley

# ... det var oversiktlig!


# se på type objekt i hver kolonne (str for structure/struktur)

str(morley)

# se på type objekt brukt i benevning av radene

class(rownames(morley))

# da forstår vi at radnavn ser ut som tall, men er "character", dvs en streng



# la oss prøve å lage en graf
# prøv å fjerne as.numeric of se hva som skjer!

ggplot(data = morley, mapping = aes(x=as.numeric(rownames(morley)), y=Speed))+geom_point()

# den kommandoen var ikke lett å lese.
# vi bruker piping for å gjøre koden lettere å arbeide med

# først et enkelt eksempel:
select(morley,Speed)

# forklar kommandoen. hva skjedde?
# prøv denne:
morley %>%
  select(Speed)

# hva skjedde?

# piping lar oss dele opp koden, og utføre én kommando av gangen.
# symbolet %>% betyr: bruk dette som første argument i neste kommando.
# x %>% f(y) er det samme som f(x,y)!

# Hvorfor bruke piping?
# Jo, det er lettere å lese vertikalt enn horisontalt!

# la oss rydde litt i datasettet, med piping

# først legger jeg til en variabel med rekkenavn
morley <- add_column(morley,indeks = as.numeric(rownames(morley)))

class(morley$indeks)

# indeks er nå en kolonne som er tall (som vi kan bruke på x-aksen)

#############################################################
### SPØRSMÅL 1: Kan du lage denne kommandoen med en pipe? ###
#############################################################

# vi kan lage en hjelpevariabel x

x = as.numeric(rownames(morley))

morley <- morley %>%
  
  add_column(indeks = x)

# ta bort x

rm(x)

# så gir vi nye variabelnavn
rename(morley, eksperiment = Expt)
rename(morley, forsøk = Run)
rename(morley, hastighet = Speed)

#############################################################
### SPØRSMÅL 2: Kan du lage denne kommandoen med en pipe? ###
#############################################################

morley %>% 
  rename(eksperiment = Expt)
morley %>%
  rename(forsøk = Run)
morley %>% 
  rename(hastighet = Speed)

#####################################################################
### SPØRSMÅL 3: Kan du skrive om kommandoen så endringene lagres? ###
#####################################################################

morley <- morley %>% 
  rename(eksperiment = Expt)
morley <-morley %>%
  rename(forsøk = Run)
morley <-morley %>% 
  rename(hastighet = Speed)

# la oss prøve å lage en graf, med piping
morley %>%
  
  ggplot(aes(x=indeks,y=hastighet)) %>%
  
  + geom_point() %>%
  
  + theme_minimal()

#######################################################################
### SPØRSMÅL 4: Hva er det vi ser på? Forklar så konkret som mulig. ###
#######################################################################

# se på denne grafen
morley %>%
  
  ggplot(aes(x=indeks,y=hastighet), color = forsøk)) %>%
  
  + geom_point() %>%
  
  + theme_bw() 

# det fungerte ikke.

#####################################################
### SPØRSMÅL 5: Kan du fikse koden så den kjører? ###
#####################################################

# se på denne grafen
morley %>%
  
  ggplot(aes(x=indeks,y=hastighet), color = forsøk) %>%
  
  + geom_point() %>%
  
  + theme_minimal() 

# koden kjører, men hva skjer med fargen?
# vi har jo color=forsøk, men alle prikker er sort

# se på denne grafen
# se du hva som er annerledes?
morley %>%
  
  ggplot(aes(x=indeks,y=hastighet, color = forsøk)) %>%
  
  + geom_point() %>%
  
  + theme_minimal() 


# hvor gode var målingene?
# hastighet viser kilometer i sekundet fratrukket 299000

morley <- morley %>%
  mutate(hastighet = hastighet + 299000)

################################################
### SPØRSMÅL 6: Hva gjorde denne kommandoen? ###
################################################

morley <- morley %>%
  mutate(avvik = 100(hastghet - 299792.458)/299792.458)

#####################################################
### SPØRSMÅL 7: Kan du fikse koden så den kjører? ###
#####################################################

morley <- morley %>%
  mutate(avvik = 100*(hastighet - 299792.458)/299792.458)

# matematiske operatørene "+", "-", "/" og "*" brukes.
# legg spesielt merke til at multiplikasjon utføres med "*"

# se til slutt på denne grafen
morley %>%
  
  ggplot(aes(x=indeks,y=avvik, color = forsøk)) %>%
  
  + geom_point() %>%
  
  + theme_minimal() 

###########################################################################
### SPØRSMÅL 6: Hva er det vi ser på? Drøft hvorvidt målingene er gode. ###
###########################################################################

