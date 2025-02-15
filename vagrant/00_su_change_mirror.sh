echo "Changing sources.list to local mirror"

if [ -z "$LOCAL_MIRROR_SUBDOMAIN" ]; then 
  echo "No local mirror subdomain given, not changing sources.list"
  exit 0
fi

cp /etc/apt/sources.list /etc/apt/sources.list.bak


sed -i \
       -e "s#http://archive#http://${LOCAL_MIRROR_SUBDOMAIN}.archive#" \
       /etc/apt/sources.list


diff -y /etc/apt/sources.list /etc/apt/sources.list.bak || true


