include("time gabriel.jl")

module Compare

using ..GabrielTimer: timerwrapper
function iterationxtime(ftocompare::Array{Function}, iterations=30)
    iterations_matrix = zeros(Float64, length(fibs), iterations)
    for (i, g::Function) in enumerate(ftocompare)
        for j in 1:iterations
            my_time = time_ns()
            sequence::Array{Number} = (g ∘ BigInt)(iterations)
            my_time = time_ns() - my_time
            iterations_matrix[i, j] = my_time
        end
    end
    iterations_matrix
end

function maxinterationintime(ftocompare::Array{Function}, max_seconds=10)
    tuple_list::Array{Tuple{Number,Number}} = []
    for g in ftocompare
        push!(tuple_list, timerwrapper(max_seconds * 10^9, g))
    end
    tuple_list
end

"""
    multithreadmaxinterationintime(ftocompare::Array{Function}, max_seconds=10)

    Return an array of (count of loops, total elapsed time) for each of the functions.
TBW
"""
function multithreadmaxinterationintime(ftocompare::Array{Function}, max_seconds=10)
    # Usando um vetor compartilhado para armazenar os resultados
    tuple_list::Array{Tuple{Number,Number}} = []
    fetch.([Threads.@spawn push!(tuple_list, timerwrapper(max_seconds * 10^9, g)) for g in ftocompare])
    tuple_list
end
end

