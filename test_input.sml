signature TestSig =
sig
  type t
  val f : t -> string
  val x : t
end

structure TestStruct =
struct
  type t = int

  fun f x = "hi"

  val x = 0
end
