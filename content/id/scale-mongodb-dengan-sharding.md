---
layout: post
title: "Scale MongoDB dengan Sharding"
date: 2012-03-07 12:16
language: id
comments: true
tags: ruby, web
description: Introduksi, pengertian dan explorasi s-0t5caling MongoDB instance dengan melakukan partisi secara horizontal atau yang lebih dikenal dengan sharding.
keywords: mongodb, sharding, horizontal partitioning
---
<div class="alert alert-success">
  <span class="label label-success" >TL;DR</span>
  Proses <em>Horizontal Partitioning</em> pada MongoDB melibatkan suatu konsep <em>Chunk</em> dimana data dibagi menjadi beberapa chunk sesuai dengan suatu
  <em>shard key</em>. Artikel ini membahas bagaimana melakukan sharding pada mongodb
</div>

## Introduksi ##
MongoDB adalah salah satu NoSQL database yang cukup populer. MongoDB merupakan document store database, dimana data disimpan dalam format
BSON atau mirip dengan JSON. Keunggulan mongoDB antara lain adalah automatic sharding. Artinya apabila kita memiliki beberapa server database,
kita dapat melakukan partisi terhadap data tersebut dan mongo akan melakukan load balancing terhadap data tersebut secara automatis

Sebelum mengeksplorasi mongodb, ada beberapa konsep yang harus kita pahami tentang mongo. yaitu:

* Mongod
* Replicas
* Shards
* Shard Keys
* Chunks
* Config DB Process (config server)
* Routing Process (mongos)

<div class="row">
  <a href="https://www.mongodb.org/display/DOCS/Sharding+Introduction" class="thumbnail span7 offset2">
    <img src="https://www.mongodb.org/download/attachments/2097393/sharding.PNG?version=2&nbsp;modificationDate=1267724627656"/>
    <h5>Skema Sharding - MongoDB Sharding Introduction</h5>
  </a>
</div>

### mongod ###
mongod adalah core dari mongoDB. mongod adalah satu instance server mongo. Saya sendiri tidak tau kepanjangan dari mongod tapi kalau menebak,
mungkin yang dimaksud adalah mongo daemon. Kalau di analogikan, 1 mongod adalah 1 server database (misalkan sama dengan 1 server mysql). Sehingga
satu aplikasi sedehana cukup dibuat dengan 1 application server yang berkomunikasi dengan 1 mongod

### Replica ###
Replica set adalah suatu bentuk Master/slave database. 1 replika terdiri dari 2 atau lebih proses mongod yang memiliki data yang sama.
Replica bertujuan untuk *failover*, *reducancy* juga sebagai *distribution read load*
. Artinya apabila terdapat beberapa request read terhadap data yang sama, maka request tersebut bisa di handle oleh lebih dari satu server

Contoh, misalkan kita mempunyai 3 data center: Jakarta, Bandung dan Surabaya. maka kita dapat membentuk replika sebagai berikut.
<div class="row">
  <div style="text-align: center">
    <table class="table table-striped table-bordered table-condensed span5">
      <thead>
        <tr>
          <td></td><td>Replica-1</td><td>Replica-2</td><td>Replica-3</td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Jakarta</td>
          <td>mongod</td>
          <td>mongod</td>
          <td>mongod</td>
        </tr>
        <tr>
          <td>Bandung</td>
          <td>mongod</td>
          <td>mongod</td>
          <td>mongod</td>
        </tr>
        <tr>
          <td>Surabaya</td>
          <td>mongod</td>
          <td>mongod</td>
          <td>mongod</td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
### Shards ###
Dalam database kita dapat melakukan partisi terhadap data. Partisi tersebut bisa dilakukan dalam dua arah: Vertikal dan Horizontal. Vertical
dilakukan dengan membagi data berdasarkan kolom, misalkan melalui proses denormalisasi. Sedangkan *horizontal partitioning* dilakukan dengan
membagi data secara horizontal.

Contoh horizontal partitioning misalkan kita memiliki data center seperti diatas. Maka kita dapat menyimpan semua data user jakarta ke data
center jakarta, bandung ke bandung dan lainya ke surabaya. Apabila terdapat request terhadap data bandung maka cukup server bandung yang melayani
data tersebut.

Shard dalam mongoDB teridiri dari beberapa server (mongod). Beberapa server tersebut dalam shard membentuk replika set. sehingga dapat kita katakan
suatu replika set berada pada suatu sharding.

