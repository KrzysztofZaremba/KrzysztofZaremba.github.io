# ==============================================================
# Final Exam — Spring 2026 — Business Forecasting
# Exports / tariffs dataset (quarterly, 2002 Q1 — 2026 Q4)
# Write your name here:
# ==============================================================

# IMPORTANT: All your code should be in R. Write it inside this script.
# Questions marked [Canvas only] are answered ONLY in Canvas — no R code.
# Questions marked [R + Canvas] require R code AND a Canvas answer.
# Make sure to answer ALL questions in Canvas.
#
# Tip: if your keyboard cannot easily produce the tilde character used
# in R formulas, copy it from here:  ~

load("exports.Rda")

# Convenience: subset to each product
Cars  <- exports[exports$car == 1, ]
Boats <- exports[exports$car == 0, ]

# Explore the data quickly:
# head(exports)
# names(exports)
# summary(exports)


# ============================================================
# PART 1 — Inferential Statistics
# ============================================================

# ----- Q01 [R + Canvas] -----
# Test whether mean Sales differ between cars and boats at alpha = 0.05.
# State your hypotheses and assumptions, report your test statistic,
# and state your conclusion.
#   H0:
#   H1:
#   Assumptions:



# ----- Q02 [Canvas only] -----



# ----- Q03 [Canvas only] -----



# ----- Q04 [Canvas only] -----



# ----- Q05 [Canvas only] -----



# ----- Q06 [Canvas only] -----



# ============================================================
# PART 2 — Tariff impact (regression with two indicator variables)
# ============================================================
# Mexican manufacturer exports two products: cars (subject to a new
# tariff that started in Q2 2025) and boats (not subject).
#
# The variable `after_q2_2025` is 1 from Q2 2025 onward, 0 before.
# Use the regression:
#   Sales = b0 + b1*car + b2*after_q2_2025 + b3*(car * after_q2_2025) + e

# ----- Q07 [Canvas only] -----



# ----- Q08 [R + Canvas] -----
# Estimate the linear regression model and fill in the 5 blanks in Canvas
# using the model's predicted values (do not just compute group means).
# Each answer must be an INTEGER (no commas, no $ sign, no decimals;
# use a minus sign for negative values).



# ----- Q09 [Canvas only] -----



# ----- Q10 [Canvas only] -----



# ----- Q11 [Canvas only] -----



# ============================================================
# PART 3 — Multiple Linear Regression
# ============================================================

# ----- Q12 [R + Canvas] -----
# Build the regression that lets you answer the question, write down
# the model you fit, and state the hypotheses you will test.
#   H0:
#   H1:



# ----- Q13 [R + Canvas] -----



# ----- Q14 [Canvas only] -----



# ----- Q15 [R + Canvas] -----
# Use the regression
#   Sales = b0 + b1*car + b2*exchange_rate + b3*Instagram +
#                b4*Google + b5*US_indicator + e
#   H0:
#   H1:



# ----- Q16 [R + Canvas] -----



# ----- Q17 [Canvas only] -----



# ----- Q18 [Canvas only] -----



# ============================================================
# PART 4 — Time series (BOATS subseries only)
# ============================================================
# Subset:
#   Boats <- exports[exports$car == 0, ]
#   Boats <- Boats[order(Boats$t), ]

# ----- Q19 [Canvas only] -----



# ----- Q20 [Canvas only] -----



# ----- Q21 [R + Canvas] -----
# Use the autocorrelation value at the lag you identified in Q19.



# ----- Q22 [Canvas only] -----



# ----- Q23 [Canvas only] -----



# ----- Q24 [R + Canvas] -----
# Use the multiplicative decomposition Sales = T * S * C * R with the
# values provided in the Canvas question.



# ============================================================
# UPLOAD + ACCOMMODATIONS
# ============================================================

# ----- Q25 [R + Canvas] -----
# Upload this file in Canvas.



# ----- Q26 [Canvas only] -----
