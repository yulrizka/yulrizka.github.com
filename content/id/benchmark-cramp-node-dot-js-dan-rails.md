---
layout: post
title: "Benchmark cramp, node.js dan rails"
date: 2012-03-01 15:02
lang: id
comments: true
tags : 
  - ruby
description: Benchmark API yang diimplementasi dalam Cramp, Node.js dan Rails
published: false
---
Bagi yang sering men-*develop* aplikasi rails, terkadang muncul kebutuhan untuk mengimplementasi API untuk memberikan akses terhadap data
pada aplikasi tersebut. Ada yang mengimplementasi API dengan framework yang sama (rails), namun ada juga yang menggunakan platform yang
berbeda untuk mengimplementasi API tersebut. Ada yang menggunakan node.js, sinatra, cramp dlll.

Baru-baru ini ada diskusi yang menarik pada milis [#id-ruby][idruby] mengenai cramp. Nah untuk mencari tahu bagaimana performa masing-masing
aplikasi tersebut saya kepikiran untuk melakukan benchmark (pengukuran) mengenai kinerja dan performa dari masing-masing framework. Aspek yang
ingin saya ukur terutama adalah kecepatan response yang dihasilkan masing-masing framework. Baik saat tanpa proses IO, dengan proses IO maupun
dengan melakukan operasi terhadap database (Select, Insert, update Dan delete).

Masing-masing implementasi akan saya buat di posting yang berbeda. Sedangkan untuk melakukan pengujian, saya akan mempush masing-masing aplikasi
ke [heroku.com][heroku] dan melakukan pengujian dengan [blitz.io][blitz.io]. Heroku adalah Platform yang bisa menjalankan aplikasi berbasis Ruby,
Php java dll. Sedangkan blitz.io adalah service yang melakukan load testing &nbsp; benchmark terhadap aplikasi web.
Keduanya berjalan pada infrastruktur Amazon AWS sehingga seharusnya tidak delay network yang berarti.

Aplikasi yang akan dibuat sebenarnya cukup sederhana. Sebuah aplikasi yang melakukan pencatatan terhadap *expense*. Aplikasi ini hanya melakukan
operasi CRUD seperti biasa. Setelah masing-masing aplikasi ini dibuat, barulah akan dilakukan pengujian. Masing-masing pengerjaan pada aplikasi
tersebut nanti akan buat dalam 3 artikel yang berbeda :

* [Aplikasi Benchmark dalam Cramp][benchmark_cramp]
* Aplikasi Benchmark dalam Node.js
* Aplikasi Benchmark dalam Rails

Setelah dilakukan pengukuran, maka saya akan mengupdate artikel ini.

[idruby]: http://id-ruby.org/
[blitz.io]: http://blitz.io
[benchmark_cramp]: /id/2012/03/aplikasi-benchmark-dalam-cramp.html
