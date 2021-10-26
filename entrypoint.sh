#!/usr/bin/env bash

set -eu

pip install --upgrade pip
pip install mkdocs-codecheck requests

NC='\033[0m' # No Color
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'

CMD='mkdocs-linkcheck'

declare -a FIND_CALL
declare -a COMMAND_DIRS COMMAND_FILES
declare -a COMMAND_FILES

FOLDER_PATH="$1"
RECURSE="$2"
if [ -z "$3" ]; then
    EXCLUDES="__none__"
else
    EXCLUDES="$3"
fi
if [ -z "$4" ]; then
    LANGUAGES="__all__"
else
    LANGUAGES="$4"
fi
SYNTAX_ONLY="$5"
USE_VERBOSE_MODE="$6"

echo -e "${BLUE}FOLDER_PATH: $1${NC}"
echo -e "${BLUE}RECURSE: $2${NC}"
echo -e "${BLUE}EXCLUDES: $3${NC}"
echo -e "${BLUE}LANGUAGES: $4${NC}"
echo -e "${BLUE}SYNTAX_ONLY: $5${NC}"
echo -e "${BLUE}VERBOSE_MODE: $6${NC}"

check_errors () {
   if [ -e error.txt ] ; then
      if grep -q "Broken links: 0" error.txt; then
         echo -e "${YELLOW}=========================> MARKDOWN LINK CHECK <=========================${NC}"
         printf "\n"
         echo -e "${GREEN}[✔] All links are good!${NC}"
         printf "\n"
         echo -e "${YELLOW}=========================================================================${NC}"
      else
         echo -e "${YELLOW}=========================> MARKDOWN LINK CHECK <=========================${NC}"
         cat error.txt
         printf "\n"
         echo -e "${YELLOW}=========================================================================${NC}"
         exit 113
      fi
   else
      echo -e "${GREEN}All good!${NC}"
   fi
}

add_options () {
    
   echo -e "EXCLUDES = ${EXCLUDES}"
   if [ $EXCLUDES != "__none__" ]; then
      CMD+=('--exclude')
      CMD+=("$EXCLUDES")
   fi

   if [ $LANGUAGES != "__all__" ]; then
      CMD+=('--languages')
      CMD+=("$LANGUAGES")
   fi
   
   if [ "$RECURSE" = "yes" ]; then
      CMD+=('--recurse')
   fi
   
   if [ "$SYNTAX_ONLY" = "yes" ]; then
      CMD+=('--syntax-only')
   fi

   if [ "$USE_VERBOSE_MODE" = "yes" ]; then
      CMD+=('--verbose')
   fi

   if [ -d "$FOLDER_PATH" ]; then
      CMD+=("$FOLDER_PATH")
   fi

}

add_options

set -x
#"${CMD[@]}" &>> error.txt
#"${CMD[@]}" >> error.txt
"${CMD[@]}"
set +x

#check_errors
