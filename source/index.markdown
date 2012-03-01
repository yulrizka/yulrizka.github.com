---
layout: default
title: Let each man exercise the art he knows
---
<h1>Welcome to dev blog of Ahmy Yulrizka</h1>

Hi, my name is Ahmy, I've been developing software application for about 12 years now. Im interested in many aspect of technologies. Including
web development, mobile application, linux etc. To me programming is a form of arts. Because you can implement a software with so many different
approach. Just like an artist who responsible for every line, color and shape; To me a programmer should hold the responsibility of every line,
method, and architecture that he choses. So this is blog is my canvas. the place where I explore my idea and finding.

As you can see, the site is still on development (and should always be). But I don't wait for perfection to pour my idea into it. You are very
welcome to enjoy, read or give some comment about it. By the way this blog are also open sourced, you can find the source link at the footer 
section of every page. 

Ok then, Now which post do you want to read ?

## <a href="/id">Recent Post written in Bahasa Indonesia</a>
<ul>
{% assign i = 10 %}
{% for post in site.posts %}
  {% if post.language == "id" and i > 0 %}
  {% assign i = (i + 2) %}
    <li>
      <a href="{{ post.url}}" rel="bookmark" title="Permanent link to ">{{ post.title }}</a> 
      <span>{{ post.date | date: '%B' }} {{ post.date | date: '%e' }}, {{ post.date | date: '%Y' }}</span>
    </li>
  {% endif %}
{% endfor %}
</ul>

## <a href="/en">Recent Post written in English</a>
<ul>
{% assign i = 10 %}
{% for post in site.posts %}
  {% if post.language == "en" and i > 0 %}
  {% assign i = (i + 2) %}
    <li>
      <a href="{{ post.url}}" rel="bookmark" title="Permanent link to ">{{ post.title }}</a> 
      <span>{{ post.date | date: '%B' }} {{ post.date | date: '%e' }}, {{ post.date | date: '%Y' }}</span>
    </li>
  {% endif %}
{% endfor %}
</ul>