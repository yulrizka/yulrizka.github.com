---
layout: post
title: "repeat content of text x time"
date: 2016-08-15T00:00:00+02:00
language: en
comments: true
tags: til unix cli
description: repeat content of text x time
keywords: unix 
---

I have a use-case where 1 have single file that contain 20K line. I need to have another file with 1 million line with just content of the first file repeated 50 time.

Solution: form [stack overflow](http://askubuntu.com/questions/521465/how-can-i-repeat-the-content-of-a-file-n-times)
```
$ perl -0777pe '$_=$_ x 50' input_file.txt > output_file.txt
```

arguments:


* 0777 : -0 sets sets the input record separator (perl special variable $/ which is a newline by default). Setting this to a value greater than 0400 will cause Perl to slurp the entire input file into memory.
* pe : the -p means "print each input line after applying the script given by -e to it".
* $_=$_ x 50 : $_ is the current input line. Since we're reading the entire file at once because of -0700, this means the entire file. The x 50 will result in 50 copies of the entire file being printed.




