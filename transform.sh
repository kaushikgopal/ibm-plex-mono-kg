#!/bin/zsh

fontSuffix="KG 2"
mkdir -p "IBM-Plex-Mono-$fontSuffix"
cd IBM-Plex-Mono

# pipx install opentype-feature-freezer


#  ss03 - slashed 0


# Default IBM Plex Mono
# Regular - styled g; styled a   (with caps)
# Italic  - plain g ; plain a   (without cap)

# X1
# Regular - plain g ; plain a

# X2
# Italic - styled g ; styled a

# In the non-italic versions of IBM Plex Mono
#  ss01 - plain a
#  ss02 - plain g
for f in $(fd -HI ibmplexmono -e otf -E '*Italic.otf'); do
  pyftfeatfreeze -f "ss03" -R "Mono/Mono $fontSuffix" -v $f "${f%.otf}.kg.otf"
done

# In the italicized versions of IBM Plex Mono
#  ss01 - use stylistic variant of a (with the hat)
#  ss02 - use g with a cap
for f in $(fd -HI Italic.otf -e otf); do
  pyftfeatfreeze -f "ss03,ss01,ss02" -R "Mono/Mono $fontSuffix" -v $f "${f%.otf}.kg.otf"
done

mv *.kg.otf ../"IBM-Plex-Mono-$fontSuffix"/
cd ../"IBM-Plex-Mono-$fontSuffix"/
for f in *.kg.otf; do
  mv $f "$(echo "$f" | sed s/"\.kg"/"-$fontSuffix"/)"
done

open .
