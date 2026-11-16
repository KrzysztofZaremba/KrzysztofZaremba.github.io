# ==============================================================================
# Final Exam — Spring 2026 — SOLUTIONS 
# ==============================================================================

# ==============================================================================

#to read exact solutions, load the exports data and run the solutions line by line. 

load("exports.Rda")

Cars  <- exports[exports$car == 1, ]
Boats <- exports[exports$car == 0, ]
cat("\nDataset:", nrow(exports), "obs; Cars n =", nrow(Cars),
    "; Boats n =", nrow(Boats), "\n\n")


# ===============================================================
# PART 1 — Inferential Statistics
# ===============================================================

# ----- Q01  Two-sample t-test, mean Sales: cars vs. boats ------
# H0: mu_cars  = mu_boats
# H1: mu_cars != mu_boats           (two-sided, alpha = 0.05)
# Assumptions: main one if not using a paired test: independent random samples; 

xbar_c <- mean(Cars$Sales);  s_c <- sd(Cars$Sales);  n_c <- nrow(Cars)
xbar_b <- mean(Boats$Sales); s_b <- sd(Boats$Sales); n_b <- nrow(Boats)

SE_diff <- sqrt(s_c^2 / n_c + s_b^2 / n_b)
t_stat  <- (xbar_c - xbar_b) / SE_diff
df_use  <- min(n_c, n_b) - 1
t_crit  <- qt(1 - 0.05/2, df = df_use)
p_value <- 2 * (1 - pt(abs(t_stat), df = df_use))

cat("===== Q01 =====\n")
cat(sprintf("  xbar_cars=%.0f, xbar_boats=%.0f\n", xbar_c, xbar_b))
cat(sprintf("  s_cars=%.0f, s_boats=%.0f, n=%d each\n", s_c, s_b, n_c))
cat(sprintf("  SE(diff) = sqrt(s_c^2/n_c + s_b^2/n_b) = %.2f\n", SE_diff))
cat(sprintf("  t = (xbar_c - xbar_b) / SE = (%.0f - %.0f) / %.2f = %.3f\n",
            xbar_c, xbar_b, SE_diff, t_stat))
cat(sprintf("  df = min(n)-1 = %d, t_crit = %.3f, p = %.2e\n",
            df_use, t_crit, p_value))
cat(sprintf("  |t| = %.2f  >>  t_crit = %.2f  =>  REJECT H0\n",
            abs(t_stat), t_crit))
cat("  Cars sell about $", round(xbar_c - xbar_b, 0),
    " more per quarter than boats on average.\n\n", sep="")

#You could have also solved it with a regression (regressing Sales on car, or with paired difference test)



# ----- Q02  CLT explanation (essay) -----
# Model answer:
# "The t-test assumes the SAMPLING DISTRIBUTION OF THE SAMPLE MEAN is
#  approximately normal, NOT the raw data. By the Central Limit Theorem,
#  with n = 100 per group the sample mean is approximately normal
#  regardless of the underlying shape of the data. So right-skew in the
#  raw boat-sales values does not invalidate the t-test in Q01."

#for full points you need to mention CLT and cannot say that data would be normally distributed. 


# ----- Q03  95% CI interpretation (MC) — CORRECT: (c) -----
#
# (a) "95% probability that the true mean mu lies in (X, Y)."
#     WRONG. After we compute the interval the parameter mu is a fixed
#     unknown number; either it IS in (X,Y) or it ISN'T. You cannot
#     assign a probability to a fixed quantity. The 95% refers to the
#     long-run behavior of the PROCEDURE, not to the specific interval.
#
# (b) "95% of car-sales observations fall within (X, Y)."
#     WRONG. The interval is for the MEAN, not the spread of the raw
#     data. CI width shrinks as n grows (because SE = s/sqrt(n));
#     "95% of obs" would be roughly xbar +- 2*s, not xbar +- 2*s/sqrt(n).
#
# (c) "If we repeated the sampling many times and built a 95% CI each
#     time, 95% of those intervals would contain the true mean mu."
#     CORRECT 
#
# (d) "We are 95% sure the next car-sales observation will lie in (X, Y)."
#     WRONG. That describes a PREDICTION interval for one new
#     observation, not a CI for the mean.