### shard key ###
Untuk membagi-bagi suatu data, maka dibutuhkan suatu *key* yang menentukan data tersebut akan masuk ke shard yang mana. Key tersebut disebut dengan
**shard key**. untuk contoh diatas *shard key* adalah lokasi. Pada contoh lain kita dapat membuat email sebagai *shard key*. sehingga data suatu
user akan dikelompokkan pada suatu shard yang sama.

Pemilihan *shard key* sangat bergantung dengan bagaimana cara aplikasi berintarksi untuk mengakses data. Sehingga pemilihan *shard key* dapat
mempengaruhi performa dari sistem. Pemilihan *shard key* yang salah dapat menyebabkan database beroperasi lebih lambat dari *single instance*
database.

Untuk kriteria pemilihan *shard key* dapat dilihat pada artikel [*Choosing a shard key*][mongo-choose-shard]

### Chunks ###
*Chunk* adalah *continuous range of data for a particular collection*. Misalkan kita melakukan partisi data berdasarkan ID. dan ID tersebut
merupakan bilangan integer antara 1..1000. Kita dapat membagi data tersebut dalam beberapa bagian (chunk) dengan ukuran yang sama. Secara
default ukuran 1 *chunk* dalam mongoDB adalah 64MB (meskipun bisa dikonfigurasi). Untuk contoh kasus data tersebut bisa dibagi menjadi 10 chunk.
dengan:

* chunk-1: 1..100
* chunk-2: 101..200
* ...
* chunk-10: 901..1000

Suatu Chunk disimpan pada suatu shard tertentu. Keistimewaan mongoDB salah satunya adalah auto sharding. Artinya suatu chunk dapat di transfer
dari suatu shard ke shard yang lain.

Misalkan contoh diatas, 3 shard. Pada shard pertama terdapat 10 chunk. MongoDB akan melakukan balancing dengan melakukan transfer ke 2 shard
yang lain sampai ukuran chunk pada tiap shard menjadi seimbang. Hal ini dilakukan secara automatis, meskipun kita juga dapat melakukannya secara
manual.

### Config DB Process (Config server) ###
Selain mongod, dalam proses sharding dibutuhkan suatu prosess (program) yang bertugas untuk menyimpan informasi mengenai shard-server dan chunk
didalam shard tersebut. informasi tersebut dikenal dengan meta-data. Kita dapat menjalankan 1 atau 3 *Config Server*. Tentu pada production
dibutuhkan 3 config server. Ketika satu mati maka masih tersisa 2 cadangan *Config server*.

Tidak seperti mongod, *Config Server* tidak berkomunikasi antara satu dengan yang lain. Ketika satu proses mati, biasanya dihidupkan dengan
melakukan restore terhadap dump dari server yang lain. Ketika server ini mati.

### Routing Process (mongos) ###
Selain mongod dan *config server*, element lain yang penting adalah **mongos**. Fungsi utama dari mongos adalah melakukan routing terhadap
request ke shard yang memiliki data tersebut. Pada saat aplikasi ini dijalankan. ia akan mengambil data dari *config server*. Aplikasi yang
kita miliki berkomunikasi layaknya dengan server database biasa. Misalkan sebelumnya aplikasi kita setup ke url mongod, sekarang setelah
kita melakukan konfigurasi pada sharding, kita cukup mengarahkan url ke proses mongos.

Proses mongos ini relativ lebih kecil. Kadang kita dapat menjalankan mongos pada server aplikasi kita. Ada juga yang menjalankan proses mongos
di mesin yang sama dengan mongod.

## Implementasi ##
Ok, setelah kita mengerti beberapa konsep mengenai sharding, mari kita membuat suatu contoh kasus bagaimana melakukan implementasi terhadap
sharding berikut. Untuk kemudahan, maka semua *instance* server ktia letakkan pada server yang sama (localhost). Hal ini berlaku untuk
mongod, Config Server, mongos dan server aplikasi.

Pada contoh kasus ini kita akan menjalankan beberpa server sebagai berikut

* 2 Monogod. port 10000 & 10001
* 1 Config Server. port 20000
* 1 Mongos

### Mongod ###
Dalam kasus ini, saya berasumsi anda telah melakukan instalasi terhadap mongo server. Untuk menjalankan 2 proses mongod, jalankan perintah berikut

