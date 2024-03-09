#!/usr/bin/env bash

OUTPUT=""
URL=""

print_title() {
  echo -e "\033[0;32m░▒▓█▓▒░░▒▓█▓▒░░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓███████▓▒░░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓███████▓▒░ ░▒▓████████▓▒░░▒▓███████▓▒░  ";
  echo -e "\033[0;32m░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ";
  echo -e "\033[0;32m░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ";
  echo -e "\033[0;32m░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓████████▓▒░       ░▒▓██████▓▒░ ░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  ░▒▓███████▓▒░  ";
  echo -e "\033[0;32m       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ";
  echo -e "\033[0;32m       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ";
  echo -e "\033[0;32m       ░▒▓█▓▒░░▒▓████████▓▒░       ░▒▓█▓▒░      ░▒▓███████▓▒░ ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓███████▓▒░ ░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░ ";
  echo -e "\033[0;32m                                                                                                                              ";
  echo -e "\033[0m                                                                                                                              ";
}

print_help() {
  echo "Usage: $0 [OPTIONS]"
  echo "This bash script is used to perform a wget operation on a specified URL, logging the output to a specified file. "
  echo "Options: "
  echo "  --output       Specify the output file to which the log will be written."
  echo "  --url          Specify the URL to be scanned with wget."
  echo "  --help         Print this help message and exit."
}

while (( "$#" )); do
  case "$1" in
    --output)
      OUTPUT="$2"
      shift 2
      ;;
    --url)
      URL="$2"
      shift 2
      ;;
    --help)
      print_help
      exit 0
      ;;
    *)
      shift
      ;;
  esac
done

if hash !wget 2>/dev/null; then
   echo "wget is not installed. Please install."
   exit 1
fi

print_title;

if [ -n "$OUTPUT" ] && [ -n "$URL" ]; then
  wget --spider \
    --output-file "$OUTPUT" \
    --execute robots=off \
    --recursive \
    --page-requisites \
    --no-directories \
    --no-check-certificate \
    "$URL"

  tput setab 1; tput setaf 2;
  grep -B 2 ' 404 Not Found' "$OUTPUT" | awk 'NR%2==1'; tput sgr0
fi