# SPDX-FileCopyrightText: 2026 Taro Suzuki
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo ${1}行目のテスト失敗
    res=1
}

res=0



### ttcheck のテスト ###
out=$(printf "NEE,15,佐藤 鈴木\nヨルシカ,22,佐藤 高橋\n" | ./ttcheck 10:00)
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "10:15 - 10:37 (22m) | ヨルシカ \[WARN: 佐藤\]" || ng "$LINENO"

out=$(printf "NEE,abc,佐藤\n" | ./ttcheck 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"

out=$(printf "" | ./ttcheck 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"

[ "$res" = 0 ] && echo OK
exit $res
