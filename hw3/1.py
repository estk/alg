def par (W, L):
  T = [None]*len(W)
  B = [None]*len(W)
  
  def minsnd (l):
    return min(l, key=lambda (x,y): y)
  def scale (t, v):
    return (t[0], (t[1]+v))
  def length(i,j):
    summ = 0
    for k in range(i,j+1):
      summ += len(W[k])+1
      # print len(W[k])
    return summ-1
    # if i==j:
    #   return len(W[i])
    # return length(i,j-1) + length(i-1,j) + length(i-1,j-1) + 1
  def slack2 (i,j):
    s = L - length(i,j)
    print length(i,j)
    if s<0:
      return float('inf')
    else:
      return s
      
  def opt (j):
    if j==0:
      return ([],slack2(j,j))
    if T[j]:
      return T[j]
      
    print "computing opt"
    parts = []
    for k in range(j):
      o = opt(k)
      parts.append( (o[0] + [k],(o[1] + slack2(k+1,j))) )
      
    print parts
    T[j] = minsnd(parts)
    print T[j], j
    return T[j]
    
  for k in range(len(W)):
    opt(k)
  # print range(len(W)):
  print opt((len(W)-1))

par(['hello', 'my', 'name', 'is', 'evan'], 7)