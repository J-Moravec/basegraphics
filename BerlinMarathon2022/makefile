# set RECIPEPREFIX to plus sign instead of tabs
.RECIPEPREFIX = +


target := BerlinMarathon2022.pdf BerlinMarathon2022.jpg

all: $(target)

BerlinMarathon2022.tsv:
+ bash get_data.sh $@

%.pdf: %.tsv
+ Rscript BerlinMarathon2022.r $< $@ 10 7

%.jpg: %.pdf
+ convert -density 600 -flatten -quality 90 $< $@

clean:
+ rm  $(target)

clean_data:
+ rm data/*
+ rm -r data
