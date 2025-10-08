module CaiSemiprimes
using Primes
export isFouvry

"""
    isFouvry(p::Integer)

Assuming `p` is prime, determine if it is a Fouvry prime, that is, `p-1` has
a prime factor greater than `p^(2/3)`. The least Fouvry prime is 11. The Fouvry
primes are A073024.
"""
function isFouvry(p::Integer)
  facs=factor(p-1)
  big(maximum(keys(facs)))^3>big(p)^2
end

end # module CaiSemiprimes
