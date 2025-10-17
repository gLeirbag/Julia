using Plots
unicodeplots()

x = range(0, 10, length = 101)
# dot operation em vetor, para cada elemento do array, faz seno
# e retorna um novo array
y = [sin.(x), cos.(x)]
plt = plot(x,y, label = "seno")

# Adicionando uma série a mais ao Plots.CURRENT_PLOT
# plot!(x, sin.(x).*1/2)

# Passando explicitamente um plot, no cat plt aponta para mesma coisa
# que Plots.CURRENT_PLOT
plot!(plt, x, sin.(x).*1/2, label = "cosseno")
plot!(plt, title="Tutorial docs.juliaplots.org", label = "seno*1/2", linewidth=3)

# a função é executada automaticamente quando o REPL executa o código (vs code), mas no terminal não.
display(plt)