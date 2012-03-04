---
layout: default
title: Posts in ruby cateogry
category: ruby
---

## <a href="/id">Recent Post written in Bahasa Indonesia</a>
<ul>
{% assign i = 10 %}
{% for post in site.tags.ruby %}
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
{% for post in site.tags.ruby %}
  {% if post.language == "en" and i > 0 %}
  {% assign i = (i + 2) %}
    <li>
      <a href="{{ post.url}}" rel="bookmark" title="Permanent link to ">{{ post.title }}</a> 
      <span>{{ post.date | date: '%B' }} {{ post.date | date: '%e' }}, {{ post.date | date: '%Y' }}</span>
    </li>
  {% endif %}
{% endfor %}
</ul>