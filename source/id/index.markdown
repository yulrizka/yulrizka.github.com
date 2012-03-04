---
layout: default
title: Let each man exercise the art he knows
---

{% for post in site.posts %}
{% if post.language == "id" %}
<div class="articles">
  <article>
    <h1 class="">
        <a href="{{ post.url}}" rel="bookmark" title="Permanent link to ">{{ post.title }}</a>
    </h1>
    <span>{{ post.date | date: '%B' }} {{ post.date | date: '%e' }}, {{ post.date | date: '%Y' }}</span>
    <p>
        {{ post.content }}
    </p>
  </article>
</div>
{% endif %}
{% endfor %}