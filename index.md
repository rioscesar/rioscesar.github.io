---
layout: page
title: Writing
description: Engineering notes from Cesar Rios.
---

<p class="lede">I’m a software engineer interested in reliable systems, infrastructure, and the changing process of building software. This is where I document projects, engineering decisions, experiments, and the lessons that survive them.</p>

## Latest writing

{% if site.posts.size > 0 %}
<div class="writing-list">
  {% for post in site.posts limit: 5 %}
  <article class="writing-list__item">
    <p class="eyebrow">{{ post.date | date: "%B %-d, %Y" }}{% if post.category %} · {{ post.category | replace: "-", " " }}{% endif %}</p>
    <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
    {% if post.description %}<p>{{ post.description }}</p>{% endif %}
  </article>
  {% endfor %}
</div>
{% else %}
<div class="empty-state"><p class="eyebrow">The notebook is open</p><p>There are no published articles yet. The first entries will begin with the problems, assumptions, and tradeoffs worth keeping.</p></div>
{% endif %}

## Selected projects

<div class="project-card">
  <p class="eyebrow">In development</p>
  <h3><a href="{{ '/projects/' | relative_url }}#living-room-tv">Living Room TV</a></h3>
  <p>A controller-first interface that turns a Windows desktop into a living-room entertainment system.</p>
  <p><a href="{{ '/writing/i-thought-i-was-building-a-launcher/' | relative_url }}">Read: I Thought I Was Building a Launcher</a></p>
</div>
