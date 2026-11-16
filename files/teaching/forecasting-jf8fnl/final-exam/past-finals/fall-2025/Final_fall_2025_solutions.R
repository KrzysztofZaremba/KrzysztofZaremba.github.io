#######################################################################
# FINAL EXAM — R SCRIPT TEMPLATE WITH SOLUTIONS
# Student Name:
#######################################################################

set.seed(123)
load("Delivery.Rda")

#######################################################################
# 1. INTERQUARTILE RANGE OF DELIVERY TIME
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
Q1 <- quantile(Delivery$delivery_time_min, 0.25, na.rm = TRUE)
Q3 <- quantile(Delivery$delivery_time_min, 0.75, na.rm = TRUE)
IQR <- Q3 - Q1
IQR
#######################################################################



#######################################################################
# 2. TEST WHETHER MEAN DELIVERY TIME > 50 MINUTES
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
m <- mean(Delivery$delivery_time_min, na.rm = TRUE)
s <- sd(Delivery$delivery_time_min, na.rm = TRUE)
n <- length(na.omit(Delivery$delivery_time_min))
z <- (m - 50) / (s / sqrt(n))
z   # test statistic
z_critical=qnorm(0.99) #one sided test - if you argue central limit theorem you can use normal, otherwise t with n-1 df.

#Since z<z_critical, we fail to reject H0 at 1% significance level.

#######################################################################



#######################################################################
# 3. REGRESSION: delivery_time_min ~ distance_km
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##

reg1 <- lm(delivery_time_min ~ distance_km, data = Delivery)
summary(reg1)
#######################################################################
# Interpretation:
# The regression output shows how delivery time increases with distance.
# The coefficient for distance_km estimates the average increase in delivery time (5.65 minutes) per additional kilometer.
# A significant positive coefficient suggests longer distances lead to longer delivery times.
# The intercept represents the expected delivery time when distance is zero (29.87 minutes).
# The R-squared value indicates the proportion of variance in delivery time explained by distance.

#######################################################################
# 4. 95% CONFIDENCE INTERVAL FOR DISTANCE COEFFICIENT
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
confint(reg1, "distance_km", 0.95)
#With 95\% confidence, an increase of 1 km in distance is associated with an increase in delivery time between 4.530944 and 6.770943 minutes.
#######################################################################



#######################################################################
# 5. EXTENDED MODEL: distance + traffic + precipitation
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
reg2 <- lm(delivery_time_min ~ distance_km + traffic_level + precip_mm, data = Delivery)
summary(reg2)

# Interpretation of coefficients:
# (Intercept): Expected delivery time (31.98 min) when distance = 0, traffic = High, and precipitation = 0.
# distance_km: Each additional km increases delivery time by 5.36 min, holding other factors constant.
# traffic_levelLow: Deliveries with Low traffic are 15.22 min faster than High traffic (reference), holding other factors constant.
# traffic_levelMedium: Deliveries with Medium traffic are 10.60 min faster than High traffic, holding other factors constant.
# precip_mm: Each additional mm of precipitation increases delivery time by 1.34 min, holding other factors constant.
# All coefficients are statistically significant (p < 0.001).



#######################################################################



#######################################################################
# 6. TEST WHETHER PRECIPITATION MATTERS AT 10%
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
coef_summary <- summary(reg2)$coefficients
beta_precip <- coef_summary["precip_mm", "Estimate"]
se_precip <- coef_summary["precip_mm", "Std. Error"]
t_stat <- beta_precip / se_precip
t_stat

#student t distribution with same number of degrees freedom as the regression (n-5)
#yes it matters, you can also just look up these values in the summary table of the regression
#######################################################################



#######################################################################
# 7. PREDICTION (4 km, High traffic, 10 mm precip)
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
new_order <- data.frame(
  distance_km = 4,
  traffic_level = "High",
  precip_mm = 10
)
pred <- predict(reg2, new_order, interval = "prediction", level = 0.90)
pred
#######################################################################



