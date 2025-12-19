module GabrielTimer
"""
    timerwrapper(time_limit::Int, f::Function)

A function that loops around `f` for next to `time_limit` seconds.

Returns the `(count of loops, total elapsed time)`.
"""
function timerwrapper(time_limit::Int, f::Function)
    initial_time = time_ns()
    timer = 0
    counter = 1
    while timer <= time_limit
        f(counter)
        timer = time_ns() - initial_time
        counter += 1
    end
    (counter, Int(timer))
end
end