# ----- Q04  p-value interpretation (MC) — CORRECT: (c) -----
#
# (a) "There is a 3% probability that the null hypothesis is true."
#     WRONG. We don't compute P(H0 true). The p-value is conditional
#     on H0 being true.
#
# (b) "There is a 97% probability that the alternative hypothesis is
#     true."
#     WRONG. Same mistake as (a) from the other side. We never compute
#     P(H1 true) either.
#
# (c) "If the null hypothesis were true, there would be a 3% probability
#     of obtaining a test statistic at least as extreme as the one
#     observed."
#     CORRECT 
#
# (d) "The test gives the wrong conclusion 3% of the time."
#     WRONG. That confuses the p-value with the long-run Type I error
#     rate (alpha). alpha is chosen in advance; the p-value is computed
#     from this particular sample.


# ----- Q05  MSE of estimator A -----
MSE_A <- 100 + 0^2                      # MSE = Var + Bias^2
cat("===== Q05 =====\n")
cat("  MSE_A = Var(A) + Bias(A)^2 = 100 + 0^2 =", MSE_A, "\n\n")


# ----- Q06  MSE of estimator B -----
MSE_B <- 4 + 1^2
cat("===== Q06 =====\n")
cat("  MSE_B = Var(B) + Bias(B)^2 = 4 + 1^2 =", MSE_B, "\n")


# ===============================================================
# PART 2 — Tariff impact 
# ===============================================================
#
# Sales = b0 + b1*car + b2*after_q2_2025 + b3*(car * after_q2_2025) + e

m_did <- lm(Sales ~ car + after_q2_2025 + car * after_q2_2025, data = exports)
b <- coef(m_did)
cat("===== DiD regression coefficients =====\n")
cat(sprintf("  b0 (intercept)         = %.0f\n", b[1]))
cat(sprintf("  b1 (car)               = %.0f\n", b[2]))
cat(sprintf("  b2 (after_q2_2025)     = %.0f\n", b[3]))
cat(sprintf("  b3 (car:after_q2_2025) = %.0f\n\n", b[4]))


# ----- Q07  Matching (car, after_q2_2025) -> situation -----
#   (0, 0)  ->  boats BEFORE the tariff
#   (1, 0)  ->  cars  BEFORE the tariff
#   (0, 1)  ->  boats AFTER  the tariff
#   (1, 1)  ->  cars  AFTER  the tariff
# Reasoning: car = 1 means cars (else boats); after_q2_2025 = 1 means
# the observation is from Q2 2025 onward (else before).


# ----- Q08  Fill-in-the-blank DiD predictions (5 blanks) -----
# Predicted Sales = b0 + b1*car + b2*after + b3*(car*after)

boats_before <- b[1] + 0 * b[2] + 0 * b[3] + 0 * b[4]
boats_after  <- b[1] + 0 * b[2] + 1 * b[3] + 0 * b[4]
cars_before  <- b[1] + 1 * b[2] + 0 * b[3] + 0 * b[4]
cars_after   <- b[1] + 1 * b[2] + 1 * b[3] + 1 * b[4]
diff_cars    <- cars_after - cars_before        # = b2 + b3

cat("===== Q08 =====\n")
cat(sprintf("  (a) Boats BEFORE: b0             = %.0f\n", boats_before))
cat(sprintf("  (b) Boats AFTER : b0 + b2        = %.0f\n", boats_after))
cat(sprintf("  (c) Cars  BEFORE: b0 + b1        = %.0f\n", cars_before))
cat(sprintf("  (d) Cars  AFTER : b0+b1+b2+b3    = %.0f\n", cars_after))
cat(sprintf("  (e) Δ cars (after - before)=b2+b3=%.0f\n\n", diff_cars))


