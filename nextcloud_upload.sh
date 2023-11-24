SERVER=$1
USER=$2
PASSWORD=$3
LOCALPATH=$4
REMOTEPATH=$5
for d in */; do
	echo $d;
	REMOTE="$REMOTEPATH/$d"
	curl 'https://$SERVER/remote.php/dav/files/$USER/$REMOTE' \
        	--user $USER:$PASSWORD \
        	--request MKCOL https://$SERVER/remote.php/dav/files/$USER/$REMOTE
done;

for f in $(find . -not -path "./.git/*"); do
	LOCAL=$(readlink -f $f)
	REMOTE="$REMOTEPATH${f:1}"
	echo $LOCAL
	curl 'https://$SERVER/remote.php/dav/files/$USER/$REMOTE' \
        	--user $USER:$PASSWORD \
        	--request PUT https://$SERVER/remote.php/dav/files/$SERVER/$REMOTE \
                --data @$LOCALPATH
done;