```bash
  $ mkdir a b
  # jalankan instance pertama
  $ mongod --shardsvr --dbpath $PWD/a --port 10000 > /tmp/sharda.log &
  $ cat /tmp/sharda.log # pastikan process tersebut berjalan
  # jalankan instance kedua
  $ mongod --shardsvr --dbpath $PWD/b --port 10001 > /tmp/shardb.log &
  $ cat /tmp/shardb.log # pastikan process tersebut berjalan
```

### Configuration Server & Mongos ###
Berikutnya yang kita lakukan adalah menjalankan Configuration server dan Mongos dengan perintah berikut

```bash
  $ mkdir config
  # start config server
  $ mongod --configsvr --dbpath $PWD/config --port 20000 > /tmp/configdb.log &
  $ cat /tmp/configdb.log # pastikan server berjalan
  # start mongos
  $ mongos --configdb localhost:20000 --chunkSize 1 > /tmp/mongos.log &
  $ cat /tmp/mongos.log # pastikan server tersebut berjalan
```

pada contoh diatas, mongos tidak membutuhkan `--dbpath`, karena mongo tidak memerlukan *persistance* (penyimpanan data). Perintah `mongos` diatas
akan menjalankan mongos pada port default (sama serperti port default mongod) yaitu 27017

`--chinkSize 1` merupakan opsi untuk menentukan ukuran chunk 1MB (defaultnya 64MB). Hal ini bertujuan untuk explorasi saja. sehingga kita tidak
perlu memassukkan data berukuran 64MB untuk membuat satu chuck baru.

## Setup Cluster ##
Sampai tahap ini yang telah kita lakukan adalah mejalankan 2 *process* mongod, 1 *process config server* dan 1 *process* mongos. Berikutnya
yang kita lakukan adalah melakukan setup agar server tersebut dapat saling berkomunikasi.

### Konfigurasi Shard Server pada mongos ###
Berikutnya yang kita lakukan adalah setup mongos agar menambahkan 2 shard server yang berjalan pada port 10000 & 10001.

```bash
$ mongo
MongoDB shell version: 1.8.2
connecting to: test
> use admin
switched to db admin
> db.runCommand( { addshard: "localhost:10000"} )
{ "shardAdded" : "shard0000", "ok" : 1 }
> db.runCommand( { addshard: "localhost:10001"} )
{ "shardAdded" : "shard0001", "ok" : 1 }
>
```

Berikutnya, kita set agar server tersebut dalam mode sharding pada database test. Setelah itu kita akan menambahkan sharding pada *collection* *people* dengan
*shard key* *email*. Meskipun pada tahap ini kita belum memiliki *people Collection*
```bash
  > db.runCommand( { enablesharding: "test" } )
  { "ok" : 1 }
  > db.runCommand( { shardcollection: "test.people", key: {email: 1} } )
  { "collectionsharded" : "test.people", "ok" : 1 }
  > use test
  > show collections
```

Oke kita cek dulu apakah ukuran chuck sudah 1 MB, apabila belum kita ubah menjadi 1 MB

<div class="alert alert-info">
  Entah mengapa parameter --chunkSize 1 tidak mengubah ukuran chunk, oleh karena itu kita ubah dari database
</div>

```bash
  > use config
  switched to db config
  > show collections
  changelog
  chunks
  collections
  databases
  lockpings
  locks
  mongos
  settings
  shards
  system.indexes
  version
  > db.settings.find()
  { "_id" : "chunksize", "value" : 64 }
  > db.settings.save({_id:"chunksize", value: 1})
  > db.settings.find()
  { "_id" : "chunksize", "value" : 1 }
  >
```

Perhatikan bahwa perintah terakhir tidak menghasilkan apa-apa karena kita memang belum memiliki collection.

Ok, sampai tahap ini kita telah selesai melakukan shard terhadap server tersebut

## Let's Play ##
Sekarang saatnya kita melakukan percobaan dengan shard dan chunk.

### Tambahkan data pada collection ###
Pertama-tama kita coba untuk menambahkan 1 collection dan melihat ukuran collection tersebut.

```bash
  > use test
  switched to db test
  > db.people.save( { name: "Person test", email: "test@foo.com" } )
  > db.people.find()
  { "_id" : ObjectId("4f5742cc580bd77a9d9ec6d6"), "email" : "test@foo.com", "name" : "Person test" }
  > db.people.dataSize()
  68
  > db.people.totalSize()
  24576
```

