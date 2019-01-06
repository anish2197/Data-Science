#Loading dependencies
library(arules)
library(arulesViz)
library(datasets)
library(convertGraph)

#Loading the dataset
data("Groceries")

x <- dim(Groceries)


#Exploratory data analysis
itemFrequencyPlot(Groceries,topN=10,type="absolute")

#Mining rules
#Support = 0.001 and confidence = 0.8:
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))
inspect(rules[1:5])

#Sorting rules by confidence
rules <- sort(rules, by = "confidence", decreasing = TRUE)
inspect(rules[1:5])

#Removing redundant rules
redundant_rules <- is.redundant(rules)
summary(redundant_rules)  #18 redundant rules
rules <- rules[!redundant_rules]
rules #18 redundant entries removed

#Targeting a specific item : whole milk
#Milk on RHS - 
rules2 <- apriori(data = Groceries,
                 parameter = list(supp = 0.001, conf = 0.8),
                 appearance = list(default = "lhs", rhs = "whole milk"))
rules2 <- sort(rules, decreasing = TRUE, by = "confidence")
inspect(rules2[1:5]) #We can see people are more likely to buy "whole milk" if they buy "rice" and "sugar"

#Milk on LHS - 
rules3 <- apriori(data = Groceries,
                 parameter = list(supp = 0.001, conf = 0.1),
                 appearance = list(default = "rhs", lhs = "whole milk"))
rules3 <- sort(rules, decreasing = TRUE, by = "confidence")
inspect(rules3[1:5]) #We can see people who buy "whole milk" are more likely to buy "vegetables"

#Visualizations:
plot(rules[1:10],method="graph", engine = "interactive", shading = "confidence")
plot(rules2[1:10],method="graph", engine = "interactive", shading = NA)
