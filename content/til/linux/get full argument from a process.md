---
layout: post
title: "get full argument from a process"
date: 2017-12-05T00:00:00+02:00
language: en
comments: true
tags: til linux
description: get full argument from a process
keywords: linux cli
---

We can find it out by using `ps`. For example

```
$ ps aux  | grep cassandra
...
cassand+ 24615 40.5 41.9 12064088 5033964 ?    SLl  14:28   5:15 java -ea -javaagent:/usr/share/cassandra/lib/jamm-0.3.0.jar -XX:+CMSClassUnloadingEnabled -XX:+UseThreadPriorities -XX:ThreadPriorityPolicy=42 -Xms4096M -Xmx4096M -Xmn1024M -XX:+PreserveFramePointer -Xss256k -XX:StringTableSize=1000003 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:SurvivorRatio=2 -XX:MaxTenuringThreshold=15 -XX:CMSInitiatingOccupancyFraction=25 -XX:+UseCMSInitiatingOccupancyOnly -XX:+UseTLAB -XX:CompileCommandFile=/etc/cassandra/hotspot_compiler -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -XX:+UnlockDiagnosticVMOptions -XX:-UseBiasedLocking -XX:+UseGCTaskAffinity -XX:+BindGCTaskThreadsToCPUs -XX:ConcGCThreads=16 -XX:ParallelGCThreads=16 -XX:ParGCCardsPerStrideChunk=4096 -XX:+ParallelRefProcEnabled -XX:CMSMaxAbortablePrecleanTime=60000 -XX:CMSWaitDuration=30000 -XX:+AlwaysPreTouch -XX:+UseTLAB -XX:+ResizeTLAB -Dcassandra.max_local_pause_in_ms=40000 -XX:+CMSParallelInitialMarkEnabled -XX:+CMSEdenChunksRecordAlways -XX:+UseCondCardMark -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime -XX:+PrintPromotionFailure -XX:PrintFLSStatistics=1 -XX:+PrintAdaptiveSizePolicy -XX:+PrintSafepointStatistics -XX:+PrintClassHistogramBeforeFullGC -XX:+PrintClassHistogramAfterFullGC -Xloggc:/var/log/cassandra/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=50M -Djava.net.preferIPv4Stack=true -Dcom.sun.management.jmxremote.port=7199 -Dcom.sun.management.jmxremote.rmi.port=7199 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -javaagent:/usr/lib/jolokia/jolokia-jvm.jar=port=8089,host=0.0.0.0 -Dcassandra.metricsReporterConfigFile=/etc/cassandra/graphite.yaml -Dlogback.configurationFile=logback.xml -Dcassandra.logdir=/var/log/cassandra -Dcassandra.storagedir=/var/lib/cassandra -Dcassandra-pidfile=/var/run/cassandra/cassandra.pid -cp /etc/cassandra:/usr/share/cassandra/lib/airline-0.6.jar:/usr/share/cassandra/lib/antlr-runtime-3.5.2.jar:/usr/share/cassandra/lib/asm-5.0.4.jar:/usr/share/cassandra/lib/cassandra-driver-core-3.0.1-shaded.jar:/usr/share/cassandra/lib/commons-cli-1.1.jar:/usr/share/cassandra/lib/commons-codec-1.2.jar:/usr/share/cassandra/lib/commons-lang3-3.1.jar:/usr/share/cassandra/lib/commons-math3-3.2.jar:/usr/share/cassandra/lib/compress-lzf-0.8.4.jar:/usr/share/cassandra/lib/concurrentlinkedhashmap-lru-1.4.jar:/usr/share/cassandra/lib/disruptor-3.0.1.jar:/usr/share/cassandra/lib/ecj-4.4.2.jar:/usr/share/cassandra/lib/guava-18.0.jar:/usr/share/cassandra/lib/high-scale-lib-1.0.6.jar:/usr/share/cassandra/lib/jackson-core-asl-1.9.2.jar:/usr/share/cassandra/lib/jackson-mapper-asl-1.9.2.jar:/usr/share/cassandra/lib/jamm-0.3.0.jar:/usr/share/cassandra/lib/javax.inject.jar:/usr/share/cassandra/lib/jbcrypt-0.3m.jar:/usr/share/cassandra/lib/jcl-over-slf4j-1.7.7.jar:/usr/share/cassandra/lib/jna-4.4.0.jar:/usr/share/cassandra/lib/joda-time-2.4.jar:/usr/share/cassandra/lib/json-simple-1.1.jar:/usr/share/cassandra/lib/jstackjunit-0.0.1.jar:/usr/share/cassandra/lib/libthrift-0.9.2.jar:/usr/share/cassandra/lib/log4j-over-slf4j-1.7.7.jar:/usr/share/cassandra/lib/logback-classic-1.1.3.jar:/usr/share/cassandra/lib/logback-core-1.1.3.jar:/usr/share/cassandra/lib/lz4-1.3.0.jar:/usr/share/cassandra/lib/metrics-core-3.1.0.jar:/usr/share/cassandra/lib/metrics-graphite-3.1.0.jar:/usr/share/cassandra/lib/metrics-jvm-3.1.0.jar:/usr/share/cassandra/lib/metrics-logback-3.1.0.jar:/usr/share/cassandra/lib/netty-all-4.0.44.Final.jar:/usr/share/cassandra/lib/ohc-core-0.4.3.jar:/usr/share/cassandra/lib/ohc-core-j8-0.4.3.jar:/usr/share/cassandra/lib/reporter-config3-3.0.0.jar:/usr/share/cassandra/lib/reporter-config-base-3.0.0.jar:/usr/share/cassandra/lib/sigar-1.6.4.jar:/usr/share/cassandra/lib/slf4j-api-1.7.7.jar:/usr/share/cassandra/lib/snakeyaml-1.11.jar:/usr/share/cassandra/lib/snappy-java-1.1.1.7.jar:/usr/share/cassandra/lib/ST4-4.0.8.jar:/usr/share/cassandra/lib/stream-2.5.2.jar:/usr/share/cassandra/lib/thrift-server-0.3.7.jar:/usr/share/cassandra/apache-
...
```

