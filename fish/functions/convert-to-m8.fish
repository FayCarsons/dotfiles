for file in *.flac
  ffmpeg -i "$file" -c:a pcm_s16le -ar 44100 -ac 1 -threads 0 (string replace '.flac' '.wav' "$file")
  rm "$file"
end
