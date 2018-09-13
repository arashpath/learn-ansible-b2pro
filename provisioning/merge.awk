BEGIN {
  # awk way to check whether a variable is not defined
  if (newwins == "" && newwins == 0) {
    newwins = 0      # by default old line wins
  }
}

# load new lines, skip empty/comment lines
NR == FNR {
  if (!/^[[:blank:]]*(#|$)/) {
    ip = substr($0, 1, index($0, " ") - 1)
    newlines[ip] = $0
  }
  next
}

# print comments and empty lines verbatim
/^[[:blank:]]*(#|$)/ {
  print
  next
}

$1 in newlines {
  print (whowins == 1) ? newlines[$1] : $0
  # either way, forget it
  delete newlines[$1]
  next
}

{ print }

# if anything is left in newlines, they must be truly new lines
END {
  for (ip in newlines)
    print newlines[ip] 
}