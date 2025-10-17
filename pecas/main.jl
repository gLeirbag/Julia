using Plots

x = range(0, 10, length=12)
y = sin.(x)
plot(x, y)