# ----- Q09  Interpret b2 (essay) -----
# "b2 is the average change in Sales from before to after the tariff
#  for the product whose `car` dummy is 0 (so for boats)."

#If you didn't mention that it's just for boats,  you get partial credit.


# ----- Q11  Which coefficients sum to Q08(e)?  (multi-answer) -----
#
# Diff = (b0+b1+b2+b3) - (b0+b1) = b2 + b3
#
# CORRECT (select both):  b2  AND  b3
#
# Per-option reasoning:
#   b0 (intercept)        — NOT in the sum. Present in BOTH predictions,
#                           cancels in the subtraction.
#   b1 (car)              — NOT in the sum. car = 1 in BOTH predictions,
#                           cancels in the subtraction.
#   b2 (after_q2_2025)    — IN the sum. after = 1 only in the AFTER pred.
#   b3 (car:after)        — IN the sum. interaction = 1 only in the
#                           AFTER pred (car=1 AND after=1).


# ----- Q12  Interpret the coefficient and its relation to the tariff (essay) -----

#
# "b3 (the interaction car:after_q2_2025) is the coefficient that
#  captures the impact of the tariff on car sales. It isolates the
#  EXTRA change in car sales after the tariff compared to the change in the boats. 

#partial points for stating it's what happens to cars after tariffs. 

# ===============================================================
# PART 3 — Multiple Linear Regression
# ===============================================================

# ----- Q13  Build interaction model + state hypotheses (essay) -----
#
# Goal: test whether the US economic indicator has a DIFFERENT impact
# on car vs. boat Sales.
#
# Add an interaction term car:US_indicator to the MLR. If the slope
# of Sales on US_indicator is the same for both products, that
# interaction coefficient is 0.
#
# Model:  Sales = b0 + b1*car  + b2*US_indicator + b3*(car*US_indicator) + e
#
# H0:  b3 = 0   (same US-economy effect on cars and boats)
# H1:  b3 != 0  (different US-economy effect on cars vs boats)
#

m_int <- lm(Sales ~ car + US_indicator
                  + car * US_indicator, data = exports)

cat("===== Q13 (interaction model) =====\n")
print(summary(m_int))


# ----- Q14  Report the test statistic for Q13 -----
sm_int <- summary(m_int)$coefficients
b_int  <- sm_int["car:US_indicator", "Estimate"]
se_int <- sm_int["car:US_indicator", "Std. Error"]
t_int  <- b_int / se_int
df_int <- m_int$df.residual
p_int  <- 2 * (1 - pt(abs(t_int), df = df_int))


#or you can just look up the test statistic in the summary table of the regression

cat("\n===== Q14 =====\n")
cat(sprintf("  car:US_indicator: estimate = %.3f, SE = %.3f\n", b_int, se_int))
cat(sprintf("  t = %.3f / %.3f = %.3f, df = %d, p = %.2e\n\n",
            b_int, se_int, t_int, df_int, p_int))


# ----- Q15  Conclusion for the interaction test (MC) — CORRECT: (a) -----
#
# (a) "Reject H0: the US economic indicator has a different impact on
#     car Sales than on boat Sales."
#     CORRECT. t = 6.21 is far above t_{0.025, 193} ~ 1.97; p ~ 3e-9.
#     We reject H0 at alpha = 0.05.
#
# (b) "Fail to reject H0: no evidence of a different impact."
#     WRONG. With t = 6.21 the evidence against H0 is overwhelming.
#
# (c) "Accept H0: the US indicator has the same impact on both."
#     WRONG on two counts: (i) we reject, not accept; (ii) statistical
#     tests never let us "accept" H0 — at most we "fail to reject".
#
# (d) "The result is inconclusive."
#     WRONG. p ~ 3e-9 is about as conclusive as it gets.
cat("===== Q15 =====\n")
cat("  |t| = ", round(abs(t_int),2), " >> 1.97  =>  REJECT H0   (option a)\n\n", sep="")


