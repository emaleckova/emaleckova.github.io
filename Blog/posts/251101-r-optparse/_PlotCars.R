# _PlotCars.R

# Developmental, step-by-step version towards code with optparse

library(ggplot2)

# Get Data
cars_dat <- mtcars

# All hardcoded
# ------------------------------------------------------------------------------
ggplot(cars_dat, aes(x = mpg, y = hp)) +
  geom_point(shape = 21, colour = "white", fill = "#26677FFF", size = 3.5, alpha = 0.75, stroke = 1.5) +
  theme_classic() +
  theme(axis.text = element_text(face = "bold"),
        axis.title = element_text(face = "bold"),
        aspect.ratio = 1)

# With variables
# ------------------------------------------------------------------------------

x_var <- "mpg"
y_var <- "hp"

ggplot(cars_dat, aes(x = !!ensym(x_var), y = !!ensym(y_var))) +
  geom_point(shape = 21, colour = "white", fill = "#26677FFF", size = 3.5, alpha = 0.75, stroke = 1.5) +
  theme_classic() +
  theme(axis.text = element_text(face = "bold"),
        axis.title = element_text(face = "bold"),
        aspect.ratio = 1)
