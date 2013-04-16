#!/bin/bash

HACKABLE=false
NEED_TRAINING=true
SKULLSPACE_STR="SkullSpace"
OWNER="$SKULLSPACE_STR"

QR_CODE_PNG="qrcode.png"
OUTFILE="label.png"

while getopts "hto:" arg; do
    case "$arg" in
    h) HACKABLE=true;;
    t) NEED_TRAINING=false;;
    o) OWNER="$OPTARG";;
    -) break;;
    *) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    esac
done
shift $(( OPTIND-1 ))

TOOL_NAME=$1
URL="skullspace.ca/wiki/index.php/$TOOL_NAME"

if [[ "$OWNER" = "$SKULLSPACE_STR" ]]; then
   owner_icon="Skullspace_logo_square_white.svg"
else
   owner_icon="owner.svg"
fi


tmpfile=$(mktemp)
tmpfile2=$(mktemp)

qrencode -s 30 -l H -o ${tmpfile} $URL
# 1350 x 1350
convert -size 1350x1350 ${tmpfile} ${tmpfile}
composite -gravity center -background none ${owner_icon} ${tmpfile} ${QR_CODE_PNG}
cp placeholder.svg ${tmpfile2}

sed -i "s/tool_name/$TOOL_NAME/" ${tmpfile2}
sed -i "s/owner_name/$OWNER/" ${tmpfile2}
[[ $NEED_TRAINING = true ]] && sed -i "s/Training not required/Training required/" ${tmpfile2}
[[ $HACKABLE = true ]] && sed -i "s/Do not hack/Free to hack/" ${tmpfile2}

convert ${tmpfile2} label.png

rm -f $tmpfile
rm -f $tmpfile2
rm -f $QR_CODE_PNG
