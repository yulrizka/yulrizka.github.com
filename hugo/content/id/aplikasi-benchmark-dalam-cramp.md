---
layout: post
title: "Aplikasi Benchmark dalam Cramp"
date: 2012-03-05 19:56
language: id
comments: true
tags: ruby
description: Pengembangan aplikasi benchmark dengan cramp
keywords: benchmark, cramp
published: false
---
[Cramp][cramp] adalah web framework dalam bahasa ruby yang dibuat diatas library [EventMachine][em](EM). EM adalah event-processing library
dalam bahasa pemrograman ruby. Lebih lanjut mengenai event-processing dalam ruby dapat dilihat dalam [artikel ini][em-info].

dalam artikel ini, saya akan mencoba melakukan explorasi untuk membuat aplikasi sederhana dalam cramp. Aplikasi yang akan dibuat adalah
aplikasi yang mencatat pengeluaran. Data yang disimpan cukup deskripsi dan jumlah pengeluaran tersebut.

Dokumentasi cramp yang lebih lengkap dapat dilihat [disini][cramp-doc]

## Instalasi Cramp ##

Untuk melakukan instalasi kita cukup menambahkan gem cramp.

```bash
  gem install cramp
  cramp new expense_cramp
  bundle install
  
      create
      create  config.ru
      create  Gemfile
      create  application.rb
      create  public
      create  public/javascripts
      create  config
      create  config/routes.rb
      create  app/actions
      create  app/actions/home_action.rb
````

Perintah tersebut akan membuat suatu direktori berisikan file-file default dalam program cramp

## 3..2..1 Action ##
Pada Ruby on Rails, kita mengenal model MVC (Model, Viewer, Controller). Dalam suatu controller berisi beberapa action CRUD. Cramp tidak mengenal
controller. yang ada hanya action. Tiap action dibuat dengan meng-inherit Cramp::Action. Tiap request dari user akan di mapping (ditangani) oleh
Action ini.

Tiap response yang ditangani oleh action melewati beberapa tahapan (lifecycle). Kita dapat menyisipkan kode pada tiap tahapan tersebut dengan
callback yang disedikan. Tahapan tersebut adalah



[em]: http://rubyeventmachine.com/
[cramp]: http://cramp.in
[em-info]: http://www.engineyard.com/blog/2011/what-are-events-why-might-you-care-and-how-can-eventmachine-help/
[cramp-doc]: http://cramp.in/documentation
