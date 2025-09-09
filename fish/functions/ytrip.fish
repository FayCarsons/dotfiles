function clean
  echo $argv | \
  string replace -r '\([0-9]{4}\)|\[[0-9]{4}\]' '' | \
  string replace -r '\(Official Video\)|\[Official Video\]' '' | \
  string replace -r '\(Official Audio\)|\[Official Audio\]' '' | \
  string replace -r '\(Lyric Video\)|\[Lyric Video\]' '' | \
  string replace -r '\(Music Video\)|\[Music Video\]' '' | \
  string replace -r '\(HD\)|\[HD\]' '' | \
  string replace -r '  \+' ' ' | \
  string replace -a ' ' '-' | \
  string replace -r '-\+' '-' | \
  string replace -r '(^-|-$)' '' | \
  string replace -r '[/\\:*?"<>|]' ''
end 

function ytrip
# Usage: yt-audio [YouTube URL]
    if test (count $argv) -lt 1
        echo "Need a URL dumbass"
        return 1
    end

    set baseDir "$HOME/Desktop/Samples"
    
    set url "$argv[1]"
    set category "/Misc"
    
    if test (count $argv) -ge 2
      switch (string lower $argv[2])
        case "breaks"
          set category "/Breaks"
        case "songs"
          set category "/Songs"
        case * 
          echo "[ERROR] Second argument must be one of #{breaks, songs}"
          exit 1
      end
    end

    set destination "$baseDir$category"

    # Get the filename first
    set filename (yt-dlp --get-filename -o "%(title)s.%(ext)s" $url)
    
    # Clean the filename using fish directly
    set clean_filename (clean "$filename")
    
    # Now download with the clean filename
    yt-dlp -f bestaudio --extract-audio --audio-format flac --audio-quality 0 \
    --add-metadata \
    -o "$destination/$clean_filename.%(ext)s" \
    $url

    echo "Done ^_^"
end
