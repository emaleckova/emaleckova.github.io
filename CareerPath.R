library(tidyverse)

cv_dat <- data.frame(
  "Year" = c(
    2020,
    2021,
    2023,
    2024
  ),
  "Role" = c(
    "Postdoctoral \n researcher",
    "Scientist",
    "Scientific Associate",
    ""
  ),
  "Company" = c(
    "Heinrich Heine University",
    "Singleron Biotechnologies",
    "Resolve BioSciences",
    ""
  )
)

# Calculate mid-points for the labels
plot_cv <- cv_dat |> 
  mutate(Year_next = lead(Year),  # Get the Year of the next point
         Mid = (Year + Year_next) / 2) |>   # Compute midpoint
  drop_na(Mid)

plot_cv <- rbind.data.frame(plot_cv, data.frame(
  "Year" = 2024,
  "Role" = NA,
  "Company" = NA,
  "Year_next" = NA,
  "Mid" = NA
))

# Plot
p_career <- ggplot(plot_cv, aes(x = Year, y = 0)) +
  geom_line() +
  geom_point(data = filter(plot_cv, Year < 2024), pch = 21, fill = "#78C2AD", colour = "white", size = 10, stroke = 3) +
  geom_text(data = filter(plot_cv, Year < 2024), aes(x = Year, y = -0.2, label = Year)) +
  geom_text(aes(x = Mid, y = 0.2, label = Company), fontface = "italic") +
  geom_text(aes(x = Mid, y = -0.2, label = Role)) +
  scale_x_continuous(limits = c(min(cv_dat$Year), 2024)) +
  scale_y_continuous(limits = c(-0.5, 0.5)) +
  theme_void() +
  theme(aspect.ratio = 0.25)
