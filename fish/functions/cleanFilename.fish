function clean 
  if test (count $argv) -lt 1 
    echo "Null arg to 'cleanFilename'"
    exit 1
  end
 
  echo (string join "-" (string split " " "$argv[1]"))
end
