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
  <p class="eyebrow">Milestone 0 complete</p>
  <h3><a href="{{ '/projects/' | relative_url }}#hlstr">HLSTR</a></h3>
  <p>A career-assessment experiment focused on making engineering evidence and next-level readiness more legible.</p>
</div>

<div class="project-card">
  <p class="eyebrow">Milestone 1 complete</p>
  <h3><a href="{{ '/projects/' | relative_url }}#trustclaw">TrustClaw</a></h3>
  <p>An experimental trust plane for autonomous actions, built around deterministic policy, request-bound approval, and verifiable evidence.</p>
</div>

<div class="project-card">
  <p class="eyebrow">Early release</p>
  <h3><a href="{{ '/projects/' | relative_url }}#backburner">Backburner</a></h3>
  <p>An extension for revisiting forgotten Chrome bookmarks and deciding what is still worth your attention.</p>
</div>
