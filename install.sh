#!/bin/bash

tmpdir=$(mktemp -d);
#uri="http://mirror.tcpdiag.net/apache/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz";
uri="http://192.168.122.1/kafka_2.9.2-0.8.1.1.tgz";
ext=${uri##*.};
file=${uri##*/};
dir=${file%*.$ext};
deployloc="/usr/local/share";
sbinloc="/usr/local/sbin";

cd $tmpdir;
wget -O $tmpdir/$file $uri;
#wget https://dist.apache.org/repos/dist/release/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz.asc
#wget https://dist.apache.org/repos/dist/release/kafka/0.8.1.1/kafka_2.9.2-0.8.1.1.tgz.md5
#wget http://svn.apache.org/repos/asf/kafka/KEYS
#cd /usr/local/share;
tar zxf $tmpdir/$file -C $deployloc
ln -s $deployloc/$dir $deployloc/kafka
#cd ../sbin
for pname in $(ls $deployloc/kafka/bin/*.sh)
do
#  echo $pname;
#  echo $sbinloc/${pname##*/}
  ln -s $pname $sbinloc/${pname##*/};
  echo "file "$pname" deployed";
done
rm -rf $tmpdir;
