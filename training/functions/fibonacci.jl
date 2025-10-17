# Declaro o módulo
module GabrielFibonacci
# Listá de variáveis públicas
export fibonacci, fibonaccidynamic, fibonaccirec

function fibonacci(length::Number)::Array{Number}
    sequence = [(1 / sqrt(5)) * (((1 + sqrt(5)) / 2)^n - ((1 - sqrt(5)) / 2)^n)::Number for n ∈ 2:length+1]
    # Aqui em cima fizemos uma list compreension, semelhante a python.
    # Por padrão, Julia retorna a última expressão do bloco do escopo da função.
    # Atribuição retorna o resultado da expressão.
    # Para se chegar na fórmula de fibonnaci, é complicado
end

function fibonaccirec(length::Number)
    # Aqui vamos fazer uma expressão composta, ou seja, estamos fazendo uma expressão
    # Que é na verdade várias inclusas
    # Além disso estamos fazendo uma função anônima e passando para element
    element = (n)::Number ->
        begin
            if n == 1 || n == 0
                return 1
            else
                return element(n - 1) + element(n - 2)
            end
        end
    sequence = [element(n) for n ∈ 1:length]
end

function fibonaccidynamic(length::Number)
    memo = fill(Number(0), length)
    memo[1] = 1
    element = (n)::Number ->
        begin
            if n == 1 || n == 0
                return memo[1]
            else
                if memo[n] !== 0
                    return memo[n]
                else
                    return memo[n] = element(n - 1) + element(n - 2)
                end
            end
        end
    sequence = [element(n) for n ∈ 1:length]
end

end

# # Fibs é uma tupla
# fibs = (fibonacci, fibonaccidynamic, fibonaccirec)

# @profview for g::Function ∈ fibs
#     my_time = time()
#     # (print ∘ g)(100)
#     sequence::Array{Number} = g(big"30")
#     my_time -= time()
#     print("The function evalueted in $(abs(my_time)) seconds. Last element: $(round(sequence[end])) \n")
#     print("\n")
# end