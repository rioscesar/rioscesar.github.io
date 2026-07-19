# Cesar Rios

A Markdown-first engineering blog about projects, decisions, experiments, and the lessons that survive them. The focus is not on showcasing finished work; it is on how engineering judgment evolves while building it.

## Architecture

The site is a deliberately small [Jekyll](https://jekyllrb.com/) site hosted on GitHub Pages. Posts are Markdown in `_posts/`; Liquid layouts and one CSS file provide the presentation. GitHub Actions validates pull requests and deploys only the default branch. There is no CMS, analytics, comments, newsletter, or frontend framework.

## Local setup

Install a current Ruby with Bundler, then run:

```sh
bundle install
bundle exec jekyll serve
```

Open <http://localhost:4000>. To preview an unpublished draft in `_drafts/`, use `bundle exec jekyll serve --drafts`.

## Writing and publishing

1. Read `notes/builder-voice.md` and copy `notes/article-template.md` into `_posts/YYYY-MM-DD-slug.md`.
2. Start with `published: false` while drafting. Preview with `--unpublished`, or use `_drafts/` with `--drafts`.
3. Complete `notes/publishing-checklist.md` and set `published: true` (or remove the field) when the article is ready.
4. Open a pull request. Validation builds the site; merging into `master` deploys it through GitHub Pages.

## Repository organization

```text
_includes/       Reusable HTML fragments
_layouts/        Page and post layouts
_posts/          Published Markdown articles
assets/css/      Site stylesheet
assets/images/   Article and site images
assets/diagrams/ Source diagrams and diagram assets
notes/           Private editorial guidance (excluded from the site)
.github/workflows/ Validation and GitHub Pages deployment
```

## Editorial principles

This is an engineering notebook: conversational, technically grounded, honest about uncertainty, and explicit about tradeoffs. See `notes/builder-voice.md` for the editorial constitution and `notes/editorial-roadmap.md` for taxonomy guidance.

## Current status

Phase 1 establishes the publishing foundation, visual system, and editorial workflow. No articles have been published yet.

## GitHub Pages configuration

In repository **Settings → Pages**, set the source to **GitHub Actions**. The deployment workflow is intentionally restricted to the default branch. GitHub may require the first deployment workflow run to be approved by a repository administrator.

## License

Released under the [MIT License](LICENSE).