#######################################################################
# 8. OVERALL SIGNIFICANCE OF THE REGRESSION
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
summary(reg2)   # F-statistic printed here
#null is that all coefficients related to variables are zero (intercept doesn't matter!)
#alternative is that at least one coefficient related to a variable is non-zero
#Since p-value < 0.01, we reject H0 at 1% significance level.
# F is reported in the summary together with its degrees of freedom. 
#######################################################################



#######################################################################
# 9. QQ PLOT OF RESIDUALS
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
#residuals do not follow normal distribution - potential problem with inference, but not with predictions
#######################################################################



#######################################################################
# 10. TEST WHETHER EFFECT(distance) > EFFECT(precip)
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
beta_distance <- coef_summary["distance_km","Estimate"]
var_distance  <- vcov(reg2)["distance_km","distance_km"]
var_precip    <- vcov(reg2)["precip_mm","precip_mm"]
cov_dp        <- vcov(reg2)["distance_km","precip_mm"]

diff     <- beta_distance - beta_precip
se_diff  <- sqrt(var_distance + var_precip - 2*cov_dp)
t_stat_diff <- diff / se_diff
t_stat_diff

#distance (1km) has stronger effect than precipitation (1mm). 
#student t distribution with same number of degrees freedom as the regression (n-5)
#######################################################################



#######################################################################
# 11. INTERACTION REGRESSION
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE (interpret interaction coefficient) ------ ##

## --- SOLUTION ------------------------------------------------------ ##
reg3 <- lm(delivery_time_min ~ distance_km * precip_mm, data = Delivery)
summary(reg3)

# Interpretation:
# (Intercept): Expected delivery time (22.85 min) when distance and precipitation are zero.
# distance_km: Each additional km increases delivery time by 5.54 min when precipitation is zero.
# precip_mm: Each additional mm of precipitation increases delivery time by 1.37 min when distance is zero.
# only this interpretation is required: distance_km:precip_mm (interaction): An effect of additional km increases by almost 0.004 when precipitation increases by 1mm
#######################################################################



#######################################################################
# 12. EFFECT OF PRECIP RISING 0 → 5 mm FOR A 10-km TRIP
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
b0   <- coef(reg3)[1]
bd   <- coef(reg3)[2]
bp   <- coef(reg3)[3]
bint <- coef(reg3)[4]

t0 <- b0 + 10*bd
t5 <- b0 + 10*bd + 5*bp + 5*10*bint
t5 - t0
#######################################################################



#######################################################################
# 13. TIME SERIES COMPONENTS (VACCINATIONS)
#######################################################################

## --- YOUR DISCUSSION ONLY ----------------------------------------- ##
# Describe any trend, seasonality, irregularity, or structural breaks.




## --- SOLUTION ------------------------------------------------------ ##
# Strong yearly seasonality: large peaks every autumn/winter and near-zero values outside flu season (May–August).
# Consistent repeating seasonal pattern: large spike → drop → near-zero.
# No long-run trend (levels similar across years).
# No clear cycles (or you could say some cycles visible and argue why)
#######################################################################



#######################################################################
# 14. SEASONAL NAIVE FORECAST FOR MARCH 2024
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
# Seasonal naive: March 2024 = March 2023
march_2023 <- 14041
march_2023
#######################################################################



#######################################################################
# 15. SEASONAL INDEX FOR NOVEMBER
#######################################################################

## --- YOUR CODE HERE ------------------------------------------------ ##


## --- YOUR DISCUSSION HERE ------------------------------------------ ##


## --- SOLUTION ------------------------------------------------------ ##
#12-all other months' indices
#######################################################################



#######################################################################
# 16. INTERPRETATION OF OCTOBER SEASONAL INDEX
#######################################################################

## --- YOUR DISCUSSION HERE ------------------------------------------ ##




## --- SOLUTION ------------------------------------------------------ ##
# October seasonal index = 2.7
# Interpretation:
# Vaccination counts in October are typically 2.7 times the monthly average,
# meaning October is one of the peak vaccination months.Or 170% above the average
#######################################################################



#######################################################################
# END OF SCRIPT
#######################################################################
