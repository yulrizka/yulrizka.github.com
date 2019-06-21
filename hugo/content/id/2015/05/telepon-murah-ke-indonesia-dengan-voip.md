---
layout: post
title: "Telepon murah ke Indonesia dengan voip"
date: 2015-05-03 13:08
language: id
comments: true
tags: web
description: Telepon murah ke indonesia melalui internet
keywords: voip indonesia, voip, telepon murah
---

>> *Disclaimer: Tulias ini berisi pengalaman penulis menggunakan VoIP dari belanda. Hasilnya mungkin berbeda
dengan yang anda peroleh. Penulis tidak bertanggung jawab atas kerugian yang ditimbulkan apabila pembaca
memutuskan untuk menggunakan VoIP*

<div class="thumbnail" align="center">
  <img src="http://blog.allstream.com/wp-content/uploads/2013/05/3822639-xsmall.jpg"/>
</div>

Buat rekan-rekan yang sedang belajar atau bekerja di Belanda, terkadang kita rindu sanak saudra.
Sebenarnya banyak cara untuk dapat berbincang dengan keluarga di Indonesia dengan mudah

Servis gratis misalkan:

* [Skype](http://www.skype.com/en/)
* [Google Hangouts](http://www.google.com/+/learnmore/hangouts/)
* [Whatsapp calling](http://www.whatsapp.com/faq/en/android/28000016)

Namun kadang-kadang berkomunikasi dengan aplikasi diatas kadang sulit. hal ini bisa dikarenakan:

* Tidak ada koneksi internet, atau koneksi yang kurang baik. Sehingga telepon kadang terputus, atau yang ditelepon mejadi suka berbahasa robot
* Tidak ada perangkat komputer atau telepon selurer yang dapat *diinstall* aplikasi diatas
* Orang yang dituju kadang sedang berada di luar (rumah / kantor) sehingga tidak memiliki akses wifi/internet atau komputer

Terdapat beberapa alternatif untuk kita dapat menelefon dengan murah ke nomor telepon di Indonesia.

Contohnya provider selular [Lebara](http://www.lebara.nl/prepaid/rates) saat ini tarifnya
**19ct/menit** untuk landline dan **29ct/menit** untuk mobile. Tapi karena untuk lebara beli 10 dapat 20 euro
maka praktis harganya menjadi setengahnya. Saya sendiri belum pernah melefon pakai lebara
sehingga saya tidak bisa mengatakan mengenai kualitas dan delay bila menelpon pakai lebara.

Nah ada cara lain untuk lebih berhemat sampai **3ct/menit** !!
Syaratnya teman-teman hanya butuh akses internet dan device yang mendukung VoIP (komputer, smart phone).
Selain Menelepon kita juga dapat mengirimkan pesan singkat melalui SMS ke nomor Indonesia.
Namun ada kekuranganna juga, kadang terdapat delay sekitar 1-2 detik tergantung dari kualitas jaringan VoIP tersebut.

## Bagaimana caranya ?

Tergantung perangkat yang teman-teman miliki disini.

**PENTING**. Pada saat register nanti pastikan provider VoIP yang kita pilih mendukung SIP.

Kita cukup register ke salah satu provider VoIP dan install aplikasi.

Setelah register account ke salah satu VoIP provider, anda akan menerima informasi contohnya;

```
sip gateway: sip.webcalldirect.com
username: foo
password: secret
```

Informasi ini yang dibutuhkan aplikasi untuk dapat terkoneksi dengan provider tersebut.

### Android

Saya pakai aplikasi [zoiper](https://play.google.com/store/apps/details?id=com.zoiper.android.app&hl=en).
Instalasinya juga cukup mudah.
Anda tinggal memasukkan data account ke aplikasi zoiper dan bisa tinggal langsung menelepon ke indonesia dengan VOIP.

**PENTING** pastikan ketika menelepon anda menggunakan aplikasi tersebut, bukan applikasi telepon android.
Bila tidak maka anda akan menggunakan pulsa telepon biasa.

### Mac

Terdapat aplikasi [Telephone](https://itunes.apple.com/en/app/telephone/id406825478?mt=12) yang penggunaanya juga mudah.
Serupa dengan android, kita hanya perlu memasukkan informasi yang di dapat dari provider ke aplikasi tersebut.

### Platform lainnya

Windows, linux, iOS (iPhone).

Berhubung saya jarang menelepon dengan device yang menggunakan sistem operasi diatas jadi saya kurang faham juga :)

Di website providernya kadang terdapat bagian 'Download' dimana anda bisa langsung mengguakan aplikasi dari mereka:
contohnya [seperti ini](http://www.dialcheap.com/download/desktop)

Tapi caranya pasti sama mudahnya. Kita tinggal *googling* dengan keywords "[windows/linux/iPhone] SIP client" anda pasti menemukan
banyak aplikasi dan tutorial yang cukup mudah.

## Registrasi Account VoIP & Pembelian Credit.

Saat ini banyak sekali provider VoIP yang tersedia di Internet. Untuk pembelian credit mereka juga sudah mendukung berbagai metode pembayaran:

* iDeal
* paypal
* kartu kredit
* DSB

Nah, barusan saya membuat *script* sederhana untuk melakukan *scraping*  provider mana yang paling murah.

*script* ?? *scraping* ?? :) no worries, yang penting adalah berikut hasil excel sheet provider dan tarif mereka per **5 mei 2015**


[voip-list-03052015.xlsx](/files/voip-list-03052015.xlsx)

Dari file ditatas kita bisa melihat tarif land-line, tarif selular berdasarkan provider dan negara yang dituju. Pastikan melihat kolom **rate + vat**.

Saat ini provider yang paling murah telepon ke Indonesia adalah:

* [dialcheap.com](http://www.dialcheap.com/rates/calling-rates) mobile: 2.9ct/menit, landline: 1.1ct/menit
* [freevoipdial.com](http://www.freevoipdeal.com/calling_rates/) mobile: 3ct/menit,  landline: 2.5ct/menit
* [voipmash.com](http://www.voipsmash.com/rates/calling-rates) mobile: 3.1ct/menit, landline: 1.1ct/menit
* [discountcalling.com](http://www.discountcalling.com/rates/calling-rates) mobile: 4ct/menit, landline: 1.1ct/menit

Setelah Register dan mendownload aplikasi dari mereka, anda tinggal memasukan data gateway, username password dan lansung menelepon nomor indonesia

Selamat menikmati :)
