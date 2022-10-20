## Berlin Marathon 2022

### Usage

Simply run `makefile` to make both the `pdf` and `jpg` file.

Alternatively, run `Rscript BerlinMarathon2022.r <data> <pdf> <width> <height>`, for example:
```r
Rscript BerlinMarathon2022.r BerlinMarathon2022.tsv BerlinMarathon2022.pdf 10 7
```

or interactively from R console (won't create `pdf`):
```r
source("BerlinMarathon2022.r")
BerlinMarathon2022()
```

### Dependencies

* R `baffle` package (available from CRAN)
* **optional** `GNUmake` or other compatible make
* **optional** `imagemagick` for the conversion to `jpg`
