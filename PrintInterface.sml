structure PrintInterface =
struct
  type filename = string

  fun load filename =
      TextIO.inputAll (TextIO.openIn filename)

  fun makeSmiFilename smlFilename = OS.Path.base smlFilename ^ ".smi"

  fun makeSMLSharpCommand smlFilename smiFilename =
      let
        val code = load smlFilename
      in
        concat [
          "smlsharp << EOL | tail +2 | cat > ",
          smiFilename,
          "\n",
          code,
          "\n",
          "EOL\n"
        ]
      end

  fun fileExist filename =
      OS.FileSys.access (filename, [OS.FileSys.A_READ])

  fun assert condition errorMsg =
      if condition then () else raise Fail errorMsg

  fun execPrint smlFilename =
      let
        val () = assert (fileExist smlFilename)
                        ("File not found, " ^ smlFilename)
        val () = assert (OS.Path.ext smlFilename = SOME "sml")
                        ("File extention is not sml, " ^ smlFilename)
        val smiFilename = makeSmiFilename smlFilename
        val () = assert (not (fileExist smiFilename))
                        ("File already exists, " ^ smiFilename)
        val command = makeSMLSharpCommand smlFilename smiFilename
      in
        OS.Process.system command
      end
end
