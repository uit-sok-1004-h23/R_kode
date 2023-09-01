# hvor mange ord i en tekst?



tekst <- "Vindkraft er bra og bruker ikke fosiler. Dannmark bruker 40 vindkraft og bruker mest i Skandinaiva, se
figur 1 de brukte mer enn alle de andre. Iceland er dårligst de bruker 0, de er ikke miljøvennelig. Danmark 
har begynt a bruker mindre kraft grafen er dårligere enn for noen år siden. De andre landene er bedre med og 
bruker mer men ikke island de bruker fortsatt 0 hele tiden. Denne rapport skal se mer pa hvorfor Danmask er 
best i utviklingen av andelen vindkraft benyttet i skandinavia fra åttitallet og frem til idag utvinklingen har 
vært enorm i noen av landene men ikke alle og vi skal se pa hvorfor det kan ha utviklet seg slik. Danmark 
skiller seg positivt ut mhp bruk av vindkraft isforhold til de andre nordiske landene de startet først og
benytter mest de har vært et foregangsland og en inspirasjon for de andre. Norge f.eks produserer svært lite
vindkraft noe som er synd da vi pa en måte er en klimavennlig nasjon vi burde bidra mer til utviklingen av 
grønne teknologer siden vi har ressurser a bruke på det pga. for eksempel olje, fisk og oljefondet som vi har 
høy inntekt på. Hvis vi produserer mer vindkraft kan vi bidra til å redusere karbonutslipp ytterligere vi har 
mye plass og gode vindforhold."

# bruk strsplit for å dele teksten inn i ulike ord

# "\\W+" forteller at deling skjer på karakterer som ikke er ord (tomrom, komma, punktum osv)

# unlist tar alle disse strengene og kombinerer til én liste med alle ord


ord_liste <- unlist(strsplit(tekst, "\\W+"))

# length brukes for å telle antall elementer

antall_ord <- length(ord_liste)

antall_ord
