module CaiSemiprimes
using Primes
export isFouvry,caiSemiprimes,listTerms,writeBfile

"""
    isFouvry(p::Integer)

Assuming `p` is prime, determine if it is a Fouvry prime, that is, `p-1` has
a prime factor greater than `p^(2/3)`. The least Fouvry prime is 11. The Fouvry
primes are A073024.
"""
function isFouvry(p::Integer)
  facs=factor(p-1)
  p>2 && big(maximum(keys(facs)))^3>big(p)^2
end

"""
    caiSemiprimes(minPrime::Int,maxSemiprime::Int)

List all squarefree Cài semiprimes less than or equal to maxSemiprime whose
factors are at least minPrime.
"""
function caiSemiprimes(minPrime::Int,maxSemiprime::Int)
  if minPrime<11
    minPrime=11
  end
  maxPrime=max(minPrime,maxSemiprime÷minPrime)
  # If maxPrime>√typemax(Int), this function will return garbage values.
  # But it will also take a very long time or overflow the memory!
  primeList=filter(isFouvry,primes(minPrime,maxPrime))
  n=length(primeList)
  sort(filter(x->x<=maxSemiprime,[primeList[i]*primeList[j] for i in 1:n for j in (i+1):n]))
end

function listTerms()
  list=caiSemiprimes(0,8192)
  for i in eachindex(list)
    if i>1
      print(", ")
    end
    print(list[i])
  end
end

function writeBfile()
  list=caiSemiprimes(0,2^20)
  file=open("b387952.txt","w")
  for i in eachindex(list)
    println(file,i,' ',list[i])
  end
  println(file)
  close(file)
end

end # module CaiSemiprimes
