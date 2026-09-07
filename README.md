# standcommand.com

The public site for Stand Command — the productised face of the stand planner
built for the Sydney Rare Book Fair 2026. Hand-written static HTML, no
framework, no build step, in the product's own spirit.

```
index.html            the landing page
styles.css
assets/hero.jpg       screenshot of the demo build with the example layout
CNAME                 custom domain for GitHub Pages
```

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
