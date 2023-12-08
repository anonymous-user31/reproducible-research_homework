# Install necessary packages
# install.packages("ggplot2")
# install.packages("gridExtra")

library(ggplot2)
library(gridExtra)

# Set a random seed for reproducibility
set.seed(123)

random_walk <- function(n_steps) {
  df <- data.frame(x = rep(NA, n_steps), y = rep(NA, n_steps), time = 1:n_steps)
  df[1,] <- c(0,0,1)
  
  for (i in 2:n_steps) {
    h <- 0.25
    angle <- runif(1, min = 0, max = 2*pi)
    df[i,1] <- df[i-1,1] + cos(angle)*h
    df[i,2] <- df[i-1,2] + sin(angle)*h
    df[i,3] <- i
  }
  return(df)
}

data1 <- random_walk(500)

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  geom_path(aes(colour = time)) +
  theme_bw() +
  xlab("x-coordinate") +
  ylab("y-coordinate")

data2 <- random_walk(500)

plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  geom_path(aes(colour = time)) +
  theme_bw() +
  xlab("x-coordinate") +
  ylab("y-coordinate")

grid.arrange(plot1, plot2, ncol=2)

## Answers: 

## Observations:
I see that the provided code simulates two random walks, each with 500 steps. The random walks start at the origin (0, 0) and move in random directions with step sizes determined by a random angle.

The two random walks appear as paths with different trajectories.
Each step is represented by a point on the plot, and the color of the points indicates the time step.

Random seeds: 
A random seed is a starting point for generating random numbers using a pseudorandom number generator (PRNG). PRNGs are deterministic algorithms that produce sequences of numbers that appear random but are reproducible if you start with the same seed. In R, you can set a random seed using the set.seed() function. Setting a random seed ensures that you get the same sequence of random numbers every time you run your code, making your simulations or analyses reproducible.

To make the simulation of Brownian motion reproducible, you can set a random seed before generating random numbers using functions like runif() or rnorm(). This ensures that if you use the same seed in the future, you'll get the same sequence of random values, making your simulations consistent.



