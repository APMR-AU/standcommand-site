# standcommand.com

The public site for Stand Command — the productised face of the stand planner
built for the Sydney Rare Book Fair 2026. Hand-written static HTML, no
framework, no build step, in the product's own spirit.

```
index.html              the landing page
styles.css
assets/logo-source.png  the logo as rendered, on paper — the source, kept whole
make-logo.sh            derives the three files below from it; needs ImageMagick
assets/logo.png         the logo band with the paper lifted, for the hero
assets/icon.png         the SC monogram, square, favicon and touch icon
assets/share.jpg        the logo band on its paper at 1200x630, for link previews
make-demo.sh            cuts the two files below from the raw recording; needs ffmpeg
assets/demo.mp4         the 39-second silent loop of the tool in use, on the page
assets/demo-poster.jpg  its first frame, shown before it plays
CNAME                   custom domain for GitHub Pages
```

The derived images and the clip are never hand-edited: change the script and
rerun it, as the planner does with its print plan. The raw screen recording the
clip is cut from, `assets/demo-video.mov`, is gitignored — 94 MB, on Nick's Mac
only — so `make-demo.sh` runs there and nowhere else.

## The demo is deliberately not hosted here

A browser tool ships its complete source to whoever opens it, so a public demo
publishes the whole engine, comments and all. The demo build (the fictional
Port Meridian fair), its example layout and the sample exhibitor sheet are
therefore sent by email on request — the site's "Request the demo"
mailto — rather than committed to this public repo. They are built in the
`srbf-planner` repo:

```
cd ../srbf-planner && node build.mjs --fair=demo   # -> dist/stand-command-demo.html
```

Everything in the demo — the fair, the hall, the exhibitors, the prices — is
fictional, and must stay that way: the planner repo's suite asserts no Sydney
fact leaks into the demo build.

There is a `<!-- video slot -->` in index.html for a short screen recording of
the demo, when one exists.

## Deploying

GitHub Pages, from the `main` branch root:

1. `gh repo create standcommand-site --public --source . --push`
2. Repo → Settings → Pages → deploy from `main` / root. The `CNAME` file sets
   the custom domain; tick **Enforce HTTPS** once the certificate is issued.
3. At Namecheap (BasicDNS), delete the old apex redirect, then add:
   - `A` records for `@` → 185.199.108.153, 185.199.109.153,
     185.199.110.153, 185.199.111.153
   - `CNAME` for `www` → `<github-username>.github.io.`
4. Leave the email forwarder's MX records alone — they coexist with the above.
