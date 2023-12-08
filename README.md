# Reproducible research: version control and R

\# INSERT ANSWERS HERE #

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points (plus an optional bonus question worth 10 extra points). First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers. All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).

   ANSWER: 1] Results (Experiment 3) 
   
   K = 1x10^9 (carrying capacity)
   N0 = 1x10^4.5 (initial population size)
   r <- 0.005007086 (rate of per capita increase)
   
   Overview:
   The repository contains the analysis of E.Coli growth in a controlled environment.
   Our analysis uses logistic growth modeling to estimate the initial population size (N0),
   rate of per capita increase (r), and the carrying capacity (K) of the bacteria.
   
   The growth data of E.Coli was collected under experimental conditions and is available
   in 'experiment3.csv'. This file included time(t) and population size (N) at various time
   points.
   
   Methodology
   We applied the logistic growth mode, described by the differential equation  
   dN/dt = Nr(1−N/K) tp estomate the key parameters of the bacterial growth. Two
   distinct phases of growth were analysed: the exponential growth phase when resources
   were abundance (N<<K) and the stationary phase when the population stabilised near 
   the carrying capacity (N=K).
   
   Case 1: Exponential Growth Phase
   For the early phase (t<1000 minutes), where the population grows exponentially, we 
   used a linear approximation on the logarithm of population size. The linear model is 
   given by ln(N) = ln(N0) + rt
   
   Case 2: The Stationary Phase
   For the later phase (t>3000 minutes), where the population size approaches carrying 
   capacity, we assumed that the population size remained constant, i.e. N(t) = 
   approximately K.
   
   Results
   - Initial population size (N0): Estimated from the exponential growth phase. Our analysis
   suggests an initial population size of 1x10^4.5
   - Rate of per Capita Increase (r): Estimated from the slope of the linear model in
   the exponential phase. The estimated growth rate is 0.0050070086 per minute
   - Carrying Capacity (K): Estimated from the stationary phases of growth. The
   carrying capacity is around 1X10^9 bacteria.
      
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth?

   ANSWER: 2] If t = 4980 minutes, and N0 = 1x10^4.5 (initial population size) and
   r = 0.005007086 (rate of per capita increase), and K = 1x10^9 (carrying capacity),
   then the population size is 47,916 - using the formula. Under the logistic graph, it suggests that at
   4980 minutes, the population is 5x10^9


3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.

   ANSWER:
- Load necessary libraries
library(ggplot2)
library(dplyr)

- Read the data
growth_data <- read.csv("/cloud/project/experiment3.csv")

- Define the logistic growth function
logistic_growth <- function(t, K, N0, r) {
  N0 * K / (N0 + (K - N0) * exp(-r * t))
}

- Define the exponential growth function
exponential_growth <- function(t, N0, r) {
  N0 * exp(r * t)
}

- Parameters (example values, replace with your estimates)
K <- (1*10)^9  # Carrying capacity
N0 <- (1*10)^4.5  # Initial population size
r <- 0.005  # Rate of per capita increase

- Adding the growth models to the data
growth_data$logistic <- logistic_growth(growth_data$t, K, N0, r)
growth_data$exponential <- exponential_growth(growth_data$t, N0, r)

- Plotting the data and the models with log-transformed y-axis
ggplot(growth_data, aes(x = t)) +
  geom_line(aes(y = logistic), colour = "red") +
  geom_line(aes(y = exponential), colour = "blue") +
  xlab("Time (t)") +
  ylab("Population Size (N)") +
  ggtitle("Comparison of Logistic and Exponential Growth") +
  theme_bw() +
  scale_y_log10()  # Log-transform the y-axis

![0e9096bf-60f1-4f55-9985-33d0426c9365](https://github.com/anonymous-user31/reproducible-research_homework/assets/150164357/6c9368e8-5ef4-4630-86c5-4c6923ee6b89)

   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   - A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points)
   - Investigate the term **random seeds**. What is a random seed and how does it work? (5 points)
   - Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points)
   - Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points)
  
<img width="1374" alt="Screenshot 2023-12-08 at 05 57 56" src="https://github.com/anonymous-user31/reproducible-research_homework/assets/150164357/38dc8799-8a0b-4f16-a0a7-568addd056bf">

<img width="1377" alt="Screenshot 2023-12-08 at 05 58 06" src="https://github.com/anonymous-user31/reproducible-research_homework/assets/150164357/39fe4128-c02f-48b6-bec8-0d52a90cf092">


5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \beta L^{\alpha}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   - Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)
   - What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points)
   - Find the exponent ($\alpha$) and scaling factor ($\beta$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points)
   - Write the code to reproduce the figure shown below. (10 points)

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  - What is the estimated volume of a 300 kb dsDNA virus? (4 points)

**Bonus** (**10 points**) Explain the difference between reproducibility and replicability in scientific research. How can git and GitHub be used to enhance the reproducibility and replicability of your work? what limitations do they have? (e.g. check the platform [protocols.io](https://www.protocols.io/)).
