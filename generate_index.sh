#!/bin/bash

set -eu

# 簡易 HTML エスケープ
escape() {
	sed -e "
		s/&/\\&amp;/g;
		s/'/\\&#x27;/g;
		s/\`/\\&#x60;/g;
		s/\"/\\&quot;/g;
		s/</\\&lt;/g;
		s/>/\\&gt;/g;
	"
}

cat <<EOF
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TKYTEL COMMENT</title>
</head>
<body>
<h1>TKYTEL COMMENT</h1>
<p>
東京広域電話網 文書部 の発行する TKYTEL COMMENT では、東京広域電話網に関するさまざまについての記録を提供します。
</p>
<hr>
<table>
<thead>
<tr>
<th scope="col">No</th>
<th scope="col">Content</th>
<th scope="col">Date</th>
</tr>
</thead>
<tbody>
EOF

for filename in $(find . -name \*.txt | sort -V);do
    # 文書番号
    NUMBER="$(echo "$filename" | sed 's/[^0-9]*\([0-9]*\).*/\1/')"
    # 表題
    TITLE=$(sed -n "1,/^$/d; /^$/q; p" ${filename} | sed "s/^ *//" | sed -z "s/\\n//g" | escape)
    
    DATE_RAW=$(sed -n "/^$/{x;1!p;q};h" ${filename} | sed "s/^ *//" | escape)
    DATE_SLASHED=$(echo ${DATE_RAW} | tr - / | escape)

    cat <<EOF
<tr>
<th scope="row"><a href="${filename}">TC${NUMBER}</a></th>
<td>${TITLE}</td>
<td><time datetime="${DATE_RAW}">${DATE_SLASHED}</time></td>
</tr>
EOF
done

cat <<EOF
</tbody>
</table>
</body>
</html>
EOF
