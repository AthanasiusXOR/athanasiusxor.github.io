# Nicene Security

The field-post of [AthanasiusXOR](https://github.com/AthanasiusXOR): red-team writing held to the Nicene standard. The public site is [nicenesecurity.com](https://www.nicenesecurity.com/), published from the GitHub Pages repository `athanasiusxor.github.io` with the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme.

This working copy is the same Chirpy site, brought current so the home page is no longer blank and the visual system matches the seal.

## What was wrong on the live site

The July 2026 GitHub Pages build ran at 9:40pm Denver time on June 30. The only essay was dated July 1, which Jekyll treats as midnight in `America/Denver`. With `future: false`, that build published the theme and left the post list empty. The epistle URL still 404s until the site is rebuilt.

A few other deploy leftovers were still visible: the sidebar line “Penetration Testings,” the Chirpy placeholder address `example@domain.com` on the envelope icon, and navigation labels long enough to wrap over themselves.

## Run it locally

You need Ruby 3.2 or newer and Bundler.

```bash
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 8642
```

Open [http://127.0.0.1:8642](http://127.0.0.1:8642). Drafts stay hidden unless you add `--drafts`.

`tools/run.sh` is the upstream Chirpy helper and does the same serve without a fixed port.

## Write an essay

1. Copy `_drafts/2026-10-22-new-essay.md` to `_posts/YYYY-MM-DD-short-slug.md`.
2. Set `title`, `description`, `categories`, and `tags`. The description is the card text and the line under the title.
3. Add an `image` with `path` and `alt`. That file is the card and the picture at the top of the essay. Use a JPEG around 1600 pixels wide; the originals under `assets/img/` are often over two megabytes.
4. Put a real timestamp in the front matter, in Denver time. A date with no clock is midnight. Posts meant for a later morning stay in `_posts` with `published: false` until that morning. `future: true` keeps the October 31 essay visible, and it would also publish a later post immediately.

```yaml
date: 2026-10-22 09:00:00 -0600
```

Categories already in use are `Theology` and `Practice`. Pin one charter post with `pin: true`.

Public essays stay at judgment, stewardship, and authorized narrative. Live payloads, weaponized proofs, and step-by-step intrusion procedures do not belong on this field-post.

## Publish

The workflow in `.github/workflows/pages-deploy.yml` builds with Jekyll and deploys to GitHub Pages on every push to `main`. The custom domain is the `CNAME` file, `www.nicenesecurity.com`.

Copy the changes you want into `AthanasiusXOR/athanasiusxor.github.io` and push `main`. Pages will rebuild, and the epistle will finally be on the home page.

Before you restore the envelope icon, put a real address in `_config.yml` under `social.email` and add the email block back to `_data/contact.yml`.

Static CSS and fonts load from the CDN. Self-hosting is off. The theme is pinned to Chirpy `7.6.0`, which is the generation already serving the live favicon and icon set.

## Theme

Color and type live at the bottom of `assets/css/jekyll-theme-chirpy.scss`. Headings are Cormorant Garamond. Body text is Source Sans 3. Light mode is parchment and ink. Dark mode is the stone ground behind the seal. The home masthead is `_layouts/home.html`. Sidebar names for the two about pages are in `_data/locales/en.yml` (`aboutme`, `aboutus`), so the page titles can stay long without wrapping the navigation.
