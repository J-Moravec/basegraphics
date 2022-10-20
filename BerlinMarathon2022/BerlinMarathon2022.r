# Originally from
# https://github.com/PoisonAlien/basegraphics
# with some modifications

# Draw a popsicle-style box with label
draw_label = function(position, height, label, col="#fd5200", cex=0.9){
    baffle::rounded_rectangle(
        position, height, rx = 0.05, ry = 0.1,
        dx = strwidth(label, cex=cex+0.3), dy=strheight(label, cex=cex+0.3),
        col = col, border = "white"
        )
    segments(position, 0, position, height, col=col, lwd=2)
    points(position, 0, pch=19, col=col)
    text(position, height, labels = label, cex=cex, font=2, col = "white")
    }


polystep = function(y, width=1, ...){
    x = seq_along(y)
    xx = c(rbind(x - width/2, x + width/2))
    yy = c(rbind(y, y))
    
    xx = c(1, xx, length(x))
    yy = c(0, yy, 0)
    
    polygon(x = xx, y = yy, ...)
    }


# Read and preprocess the barathon data
get_data = function(file="BerlinMarathon2022.tsv"){
    data = read.delim(file = file, header = FALSE)

    data$secs = apply(X = data, MARGIN = 1, FUN = function(x){
      sapply(strsplit(x = x, split = ":"), function(x) {
        as.numeric(x[1]) * 3600 + as.numeric(x[2]) * 60 + as.numeric(x[3])
      })
    })
    data$mins = data$secs / 60
    data$cut = cut(x = data$mins, breaks = seq(90, 480, 1))
    data
    }


BerlinMarathon2022 = function(file="BerlinMarathon2022.tsv"){
    # Read data
    data = get_data(file)

    # Plotting
    par(mar = c(3, 2, 3, 1))
    plot.new()
    plot.window(xlim = c(0, 390), ylim = range(table(data$cut)))
    

    # Plot the data
    # This doesn't work well with jpeg conversion
    # points(table(data$cut), type = "h", col = "#f4b298", lend=2)
    polystep(table(data$cut), col="#f4b298", lend=2, border=NA)
    # grid
    abline(v = seq(0, 390, 30), col = "#ecf0f1", lty="22", lwd=2)

    
    # X axis labels
    text(
        x = seq(0, 390, 30),
        y = -20,
        labels = paste0(rep(1:8, each=2)[2:15], ":", c("30", "00")),
        srt = -45,
        xpd = TRUE,
        cex = 0.8, col = "#2c3e50",
        pos=4
        )

    # Some interesting data points
    kipchoge_slot_idx = which(names(table(data$cut)) == "(121,122]")
    assefa_slot_idx = which(names(table(data$cut)) == "(135,136]")
    median_time = median(data$secs) #245.7 i.e: 04:05:42
    median_time_idx = which(names(table(data$cut)) == "(245,246]")

    draw_label(assefa_slot_idx, 190, "ASSEFA\n2:15:37")
    draw_label(kipchoge_slot_idx, 90, "KIPCHOGE\n2:01:09")
    draw_label(median_time_idx, 90, "MEDIAN\n04:05:42")

    # describe axes
    textcol = adjustcolor("white", 1, 0.3, 0.3, 0.3) # greyish
    mtext(text = "TIME [H:MM]", side = 1, line = 2, col=textcol)
    mtext(text = "NUMBER OF ATHLETES", side = 2, line = 0.5, col=textcol)

    title(main = "BMW BERLIN-MARATHON 2022: FINISH TIMES", col.main = "#2c3e50")
    }


if(!interactive()){
    args =commandArgs(TRUE)
    pdf(args[2], width=args[3] |> as.numeric(), height=args[4] |> as.numeric())
    BerlinMarathon2022(args[1])
    invisible(dev.off())
    }
