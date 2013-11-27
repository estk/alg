def plan(A,B):
  n = len(A)
  P = [None]*n
  
  def gM(M):
    if M: return A
    else: return B
  def maxsnd (l):
    return max(l, key=lambda (x,y): y)
  def opt(P,t):
    if t == n:
      return (P, 0)
    
    M = P[-1]
    Mbar = int(not M)
    P1, mx1 = opt(P+[M], t+1)
    P2, mx2 = opt(P+[(Mbar)], t+1)
    
    cont = mx1+gM(M)[t]
    if cont >= mx2:
      return (P1, cont)
    else:
      return (P2,mx2)

  startA = opt([1],1)
  startB = opt([0],1)
  return maxsnd([(startA[0], startA[1] + A[0]), (startB[0], startB[1] + B[0])])
  
A = [1,2,3]
B = [10,2,1]
print plan(A,B)