The output is truncated. This is the same if you cat `/proc/[pid]/cmdline`

According to [http://praveen.kumar.in/2010/02/24/getting-untruncated-command-line-options-passed-to-a-solaris-process/](this) (at least for solaris) the kernel only keep up until certain lenght.

some tool can read into memory of the program to get the ARGS value. 

for linux we can use `ps eww -p <PID>` 

```
root@cass001:/proc/5367# ps eww -p 24615
  PID TTY      STAT   TIME COMMAND
24615 ?        SLl   10:00 java -ea -javaagent:/usr/share/cassandra/lib/jamm-0.3.0.jar -XX:+CMSClassUnloadingEnabled -XX:+UseThreadPriorities -XX:ThreadPriorityPolicy=42 -Xms4096M -Xmx4096M -Xmn1024M -XX:+PreserveFramePointer -Xss256k -XX:StringTableSize=1000003 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:SurvivorRatio=2 -XX:MaxTenuringThreshold=15 -XX:CMSInitiatingOccupancyFraction=25 -XX:+UseCMSInitiatingOccupancyOnly -XX:+UseTLAB -XX:CompileCommandFile=/etc/cassandra/hotspot_compiler -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark -XX:+UnlockDiagnosticVMOptions -XX:-UseBiasedLocking -XX:+UseGCTaskAffinity -XX:+BindGCTaskThreadsToCPUs -XX:ConcGCThreads=16 -XX:ParallelGCThreads=16 -XX:ParGCCardsPerStrideChunk=4096 -XX:+ParallelRefProcEnabled -XX:CMSMaxAbortablePrecleanTime=60000 -XX:CMSWaitDuration=30000 -XX:+AlwaysPreTouch -XX:+UseTLAB -XX:+ResizeTLAB -Dcassandra.max_local_pause_in_ms=40000 -XX:+CMSParallelInitialMarkEnabled -XX:+CMSEdenChunksRecordAlways -XX:+UseCondCardMark -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -XX:+PrintGCApplicationStoppedTime -XX:+PrintPromotionFailure -XX:PrintFLSStatistics=1 -XX:+PrintAdaptiveSizePolicy -XX:+PrintSafepointStatistics -XX:+PrintClassHistogramBeforeFullGC -XX:+PrintClassHistogramAfterFullGC -Xloggc:/var/log/cassandra/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=50M -Djava.net.preferIPv4Stack=true -Dcom.sun.management.jmxremote.port=7199 -Dcom.sun.management.jmxremote.rmi.port=7199 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -javaagent:/usr/lib/jolokia/jolokia-jvm.jar=port=8089,host=0.0.0.0 -Dcassandra.metricsReporterConfigFile=/etc/cassandra/graphite.yaml -Dlogback.configurationFile=logback.xml -Dcassandra.logdir=/var/log/cassandra -Dcassandra.storagedir=/var/lib/cassandra -Dcassandra-pidfile=/var/run/cassandra/cassandra.pid -cp /etc/cassandra:/usr/share/cassandra/lib/airline-0.6.jar:/usr/share/cassandra/lib/antlr-runtime-3.5.2.jar:/usr/share/cassandra/lib/asm-5.0.4.jar:/usr/share/cassandra/lib/cassandra-driver-core-3.0.1-shaded.jar:/usr/share/cassandra/lib/commons-cli-1.1.jar:/usr/share/cassandra/lib/commons-codec-1.2.jar:/usr/share/cassandra/lib/commons-lang3-3.1.jar:/usr/share/cassandra/lib/commons-math3-3.2.jar:/usr/share/cassandra/lib/compress-lzf-0.8.4.jar:/usr/share/cassandra/lib/concurrentlinkedhashmap-lru-1.4.jar:/usr/share/cassandra/lib/disruptor-3.0.1.jar:/usr/share/cassandra/lib/ecj-4.4.2.jar:/usr/share/cassandra/lib/guava-18.0.jar:/usr/share/cassandra/lib/high-scale-lib-1.0.6.jar:/usr/share/cassandra/lib/jackson-core-asl-1.9.2.jar:/usr/share/cassandra/lib/jackson-mapper-asl-1.9.2.jar:/usr/share/cassandra/lib/jamm-0.3.0.jar:/usr/share/cassandra/lib/javax.inject.jar:/usr/share/cassandra/lib/jbcrypt-0.3m.jar:/usr/share/cassandra/lib/jcl-over-slf4j-1.7.7.jar:/usr/share/cassandra/lib/jna-4.4.0.jar:/usr/share/cassandra/lib/joda-time-2.4.jar:/usr/share/cassandra/lib/json-simple-1.1.jar:/usr/share/cassandra/lib/jstackjunit-0.0.1.jar:/usr/share/cassandra/lib/libthrift-0.9.2.jar:/usr/share/cassandra/lib/log4j-over-slf4j-1.7.7.jar:/usr/share/cassandra/lib/logback-classic-1.1.3.jar:/usr/share/cassandra/lib/logback-core-1.1.3.jar:/usr/share/cassandra/lib/lz4-1.3.0.jar:/usr/share/cassandra/lib/metrics-core-3.1.0.jar:/usr/share/cassandra/lib/metrics-graphite-3.1.0.jar:/usr/share/cassandra/lib/metrics-jvm-3.1.0.jar:/usr/share/cassandra/lib/metrics-logback-3.1.0.jar:/usr/share/cassandra/lib/netty-all-4.0.44.Final.jar:/usr/share/cassandra/lib/ohc-core-0.4.3.jar:/usr/share/cassandra/lib/ohc-core-j8-0.4.3.jar:/usr/share/cassandra/lib/reporter-config3-3.0.0.jar:/usr/share/cassandra/lib/reporter-config-base-3.0.0.jar:/usr/share/cassandra/lib/sigar-1.6.4.jar:/usr/share/cassandra/lib/slf4j-api-1.7.7.jar:/usr/share/cassandra/lib/snakeyaml-1.11.jar:/usr/share/cassandra/lib/snappy-java-1.1.1.7.jar:/usr/share/cassandra/lib/ST4-4.0.8.jar:/usr/share/cassandra/lib/stream-2.5.2.jar:/usr/share/cassandra/lib/thrift-server-0.3.7.jar:/usr/share/cassandra/apache- TERM=xterm-256color SHELL=/bin/bash USER=root LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36: SUDO_USER=root SUDO_UID=0 MALLOC_ARENA_MAX=4 USERNAME=root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin MAIL=/var/mail/root PWD=/ LANG=en_US.UTF-8 HOME=/var/lib/cassandra SUDO_COMMAND=/etc/init.d/cassandra restart SHLVL=1 LOGNAME=root SUDO_GID=0
```