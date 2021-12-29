rm -rf ja.txt ju.txt ji.txt js.txt
r=$(awk 'BEGIN{srand();printf "%.16f\n",rand()}')
ua=$(cat ua.txt)
ck=$(cat ck.txt)
rw=$(cat rw.txt)
if [ -s zlm.txt ]
then zlm=$(cat zlm.txt)
zs=1
fi
if [ -s jkey.txt ]
then jkey=$(cat jkey.txt)
fi
curl -k -i --raw -o fqfrdr.txt "http://$rw/fast_reada/do_read?for=$zlm&zs=$zs&pageshow&r=$r&jkey=$jkey" -H "Host: $rw" -H "Proxy-Connection: keep-alive" -H "User-Agent: $ua" -H "X-Requested-With: XMLHttpRequest" -H "Accept: */*" -H "Cookie: $ck" -H "Referer: http://$rw/fast_reada/read" -H "Accept-Encoding: gunzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7" -s
if [ $(grep -c '"jkey"' fqfrdr.txt) -eq 1 -a $(grep -c "oauth2" fqfrdr.txt) -eq 1 ]
then echo $(cat fqfrdr.txt | grep -o "jkey.*" | cut -d '"' -f3) > jkey.txt
echo $(cat fqfrdr.txt | grep -o "appid.*" | cut -d '&' -f1 | cut -d '=' -f2) > ja.txt
echo $(cat fqfrdr.txt | grep -o "uri.*" | cut -d "%" -f4 | cut -c 3-) > ju.txt
echo $(cat fqfrdr.txt | grep -o "%3D.*" | cut -d '&' -f1 | cut -c 4-) > ji.txt
echo $(cat fqfrdr.txt | grep -o "state.*" | cut -d '&' -f1 | cut -d '=' -f2) > js.txt
else rm -rf jkey.txt ja.txt ju.txt ji.txt js.txt
fi
