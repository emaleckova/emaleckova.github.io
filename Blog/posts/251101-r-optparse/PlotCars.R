# PlotCars.R

# Deployed version {optparse}

library(optparse)
library(ggplot2)

# Get Data
cars_dat <- mtcars

# Parser
# ------------------------------------------------------------------------------

opt_parser <- OptionParser(
  usage = "Usage: Rscript -e %prog [options]",
  prog = "PlotCars.R",
  description = "Creates a dot plot of `mtcars` dataset based on user-provided arguments",
  epilogue = "Fingers crossed for a nice plot"
)

opt_parser <- add_option(opt_parser, c("-v", "--verbose"), action="store_true",
                     default=TRUE, help="Print extra output [default]")
opt_parser <- add_option(opt_parser, c("-q", "--quietly"), action="store_false",
                     dest="verbose", help="Print little output")
opt_parser <- add_option(opt_parser, c("-x", "--x-variable"), type="character",
                     help="Variable on x-axis, one of 'mpg', 'cyl', 'disp', 'hp',
                     'drat', 'wt', 'qsec', 'vs', 'am', 'gear', 'carb'",
                     dest = "x",
                     metavar="x variable")
opt_parser <- add_option(opt_parser, c("-y", "--y-variable"), type="character",
                         help="Variable on y-axis, one of 'mpg', 'cyl', 'disp', 'hp',
                     'drat', 'wt', 'qsec', 'vs', 'am', 'gear', 'carb'",
                     dest = "y",
                     metavar="y variable")
opt_parser <- add_option(opt_parser, c("--x-title"), type="character",
                         help="Custom title of the x-axis",
                     metavar="axis title")
opt_parser <- add_option(opt_parser, c("--y-title"), type="character",
                         help="Custom title of the y-axis",
                         metavar="axis title")
opt_parser <- add_option(opt_parser, c("-n", "--name"), type="character",
                         help="File basename",
                         dest = "n",
                         metavar="name")
opt_parser <- add_option(opt_parser, c("-f", "--format"), type="character", default = "pdf",
                         help="Export format for the plot: png, jpeg or pdf; defaults to pdf",
                         dest = "f",
                         metavar="file extension")

# Display help during development
# optparse::print_help(opt_parser)

opts = parse_args(opt_parser)

if (is.null(opts$x)) {
  stop("ERROR: -x/--x-variable is required")
}
if (is.null(opts$y)) {
  stop("ERROR: -y/--y-variable is required")
}

# Plot
# ------------------------------------------------------------------------------

xvar <- sym(opts$x)
print(paste("x-axis variable:", xvar))

yvar <- sym(opts$y)
print(paste("y-axis variable:", xvar))

p <- ggplot(cars_dat, aes(x = !!xvar, y = !!yvar)) +
  geom_point(shape = 21, colour = "white", fill = "#26677FFF", size = 3.5, alpha = 0.75, stroke = 1.5) +
  labs(x = opts$`x-title`,
       y = opts$`y-title`) +
  theme_classic() +
  theme(axis.text = element_text(face = "bold"),
        axis.title = element_text(face = "bold"),
        aspect.ratio = 1)

if(!opts$f %in% c("png", "jpeg", "pdf")){
  print("WARNING: Figures can be exported into PNG, JPEG or PDF only!")
}else{
  ggsave(filename = paste0(opts$n, ".", opts$f), device = opts$f)
}

