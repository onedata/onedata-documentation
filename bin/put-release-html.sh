#!/bin/sh
<<<<<<< HEAD
RELEASE=21.02.0-alpha25
=======
RELEASE=20.02.17
>>>>>>> 7449a5c900f3b2588113fe00c14522cb9294cb65
find _book -name '*.html' -exec sed -i "s/__ONEDATA_RELEASE__/${RELEASE}/g" {} \;
