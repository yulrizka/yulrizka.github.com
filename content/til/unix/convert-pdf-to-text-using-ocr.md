---
layout: post
title: "Convert PDF to Text Using OCR"
date: 2020-05-05T15:23:46+02:00
language: en
comments: true
tags:  til unix
description: Converting PDF document to text using OCR
keywords: pdf ocr conversion
draft: false
---
make sure you have imagemagick and tesseract are installed
```
$ sudo apt install imagemagick tesseract-ocr
```

It's a 2 step process:

1. Convert PDF to .tiff using `convert` from imagemagick
```
$ convert -density 300 input.pdf -depth 8 output.tiff
```
2. convert .tiff to text using `tesseract`  
  generate `out.txt`
```
$  tesseract output.tiff out 
```



