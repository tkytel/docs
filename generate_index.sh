#!/bin/bash

#区切り文字の置換？を無効化
IFS=""

# 最悪
echo "<!DOCTYPE html>
<html lang=\"ja\">
<head>
<meta charset=\"UTF-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>TKYTEL COMMENT</title>
</head>
<body>
<h1>TKYTEL COMMENT</h1>
<hr>
<table>
<thead>
<tr>
<th scope=\"col\">No</th>
<th scope=\"col\">Content</th>
<th scope=\"col\">Date</th>
</tr>
</thead>
<tbody>"

for filename in *.txt;do
    NUMBER=${filename%.txt}
    #echo 文書番号 $NUMBER
    AUTHOR=`sed -n 2p ${filename} | xargs echo`
    #echo 著者 $AUTHOR
    TITLE=`sed -n 5p ${filename} | xargs echo`
    #echo タイトル $TITLE
    DATE_RAW=`sed -n 3p ${filename} | xargs echo`
    DATE_SLASHED=`sed -n 3p ${filename} | xargs date "+%Y/%m/%d" --date`

    echo "<tr>
<th scope=\"row\"><a href=\"${filename}\">TC${NUMBER}</a></th>
<td>${TITLE}</td>
<td><time datetime=\"${DATE_RAW}\">${DATE_SLASHED}</time></td>
</tr>"
done

# 最悪2
echo "</tbody>
</table>
</body>
</html>"