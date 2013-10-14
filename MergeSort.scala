import scala.util.Random
import scala.reflect.ClassTag

object MergeSort {
  def main(args: Array[String]) {
    val n = 100
    val max = 1000

    var a: Array[Int] = Array.fill(100)(Random.nextInt(max))
    println("Before:")
    println(a.mkString("[", ",", "]"))

    var sorted = sort(a);
    println("After:")
    println(sorted.mkString("[", ",", "]"))
  }

  def merge(a: Array[Int], b: Array[Int]): Array[Int] =
    (a,b) match {
      case (Array(a1, as @ _*), Array(b1, bs @ _*)) if a1 < b1 =>
        Array(a1) ++ merge(as.toArray, b)
      case (Array(a1, as @ _*), Array(b1, bs @ _*)) if b1 < a1 =>
        Array(b1) ++ merge(a, bs.toArray)
      }


  def sort(array: Array[Int]): Array[Int] = {
    array match {
      case a @ Array(_) => a
      case _ => {
        val l = array.length
        merge( sort(array.take(l/2)), sort(array.drop(l/2)) )
      }
    }
  }
}
