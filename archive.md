---
layout: page
title: Archive
description: Published writing, grouped by year.
permalink: /archive/
---

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}
{% if posts_by_year.size > 0 %}
  {% for year in posts_by_year %}
  <section class="archive-year" aria-labelledby="year-{{ year.name }}">
    <h2 id="year-{{ year.name }}">{{ year.name }}</h2>
    <ul class="archive-list">{% for post in year.items %}<li><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %-d" }}</time><a href="{{ post.url | relative_url }}">{{ post.title }}</a></li>{% endfor %}</ul>
  </section>
  {% endfor %}
{% else %}
<div class="empty-state"><p>No published writing yet.</p></div>
{% endif %}
