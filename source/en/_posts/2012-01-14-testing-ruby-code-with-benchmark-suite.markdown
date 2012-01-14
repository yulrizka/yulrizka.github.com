---
layout: post
title: "Testing ruby code with benchmark_suite"
date: 2012-01-14 12:04
language: en
comments: true
categories: ruby
---

Just a couple days ago I found out [therubygame.com][1] which challenge us to
solve a problem with ruby. The result were measured by the **fastest**, **slowest**, **shortest**, **longest**, 
**cheaters** (yup there are also some rule). 

And also I was listening to an episode of ruby rouge on [Benchmarking][2]. And there is one tools called [benchmark_suite][3].

So there is this [challenge][4] to capitalize first letter of every word. I want to compare my code to the fastest solution there.
so i installed the gem, also the [ruby-ffi][5] gem that somewhat fix an error while I tried to run the benchmark. 

so this is the code to benchmark it

{% codeblock lang:ruby %}
  require 'benchmark/ips'

  string = "The small brown & ginger fox JUMPED OVER the gate"

  Benchmark.ips do |x|
    x.report("first") do 
      string.gsub(/\w+/){|w| w.capitalize} 
    end
    
    x.report("second") do
      string.split.map(&:capitalize).join ' ' 
    end
  end
{% endcodeblock %}

And here is the result

`first 55609.3 (±10.7%) i/s - 277202 in 5.048175s (cycle=4471)`

`second 77996.4 (±10.2%) i/s - 389844 in 5.055319s (cycle=6188)`

The first code run **55.609,3** times per second and the latter is **77.996,4** times per second. 
So the second code run more than the first code in one second. Which mean the second code is faster.

Also the first code run **277.202** times in **5.048175** sec while the second code run **389.844** times in **5.05** sec

[1]: http://www.therubygame.com "The Ruby Game"
[2]: http://rubyrogues.com/034-rr-benchmarking-and-profiling/ "034 RR Benchmarking and Profiling"
[3]: http://rubygems.org/gems/benchmark_suite "benchmark_suite"
[4]: http://www.therubygame.com/challenges/3/submissions "Challenge #3"
[5]: http://rubygems.org/gems/ffi "ffi gem"