# Incluo o arquivo(Faço o append nesse)
include("../functions/fibonacci.jl")
# chamo o módulo que defini em fibonnaci.jl
include("../functions/compare.jl")

using .GabrielFibonacci: GabrielFibonacci
using .Compare: Compare
using Base.Threads: Threads
using CairoMakie

print("Número de Threads Disponíveis: $(Threads.threadpoolsize())")

# using Plots

labels = ["Fibonacci", "Fibonacci Dynamic Recursive", "Fibonacci Recursive"] 
fibs = [GabrielFibonacci.fibonacci, GabrielFibonacci.fibonaccidynamic, GabrielFibonacci.fibonaccirec]
seconds = 1

results = Compare.multithreadmaxinterationintime(fibs, seconds)
counts_iterations = [first(result) for result in results] 


fibonacci_fig =  Figure() 
axis = Axis(fibonacci_fig[1, 1], ylabel = "Iterations Done", title = "Fibonacci Algorithms Iterations for $seconds seconds", xticks = 1:3)
boxes = barplot!(axis,[1, 1, 1],  counts_iterations,
    color = [3, 2, 1],
    bar_labels = ["$(label)($(count))" for (label, count) in zip(labels, counts_iterations )]
    ,width = 0.2
)
hidespines!(axis)
hidedecorations!(axis, ticks = false)
fibonacci_fig
