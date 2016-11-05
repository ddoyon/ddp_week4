# data =========================================================================

return_clean_projections <- function(week, pos, num = 30) {
    
    my.file <- paste0("myProjections", week, ".RDS")
    myProjections <- readRDS(my.file)
    
    projections <- myProjections$projections
    clean_proj <<- projections %>%
        filter(position == pos) %>%
        arrange(desc(points)) %>%
        slice(1:num)
    
    return(clean_proj)
}


plot_projections <- function(week = 9, pos, num = 30) {
    
    proj <- return_clean_projections(week, pos, num)
    proj$player <- factor(proj$player, levels = proj[order(proj$points), "player"])
    
    g <- ggplot(proj, aes(points, player)) + geom_point()
    g <- g + geom_errorbarh(aes(xmin = lower, xmax = upper))
    g <- g + ggtitle("Average of projected points from Fantasy Football Analytics")
    g <- g + ylab(NULL) + xlab(NULL)
    
    ggplotly(g)
}
