module main

import std/os/env

effect ndet
  ctl flip() : bool
  ctl fail<a>() : a

fun choice(n : int)
  if (n < 1)
    then fail()
  elif (flip())
    then n
  else choice(n - 1)

fun triple(n : int, s: int)
  val i = choice(n)
  val j = choice(i - 1)
  val k = choice(j - 1)
  if i + j + k == s
    then (i, j, k)
  else fail()

fun hash((a,b,c)) : int
  (53 * a + 2809 * b + 148877 * c) % 1000000007

fun run(n : int, s : int) : div int
  with handler
    ctl flip()
      ((resume(True) : int) + resume(False)) % 1000000007
    ctl fail()
      0
  hash(triple(n, s))

pub fun main()
  val n = get-args().head("").parse-int.default(10)
  val r = run(n, n)
  println(r)