Dapat dilihat pada hasil diatas bahwa kita telah memasukkan 1 dokumen pada *collection* people dan untuk 1 dokumen kita memerlukan 68 byte.
Ingat bahwa pada contoh diatas, kita menetapkan ukuran 1 chunk adalah 1MB (1024 byte). Skarang kita coba untuk memasukan data sehingga ukuran
data menjadi 3 chuck

Mari kita tambahkan record (dokumen) sebanyak 20000.

```bash
  > for (var i = 1; i <= 20000; i++) {
  ...   var person_name = "Person #" + i;
  ...   var person_email = "email-" + i + "@foo.com";
  ...   db.people.save ({ name: person_name, email: person_email });
  ... }
  > db.people.totalSize()
  6776064
  > db.people.dataSize()
  1559608
  >
```

### Melihat informasi jumlah shard ###
untuk melihat informasi shard dapat kita lakukan dalam perintah berikut.

```bash
  > use admin
  switched to db admin
  > db.runCommand({ listshards: 1})
  {
  	"shards" : [
  		{
  			"_id" : "shard0000",
  			"host" : "localhost:10000"
  		},
  		{
  			"_id" : "shard0001",
  			"host" : "localhost:10001"
  		}
  	],
  	"ok" : 1
  }
```

### Melihat informasi Chunk ###
Untuk melihat informasi chunk, dan di shard mana chunk itu disimpan, lakukan perintah berikut
```bash
  > use config
  switched to db config
  > db.chunks.find()
  {
     "_id":"test.people-email_MinKey",
     "lastmod":{
        "t":2000,
        "i":0
     },
     "ns":"test.people",
     "min":{
        "email":{
           $minKey:1
        }
     },
     "max":{
        "email":"email-10000@foo.com"
     },
     "shard":"shard0001"
  }{
     "_id":"test.people-email_\"email-10000@foo.com\"",
     "lastmod":{
        "t":2000,
        "i":2
     },
     "ns":"test.people",
     "min":{
        "email":"email-10000@foo.com"
     },
     "max":{
        "email":"email-9@foo.com"
     },
     "shard":"shard0000"
  }{
     "_id":"test.people-email_\"email-9@foo.com\"",
     "lastmod":{
        "t":2000,
        "i":3
     },
     "ns":"test.people",
     "min":{
        "email":"email-9@foo.com"
     },
     "max":{
        "email":{
           $maxKey:1
        }
     },
     "shard":"shard0000"
  }
```

dari data diatas kita dapat melihat bahwa terdapat 3 chunk:

* test.people-email_MinKey berada pada shard0001
* test.people-email_\"email-10000@foo.com\" berada pada shard0000
* test.people-email_\"email-9@foo.com\" berada pada shard0000

MongoDB ternyata melakukan partisi terhadap *shard key* dengan memperlakukan key tersebut sebagai string.

### Memindahkan Chunk ke shard lain ###
Misalkan pada contoh diatas kita ingin memindahkan chunk `test.people-email_\"email-9@foo.com\" berada pada shard0000` dari shard0000 je shard0001. Hal tersebut
dapat dilakukan dengan perintah berikut

```bash
  > db.adminCommand({ moveChunk: "test.people", find: {email: "email-9@foo.com"}, to: 'shard0001'})
  { "millis" : 1038, "ok" : 1 }
  > db.chunks.find()
  {
     "_id":"test.people-email_MinKey",
     "lastmod":{
        "t":2000,
        "i":0
     },
     "ns":"test.people",
     "min":{
        "email":{
           $minKey:1
        }
     },
     "max":{
        "email":"email-10000@foo.com"
     },
     "shard":"shard0001"
  }{
     "_id":"test.people-email_\"email-10000@foo.com\"",
     "lastmod":{
        "t":3000,
        "i":1
     },
     "ns":"test.people",
     "min":{
        "email":"email-10000@foo.com"
     },
     "max":{
        "email":"email-9@foo.com"
     },
     "shard":"shard0000"
  }{
     "_id":"test.people-email_\"email-9@foo.com\"",
     "lastmod":{
        "t":3000,
        "i":0
     },
     "ns":"test.people",
     "min":{
        "email":"email-9@foo.com"
     },
     "max":{
        "email":{
           $maxKey:1
        }
     },
     "shard":"shard0001"
  }
  >
```

Dari data diatas kita bisa melihat bahwa chunk tersebut sudah pindah dari shard0000 ke sahrd00001



[mongodb]: http://www.mongodb.org/
[mongo-choose-shard]: http://www.mongodb.org/display/DOCS/Choosing+a+Shard+Key