# ----- Q16  Hypotheses: $1 Instagram vs $1 Google (essay) -----
#
# Fit the MLR WITHOUT the interaction (as the question prompt states):
m_mlr <- lm(Sales ~ car + exchange_rate + Instagram + Google + US_indicator,
             data = exports)
#
# H0: b_Instagram = b_Google     ($1 has the same effect on either platform)
# H1: b_Instagram != b_Google


# ----- Q17  Report the test statistic for Q16 -----
# Manual formula (in-class style):
#   Var(b_Inst - b_Goog) = Var(b_Inst) + Var(b_Goog) - 2*Cov(b_Inst, b_Goog)
#   t = (b_Inst - b_Goog) / SE(diff)
# Get the variances/covariance from vcov(m_mlr).

v       <- vcov(m_mlr)
b_inst  <- coef(m_mlr)["Instagram"]
b_goog  <- coef(m_mlr)["Google"]
v_inst  <- v["Instagram", "Instagram"]
v_goog  <- v["Google",    "Google"]
cv_ig   <- v["Instagram", "Google"]

diff_ig <- b_inst - b_goog
se_ig   <- sqrt(v_inst + v_goog - 2 * cv_ig)
t_lc    <- diff_ig / se_ig
df_lc   <- m_mlr$df.residual
p_lc    <- 2 * (1 - pt(abs(t_lc), df = df_lc))

cat("===== Q17 =====\n")
cat(sprintf("  b_Instagram = %.4f, b_Google = %.4f\n", b_inst, b_goog))
cat(sprintf("  Var(b_Inst) = %.6f, Var(b_Goog) = %.6f, Cov = %.6f\n",
            v_inst, v_goog, cv_ig))
cat(sprintf("  SE(diff) = sqrt(%.6f + %.6f - 2*%.6f) = %.4f\n",
            v_inst, v_goog, cv_ig, se_ig))
cat(sprintf("  t = (b_Inst - b_Goog) / SE = %.4f / %.4f = %.3f\n",
            diff_ig, se_ig, t_lc))
cat(sprintf("  df = %d, p = %.2e\n\n", df_lc, p_lc))

#partial credits if didn't use covariance. 


# ----- Q18  Conclusion for Q16 (MC) — CORRECT: (a) -----
#
# (a) "Reject H0: $1 of Instagram does NOT have the same impact as $1
#     of Google."
#     CORRECT. t = 5.05 is far above 1.97; p ~ 1e-6. We reject H0.
#     Direction: b_Inst > b_Goog so Instagram has a LARGER marginal
#     effect than Google.


# ----- Q19  Gauss-Markov / BLUE assumptions (MC) — CORRECT: (d) -----
#
# Question asks which is NOT required for OLS to be BLUE.
# Slide statement: "Under E(u_i)=0, var(u_i)=sigma^2, cov(u_i,u_j)=0,
# X is full rank -- OLS is BLUE. **No normality assumption needed!**"
#
# (a) "Linearity in parameters."
#     IS required. The Gauss-Markov framework is about a LINEAR model.
#
# (b) "Zero conditional mean of errors: E[epsilon | X] = 0."
#     IS required. Needed for unbiasedness (the "U" in BLUE).
#
# (c) "Homoskedasticity: Var(epsilon | X) = sigma^2."
#     IS required for the "Best" (minimum-variance) part of BLUE.
#     Without it OLS is still unbiased but no longer best (use GLS).
#
# (d) "Errors are normally distributed."
#     NOT required for BLUE.  Normality is only needed for small sample inference — not for BLUE itself.
#     => This is the correct answer.


