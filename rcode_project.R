covid <- read.csv("C:/Users/casti/OneDrive/Desktop/School_Stuff/Masters_Stuff/STAT 560/Project/covid_surv.csv")
attach(covid)
library(survival)


days.surv <- survfit(Surv(days, status==1) ~ 1, 
                     conf.type="none", se.fit=FALSE)
summary(days.surv)

plot(days.surv, mark.time = TRUE, 
     pch = 1, 
     main = 'Kaplan-Meier Survival Curve', 
     xlab = 'Days', 
     ylab = 'Survival Distribution Function')

# KM Survival Curves by Age Group
age_group <- factor(age_group, 
                    levels = c("adolescent", "young adult", 
                               "middle aged", "senior"))

days.surv <- survfit(Surv(days, status==1) ~ age_group, 
                     conf.type="none", se.fit=FALSE)
summary(days.surv)

plot(days.surv, mark.time = TRUE, 
     pch = 1, col = c('darkorange', 'black', 'darkgreen', 'red'), 
     main = 'Kaplan-Meier Survival Curve', 
     xlab = 'Days', 
     ylab = 'Survival Distribution Function')


legend('topright', legend = c('Adolescent', 'Young Adult', 'Middle Age', 'Senior'), 
       text.col = c('darkorange', 'black', 'darkgreen', 'red'))

survdiff(Surv(days, status==1)~ age_group)

# KM Survival Curves by Sex
gender <- factor(gender, levels = c('female', 'male'))

days.surv <- survfit(Surv(days, status==1) ~ gender, 
                     conf.type="none", se.fit=FALSE)
summary(days.surv)

plot(days.surv, mark.time = TRUE, 
     pch = 1, col = c('darkorchid3', 'deepskyblue4'), 
     main = 'Kaplan-Meier Survival Curve', 
     xlab = 'Days', 
     ylab = 'Survival Distribution Function')


legend('topright', legend = c('Female', 'Male'), 
       text.col =c('darkorchid3', 'deepskyblue4'))

survdiff(Surv(days, status==1) ~ gender)

# cox-ph model
covid.ph <- coxph(Surv(days, status == 1) ~ age + gender)
summary(covid.ph)
