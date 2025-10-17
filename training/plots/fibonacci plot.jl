# Incluo o arquivo(Faço o append nesse)
include("../functions/fibonacci.jl")
# chamo o módulo que defini em fibonnaci.jl
using .GabrielFibonacci: GabrielFibonacci

using Plots

fibs = (GabrielFibonacci.fibonacci, GabrielFibonacci.fibonaccidynamic, GabrielFibonacci.fibonaccirec)
iterations = 30
iterations_matrix = zeros(Float64, length(fibs), iterations)

# Aquecimento, pois a primeira execução é a mais lerda:
for g in fibs
    (g ∘ BigInt)(iterations)  # warm-up (compila antes de medir)
end

for (i, g::Function) in enumerate(fibs)
    for j in 1:iterations
        my_time = time_ns()
        sequence::Array{Number} = (g ∘ BigInt)(iterations)
        my_time = time_ns() - my_time
        iterations_matrix[i, j] = my_time
    end
end


iterations_matrix
my_plt = plot(title="Algoritmos de Cálculo de fibonacci",
    xlabel="Iteração",
    ylabel="Tempo de execução (ns)",
    yscale=:symlog)
labels = ["Formula", "Dynamic Prog", "Recursive"]
normal = iterations_matrix ./ maximum(iterations_matrix, dims=2)
for (i, time_sequence) ∈ (enumerate ∘ eachrow)(normal)
    # print(time_sequence, "\n")
    plot!(my_plt, 1:iterations, time_sequence ./ maximum(time_sequence, dims=1), z_order=abs(1),
        contour_labels=false,
        seriestype=:bar, linestyle=:auto, label=labels[i], linewidth=1)
end
# plot!(my_plt)
display(my_plt)
