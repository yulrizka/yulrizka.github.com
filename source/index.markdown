---
layout: default
title: Let each man exercise the art he knows
---
<h1>Welcome to dev blog of Ahmy Yulrizka</h1>

Hi, my name is Ahmy, I've been developing software application for quite some times now. I'm interested in many aspect of technologies. Including
web development, mobile application, linux etc. To me programming is a form of arts. Because you can implement a software with so many ways. Just like an artist who responsible for every line, color and shape; as programmer one should held the responsibility on every line, method, and design that he/she choses. That's why I'm really happy and enjoy programming with Ruby

This this is my humble canvas. the place where I pour some idea and experiment. You are very welcome to enjoy, read and leave some comments.

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