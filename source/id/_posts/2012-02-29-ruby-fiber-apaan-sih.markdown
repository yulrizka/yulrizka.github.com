---
layout: post
title: "Ruby Fiber apaan sih ?"
date: 2012-02-29 15:17
language: id
comments: true
tags: [ruby]
description: Artikel ini membahas penjelasan mengenai ruby fiber dan ruby thread. Fiber yang digunakan pada ruby 1.9
keywords: fiber, ruby, thread, green thread
---
<blockquote>
  <p>
    Fibers are light-weight (green) <a href="http://en.wikipedia.org/wiki/Thread_(computing)" alt="wiki Thread (Computing)">
      threads</a> with manual, cooperative scheduling, rather than the preemptive scheduling
    of Ruby 1.8's threads. Since Ruby 1.9's threads exist at the system level, fibers are, in a way,
    Ruby 1.9's answer to Ruby 1.8's green threads, but lacking the pre-emptive scheduling
  </p>
  <small>
    <a href="http://www.rubyinside.com/ruby-fibers-8-useful-reads-on-rubys-new-concurrency-feature-1769.html">
      rubyinside.com
    </a>
  </small>
</blockquote>

<h2>Thread</h2>
Untuk dapat mengerti mengenai fiber, sebelumnya kita harus memahami thread. Suatu (*instance*) program yang sedang berjalan
disebut dengan proses. thread adalah unit proses (potongan kode) yang dapat dijalankan secara simultan. Jadi sekan-akan
program tersebut bercabang.

Ambil contoh program Web Server yang diimplementasi menggunakan thread. Fungsi Web Server (WS) adalah menerima request dan
memberikan response kepada web browser. Misalkan WS tersebut hanya memiliki 1 proses, maka apabila ada 10 user yang melakukan
request, maka mereka harus mengantri untuk menerima response dari server. Hal ini bisa diatasi salah satunya dengan menggunakan
thread. Apabila terdapat suatu request, maka proses utama membuat (*spawn*) suatu thread untuk menangani request tersebut.
Misalkan ada 10 request disaat yang bersamaan, maka terdapat 10 thread yang jalan disaat yang bersamaan. Dalam kasus ini
maka 10 user tersebut akan dilayani pada waktu yang bersamaan.

Ruby 1.8.7 (MRI) memiliki tipe *green thread*, yaitu thread yang dikelola oleh *Virtual Machine* sedangkan normalnya thread
dikelola oleh *Operating System* (OS) atau *native thread*. Namun implementasi threads untuk tiap interpreter berbeda. Misalkan
pada JRuby dan Rubinius yang menggunakan native threads.

Eksekusi setiap threads dikelola oleh program yang dinamakan *scheduler*. *preemptive scheduling* adalah suatu metode
yang digunakan *scheduler* dengan memanfaatkan *interrupt*. Artinya scheduler mengirimkan *interrupt* kepada suatu thread
untuk berhenti dan menjalankan thread lain. secara default MRI menggunakan *fair scheduler*. Artinya masing-masing thread
akan dijadwalkan (dijalankan) dengan waktu yang sama.

<h2>Fiber</h2>
Fiber adalah fitur yang pertamakali diperkenalkan pada ruby 1.9 (Meskipun ada hack untuk ruby 1.8.{67}).
Fiber mirip dengan thread. Namun pada fiber, user yang memiliki kontrol terhadap eksekusi kode, bukan *scheduler*.
setiap fiber memiliki 4Kb memori sehingga cukup "murah" untuk dibuat. Berikut adalah contoh dari (igvita.com).

Terdapat 2 thread: Thread pertama melakukan io-blocking selama 40ms dan komputasi 10ms. sedangkan
thread kedua melakukan 50ms komputasi.

Berikut adalah implementasi dalam thread dan juga fiber:
<div class="thumbnail">
  <img src="http://www.igvita.com/posts/09/fibers-vs-threads.png"></img>
  <div class="caption">
    Komparasi kode yang dijalankan menggunakan thread &nbsp; fiber.
    <a href="http://www.igvita.com/2009/05/13/fibers-cooperative-scheduling-in-ruby/">http://www.igvita.com/2009/05/13/fibers-cooperative-scheduling-in-ruby/</a>
  </div>
</div><br/>

Pada contoh pertama, thread 2 memakan waktu 100ms, sedangkan pada contoh yang kedua hanya memakan waktu 60ms.

Dengan menggunakan fiber, program berjalan sekan-akan sychronous (blocking). Oleh karena itu fiber
merupakan kandidat yang cocok untuk diterapkan pada pemograman *Event-Driven* atau *Asynchronous programming* seperti
pada *EventMachine* di ruby

<h2>Cara Menggunakan Fiber</h2>
Untuk dapat memahami fiber, kita ambil contoh seperti berikut. Program ini sebenarnya tidak berguna, tapi cukup untuk
mendemonstrasikan alur penggunaan fiber

```ruby
  fiber = Fiber.new do
    puts "Fiber: Beginning of fiber"
    Fiber.yield # kembalikan eksekusi ke main (line 11)
    puts "Fiber: Halo main, saya fiber"
    Fiber.yield # kembalikan eksekusi ke main (line 13)
    Fiber.yield "Fiber: Sekarang #{Time.now.to_s}"
  end

  puts "Main: Beginning main"
  fiber.resume # jalankan fiber (line 2)
  puts "Main: Hello saya main thread"
  fiber.resume # jalankan fiber (line 4)
  puts "Main: Sekarang jam berapa ya ?"
  puts fiber.resume # jalankan fiber (line 6) dan output hasil
```
<pre>
     Main: Beginning main
     Fiber: Beginning of fiber
     Main: Hello saya main thread
     Fiber: Halo main, saya fiber
     Main: Sekarang jam berapa ya ?
     Fiber: Sekarang 2012-02-29 22:45:08 +0700
</pre>