# ===============================================================
# PART 4 — Time series (BOATS subseries only)
# ===============================================================

Boats <- Boats[order(Boats$t), ]
y <- Boats$Sales
n <- length(y)
cat("===== Time-series setup =====\n")
cat("  n_boats =", n, "quarterly observations\n\n")


# ----- Q20  At which lag does seasonal autocorrelation appear? -----
# Quarterly data, annual seasonality => seasonal cycle = 4 quarters.
# So seasonality shows up as high autocorrelation at lag = 4.
cat("===== Q20 =====\n")
cat("  Seasonal lag = 4  (1 year = 4 quarters)\n\n")


# ----- Q21  ACF value at lag 4 -----

#just write down from the table:
0.366


# ----- Q22  ACF significance test (MC) — CORRECT: (a) -----
#
# Class rule of thumb (white-noise band): reject H0: rho_k = 0 if
#   |rho_k| > 2 / sqrt (or use the exact formula: rho_k/(1/sqrt(n-k)))
# For n = 100: threshold = 2 / sqrt(100) = 0.20.
# |rho(4)| = 0.366 > 0.20 -> REJECT H0.
#
# (a) "Reject H0: there is significant autocorrelation at that lag."
#     CORRECT. |rho(4)| = 0.37 clearly exceeds the threshold 0.20.
#

#credit possible if you pick something else in previous question (Value of autocorrelation)
#and it's consistent with your answer here.

threshold <- 2 / sqrt(n)
cat("===== Q22 =====\n")
cat(sprintf("  Threshold 2/sqrt(n) = %.4f; |rho(4)| = %.4f\n", threshold, abs(rho_4)))
cat(sprintf("  |rho(4)| %s threshold  =>  REJECT H0   (option a)\n\n",
            ifelse(abs(rho_4) > threshold, ">", "<")))


# ----- Q23  Smoothing method (MC) — CORRECT: Centered MA of order 4 -----
#
# To remove a seasonal cycle of length S we use a CMA of order S — the
# average smooths over exactly one full cycle, so seasonal ups and downs
# cancel out. Quarterly data -> S = 4.
#
# Per-option reasoning:
#   "Centered MA of order 7."
#       WRONG. Doesn't match the seasonal cycle. Order 7 fits weekly
#       seasonality in daily data, not quarterly data.
#
#   "Centered MA of order 4."
#       CORRECT. Averages over exactly one yearly cycle, removing the
#       seasonal pattern.
#
#   "First differencing."
#       WRONG. First differencing removes a trend, not seasonality.
#       The seasonal pattern is unchanged after differencing.
#
#   "Linear regression."
#       WRONG. A regression on time captures the trend; it does nothing
#       about seasonality.



# ----- Q25  Interpret seasonal index for Q3 = 1.14 (essay) -----
# Model answer:
# "On average, boat Sales in Q3 are 14% above the yearly average."


##need to mention what is the average for to get full credit. 

# ----- Q26  Predict boat Sales for 2027 Q2 (t = 102) -----
# Multiplicative decomposition:  Sales = T * S * C * R
#   T = a + b*t   (trend regression on the smoothed series)
#   S = seasonal index for Q2
#   C = most recent computable cyclical
#   R = irregular  (assume 1)
#
# Values provided in the Canvas table:
a      <- 46125
b_t    <- 327
S_Q2   <- 1.19
C_last <- 1.11
R      <- 1

T_102        <- a + b_t * 102
Sales_2027Q2 <- T_102 * S_Q2 * C_last * R

cat("===== Q26 =====\n")
cat(sprintf("  T_102 = a + b*102 = %.0f + %.2f*102 = %.0f\n", a, b_t, T_102))
cat(sprintf("  Sales = T * S * C * R = %.0f * %.2f * %.2f * %.0f\n",
            T_102, S_Q2, C_last, R))
cat(sprintf("        ~ $%.0f\n\n", Sales_2027Q2))




