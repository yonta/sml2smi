local
val args = CommandLine.arguments ()
fun printHelp () =
    print "Usage: sml2smi FILENAME\n"
in
  val () =
      if null args
      then printHelp ()
      else
        let val arg = hd args
        in (PrintInterface.execPrint arg; ()) end
end
