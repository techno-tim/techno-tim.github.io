#!/usr/bin/env bash
#
# Using HTML-proofer to test site.
#
# Requirement: https://github.com/gjtorikian/html-proofer
#
# Usage: bash /path/to/test.sh [indicated path]

DEST=_site
URL_IGNORE=cdn.jsdelivr.net

_build=false

help() {
  echo "Usage:"
  echo
  echo "   bash ./tools/test.sh [options]"
  echo
  echo "Options:"
  echo "     --build                  Run Jekyll build before test."
  echo "     -d, --dir   <path>       Specify the test path."
  echo "     -h, --help               Print this information."
}

if [[ -n $1 && -d $1 ]]; then
  DEST=$1
fi

while (($#)); do
  opt="$1"
  case $opt in
    --build)
      _build=true
      shift
      ;;
    -d | --dir)
      if [[ ! -d $2 ]]; then
        echo -e "Error: path '$2' doesn't exist\n"
        help
        exit 1
      fi
      DEST=$2
      shift
      shift
      ;;
    -h | --help)
      help
      exit 0
      ;;
    *)
      # unknown option
      help
      exit 1
      ;;
  esac
done

if $_build; then
  JEKYLL_ENV=production bundle exec jekyll b
fi

bundle exec htmlproofer "$DEST" \
  --disable-external \
  --check-html \
  --empty_alt_ignore \
  --allow_hash_href \
  --url_ignore $URL_IGNORE
