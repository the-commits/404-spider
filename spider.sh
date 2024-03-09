#!/usr/bin/env bash

OUTPUT=""
URL=""
RESPONSE_CODE="404"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_title() {
	echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓███████▓▒░░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓███████▓▒░ ░▒▓████████▓▒░░▒▓███████▓▒░  "
	echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ "
	echo -e "${GREEN}░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ "
	echo -e "${GREEN}░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓████████▓▒░       ░▒▓██████▓▒░ ░▒▓███████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  ░▒▓███████▓▒░  "
	echo -e "${GREEN}       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ "
	echo -e "${GREEN}       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░             ░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ "
	echo -e "${GREEN}       ░▒▓█▓▒░░▒▓████████▓▒░       ░▒▓█▓▒░      ░▒▓███████▓▒░ ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓███████▓▒░ ░▒▓████████▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
	echo -e "${GREEN}                                                                                                                              "
	echo -e "${NC}                                                                                                                              "
}

print_help() {
	echo "Usage: $0 [OPTIONS]"
	echo "This bash script is used to perform a wget operation on a specified URL, logging the output to a specified file. "
	echo "Options: "
	echo "  --output         Specify the output file to which the log will be written."
	echo "  --url            Specify the URL to be scanned with wget."
	echo "  --response-code  Specify the HTTP response code to be targeted in the log output."
	echo "  --help           Print this help message and exit."
}

while (("$#")); do
	case "$1" in
	--output)
		OUTPUT="$2"
		shift 2
		;;
	--url)
		URL="$2"
		shift 2
		;;
	--response-code)
		RESPONSE_CODE="$2"
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

print_title

if [ -n "$OUTPUT" ] && [ -n "$URL" ] && [ -n "$RESPONSE_CODE" ]; then
	wget --spider \
		--output-file "$OUTPUT" \
		--execute robots=off \
		--recursive \
		--page-requisites \
		--no-directories \
		--no-check-certificate \
		"$URL"
fi

if [ -n "$RESPONSE_CODE" ] && [ -n "$OUTPUT" ]; then
	TEXT=$(grep -B 2 " ${RESPONSE_CODE} .*" "$OUTPUT" | awk 'NR%2==1')
	if [[ $RESPONSE_CODE == 4* ]]; then
		echo -e "${BLUE}${TEXT}${NC}"
	elif [[ $RESPONSE_CODE == 2* ]]; then
		echo -e "${GREEN}${TEXT}${NC}"
	elif [[ $RESPONSE_CODE == 3* ]]; then
		echo -e "${YELLOW}${TEXT}${NC}"
	elif [[ $RESPONSE_CODE == 5* ]]; then
		echo -e "${RED}${TEXT}${NC}"
	else
		echo -e "${NC}${TEXT}${NC}"
	fi
fi
