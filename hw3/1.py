def par (W, L):
  n = len(W)-1
  T = [None]*len(W)
  B = [None]*len(W)
  
  def minsnd (l):
    return min(l, key=lambda (x,y): y)
  def slack2 (i,j):
    def length(i,j):
      summ = 0
      for k in range(i,j+1):
        summ += len(W[k])+1
      return summ-1
    
    s = L - length(i,j)
    if s<0:
      return float('inf')
    else:
      return s*s
  def opt (j):
    if j==0:
      return slack2(j,j)
    if T[j]:
      return T[j]
      
    print "computing opt"
    parts = []
    for k in range(j):
      o = opt(k)
      parts.append( (k, opt(k) + slack2(k+1,j)) )
      
    B[j], T[j] = minsnd(parts)
    return T[j]
    
#----------------
  minimum = opt(len(W)-1)
  
  k = n
  res = []
  
  while k!=0:
    res.append( B[k] )
    k = B[k]
  print res
  print T[n]

par(['hello', 'my', 'name', 'is', 'evan'], 7)