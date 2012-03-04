---
layout: default
title: Let each man exercise the art he knows
---
<div class="articles">
{% for post in site.posts %}
{% if post.language == "en" %}
  <article>
    <h1 class="">
        <a href="{{ post.url}}" rel="bookmark" title="Permanent link to ">{{ post.title }}</a>
    </h1>
    <span>{{ post.date | date: '%B' }} {{ post.date | date: '%e' }}, {{ post.date | date: '%Y' }}</span>
    <p>
        {{ post.content }}
    </p>
  </article>
  <hr/>
{% endif %}
{% endfor %}
</div>