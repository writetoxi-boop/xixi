#!/bin/bash
# XIXI Hugo Theme Setup Script
set -e

echo "Creating XIXI Hugo theme..."

# ── theme.toml ──
cat > themes/xixi/theme.toml << 'TOML'
name = "XIXI"
license = "MIT"
TOML

# ── baseof.html ──
cat > themes/xixi/layouts/_default/baseof.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{{ if .IsHome }}XIXI — Asia's Culture, Commerce, Creators, Capital{{ else }}{{ .Title }} — XIXI{{ end }}</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,700;0,900;1,400;1,500;1,700&family=Cormorant:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&family=Cormorant+SC:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/xixi.css">
<script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
</head>
<body>
{{ partial "nav.html" . }}
{{ partial "ticker.html" . }}
<main>{{ block "main" . }}{{ end }}</main>
{{ partial "footer.html" . }}
<script>
if (window.netlifyIdentity) {
  window.netlifyIdentity.on("init", u => {
    if (!u) window.netlifyIdentity.on("login", () => { document.location.href = "/admin/"; });
  });
}
const obs = new IntersectionObserver(es => {
  es.forEach((e,i) => { if(e.isIntersecting) setTimeout(()=>e.target.classList.add('in'),i*100); });
},{threshold:0.08});
document.querySelectorAll('.reveal').forEach(el=>obs.observe(el));
</script>
</body>
</html>
HTML

# ── nav.html ──
cat > themes/xixi/layouts/partials/nav.html << 'HTML'
<nav>
  <div class="nav-left">
    <a href="/articles/">Stories</a>
    <a href="/newsletter/">The Asia Letter</a>
  </div>
  <a href="/" class="nav-logo">XIXI<span class="sd">●</span></a>
  <div class="nav-right">
    <a href="/about/">About</a>
    <a href="/advertise/">Partner</a>
    <a href="/newsletter/" class="nav-sub">Subscribe</a>
  </div>
</nav>
HTML

# ── ticker.html ──
cat > themes/xixi/layouts/partials/ticker.html << 'HTML'
<div class="ticker">
  <div class="ticker-track">
    <span class="ticker-item">Fashion</span><span class="ticker-item">Art</span><span class="ticker-item">Culture</span><span class="ticker-item">Capital</span><span class="ticker-item">Power</span><span class="ticker-item accent">The Asia Letter — Weekly</span><span class="ticker-item">Seoul</span><span class="ticker-item">Tokyo</span><span class="ticker-item">Singapore</span><span class="ticker-item">Jakarta</span><span class="ticker-item">Shanghai</span><span class="ticker-item accent">Asia's culture, commerce, creators, capital</span><span class="ticker-item">Fashion</span><span class="ticker-item">Art</span><span class="ticker-item">Culture</span><span class="ticker-item">Capital</span><span class="ticker-item">Power</span><span class="ticker-item accent">The Asia Letter — Weekly</span><span class="ticker-item">Seoul</span><span class="ticker-item">Tokyo</span><span class="ticker-item">Singapore</span><span class="ticker-item">Jakarta</span><span class="ticker-item">Shanghai</span><span class="ticker-item accent">Asia's culture, commerce, creators, capital</span>
  </div>
</div>
HTML

# ── footer.html ──
cat > themes/xixi/layouts/partials/footer.html << 'HTML'
<footer>
  <div class="f-brand">
    <a href="/" class="f-logo">XIXI</a>
    <p>Asia's culture, commerce, creators, and capital — through a global lens.</p>
  </div>
  <div class="f-col">
    <h4>Verticals</h4>
    <ul>
      <li><a href="/articles/?cat=fashion">Fashion</a></li>
      <li><a href="/articles/?cat=art">Art</a></li>
      <li><a href="/articles/?cat=culture">Culture</a></li>
      <li><a href="/articles/?cat=capital">Capital</a></li>
      <li><a href="/articles/?cat=power">Power</a></li>
    </ul>
  </div>
  <div class="f-col">
    <h4>Company</h4>
    <ul>
      <li><a href="/about/">About XIXI</a></li>
      <li><a href="/newsletter/">The Asia Letter</a></li>
      <li><a href="/advertise/">Partner</a></li>
    </ul>
  </div>
  <div class="f-col">
    <h4>Follow</h4>
    <ul>
      <li><a href="#">Instagram</a></li>
      <li><a href="#">TikTok</a></li>
      <li><a href="#">X / Twitter</a></li>
    </ul>
  </div>
</footer>
<div class="f-bottom">
  <p>© {{ now.Year }} XIXI Media · Part of Shibuya Holdings</p>
  <div class="f-social">
    <a href="#">Instagram</a>
    <a href="#">TikTok</a>
    <a href="#">X</a>
  </div>
</div>
HTML

# ── index.html (homepage) ──
cat > themes/xixi/layouts/index.html << 'HTML'
{{ define "main" }}
<section class="hero">
  <div class="hero-left">
    <div class="hero-kicker">Asia's Gen Z Luxury Media Platform</div>
    <div class="hero-headline">
      <h1>The World<br>Is Looking<br><em>East.</em></h1>
    </div>
    <div class="hero-bottom">
      <p class="hero-desc">XIXI spotlights Asian culture, fashion, art, and power through a global lens — unfiltered, unapologetic, essential.</p>
      <div class="hero-actions">
        <a href="/articles/" class="btn-primary">Read Now</a>
        <a href="/newsletter/" class="btn-text">The Asia Letter</a>
      </div>
    </div>
  </div>
  <div class="hero-right">
    {{ $featured := where (where .Site.RegularPages "Section" "articles") ".Params.featured" true }}
    {{ if $featured }}
      {{ with index $featured 0 }}
      <a href="{{ .Permalink }}" class="hero-cover">
        <div class="cover-visual"></div>
        <div class="seal-stamp"><span>XIXI</span></div>
        <div class="cover-content">
          <div class="cover-tag">Cover Story</div>
          <h2 class="cover-title">{{ .Title }}</h2>
          <p class="cover-meta">{{ .Params.author }} · {{ .Params.category | title }} · {{ .Params.read_time }}</p>
        </div>
      </a>
      {{ end }}
    {{ else }}
    <a href="/articles/" class="hero-cover">
      <div class="cover-visual"></div>
      <div class="seal-stamp"><span>XIXI</span></div>
      <div class="cover-content">
        <div class="cover-tag">Cover Story</div>
        <h2 class="cover-title">The Architects of Tomorrow: How Asia's Gen Z Is Rewriting the Rules of Luxury</h2>
        <p class="cover-meta">Mei Lin Zhang · Fashion · 12 min read</p>
      </div>
    </a>
    {{ end }}
  </div>
</section>

<nav class="verticals">
  <a href="/articles/?cat=fashion" class="vertical"><span class="v-num">01</span><span class="v-name">Fashion</span></a>
  <a href="/articles/?cat=art" class="vertical"><span class="v-num">02</span><span class="v-name">Art</span></a>
  <a href="/articles/?cat=culture" class="vertical"><span class="v-num">03</span><span class="v-name">Culture</span></a>
  <a href="/articles/?cat=capital" class="vertical"><span class="v-num">04</span><span class="v-name">Capital</span></a>
  <a href="/articles/?cat=power" class="vertical"><span class="v-num">05</span><span class="v-name">Power</span></a>
</nav>

<div class="section-head reveal">
  <span class="section-label">Latest Stories</span>
  <a href="/articles/" class="section-more">All Stories</a>
</div>

{{ $articles := where .Site.RegularPages "Section" "articles" }}
{{ $articles = $articles.ByDate.Reverse }}

<div class="grid-main reveal">
  {{ range first 1 $articles }}
  <a class="a-card lead" href="{{ .Permalink }}">
    <div>
      <div class="a-tag">{{ .Params.category | title }}</div>
      <h2 class="a-title">{{ .Title }}</h2>
    </div>
    <p class="a-excerpt">{{ .Params.excerpt }}</p>
    <div class="a-meta">
      <span>{{ .Params.author }} · {{ .Date.Format "2 Jan 2006" }}</span>
      <span class="a-readtime">{{ .Params.read_time }}</span>
    </div>
  </a>
  {{ end }}
  {{ range after 1 (first 3 $articles) }}
  <a class="a-card" href="{{ .Permalink }}">
    <div>
      <div class="a-tag">{{ .Params.category | title }}</div>
      <h2 class="a-title">{{ .Title }}</h2>
    </div>
    <div class="a-meta">
      <span>{{ .Params.author }} · {{ .Date.Format "2 Jan 2006" }}</span>
      <span class="a-readtime">{{ .Params.read_time }}</span>
    </div>
  </a>
  {{ end }}
</div>

<div class="grid-secondary reveal">
  {{ range after 3 (first 6 $articles) }}
  <a class="a-card" href="{{ .Permalink }}">
    <div>
      <div class="a-tag">{{ .Params.category | title }}</div>
      <h2 class="a-title">{{ .Title }}</h2>
    </div>
    <div class="a-meta">
      <span>{{ .Params.author }} · {{ .Date.Format "2 Jan 2006" }}</span>
      <span class="a-readtime">{{ .Params.read_time }}</span>
    </div>
  </a>
  {{ end }}
</div>

<div class="divider"></div>
<div class="nl-band reveal">
  <div class="nl-left">
    <div class="nl-kicker">Free Weekly Newsletter</div>
    <h2 class="nl-title">The Asia<br><em>Letter.</em></h2>
    <p class="nl-desc">Culture. Commerce. Creators. Capital. Every week — curated for the globally curious.</p>
    <div class="nl-stats">
      <div class="nl-stat"><span>12K+</span><span>Readers</span></div>
      <div class="nl-stat"><span>48%</span><span>Open Rate</span></div>
      <div class="nl-stat"><span>Free</span><span>Always</span></div>
    </div>
  </div>
  <div class="nl-right">
    <div class="nl-form">
      <input type="email" class="nl-input" placeholder="Your email address">
      <button class="nl-btn">Subscribe to The Asia Letter →</button>
      <p class="nl-fine">No spam · Free forever · Unsubscribe anytime</p>
    </div>
  </div>
</div>
{{ end }}
HTML

# ── list.html (articles listing) ──
cat > themes/xixi/layouts/_default/list.html << 'HTML'
{{ define "main" }}
<div class="page-head">
  <h1>All<br><em>Stories.</em></h1>
  <div class="page-head-right">
    <p>Every story we publish is a lens on the forces shaping Asian culture, commerce, and power.</p>
    <p class="story-count">{{ len .Pages }} stories</p>
  </div>
</div>

<div class="filter-row">
  <button class="f-btn on" data-f="all">All</button>
  <button class="f-btn" data-f="fashion">Fashion</button>
  <button class="f-btn" data-f="art">Art</button>
  <button class="f-btn" data-f="culture">Culture</button>
  <button class="f-btn" data-f="capital">Capital</button>
  <button class="f-btn" data-f="power">Power</button>
</div>

<div class="list-wrap">
  {{ range $i, $page := .Pages.ByDate.Reverse }}
  <a class="a-row" data-cat="{{ $page.Params.category }}" href="{{ $page.Permalink }}">
    <div class="a-num">{{ printf "%02d" (add $i 1) }}</div>
    <div class="a-body">
      <div class="a-tag">{{ $page.Params.category | title }}</div>
      <h2 class="a-row-title">{{ $page.Title }}</h2>
      <p class="a-excerpt">{{ $page.Params.excerpt }}</p>
    </div>
    <div class="a-aside">
      <span class="a-author">{{ $page.Params.author }}</span>
      <span class="a-when">{{ $page.Date.Format "2 Jan 2006" }}</span>
      <span class="a-rt">{{ $page.Params.read_time }}</span>
    </div>
  </a>
  {{ end }}
</div>

<script>
document.querySelectorAll('.f-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.f-btn').forEach(b => b.classList.remove('on'));
    btn.classList.add('on');
    const f = btn.dataset.f;
    let n = 0;
    document.querySelectorAll('.a-row').forEach(row => {
      const show = f === 'all' || row.dataset.cat === f;
      row.classList.toggle('gone', !show);
      if (show) { n++; row.querySelector('.a-num').textContent = String(n).padStart(2,'0'); }
    });
  });
});
</script>
{{ end }}
HTML

# ── single.html (article page) ──
cat > themes/xixi/layouts/_default/single.html << 'HTML'
{{ define "main" }}
<article class="article-wrap">
  <div class="article-header">
    <div class="article-meta-top">
      <span class="a-tag">{{ .Params.category | title }}</span>
      <span class="article-date">{{ .Date.Format "2 January 2006" }}</span>
    </div>
    <h1 class="article-title">{{ .Title }}</h1>
    <p class="article-excerpt">{{ .Params.excerpt }}</p>
    <div class="article-byline">
      <span class="article-author">By {{ .Params.author }}</span>
      <span class="article-readtime">{{ .Params.read_time }}</span>
    </div>
  </div>
  {{ if .Params.image }}
  <div class="article-image">
    <img src="{{ .Params.image }}" alt="{{ .Title }}">
  </div>
  {{ end }}
  <div class="article-body">
    {{ .Content }}
  </div>
  <div class="article-footer">
    <a href="/articles/" class="btn-text">← All Stories</a>
  </div>
</article>
{{ end }}
HTML

echo "Templates created. Now creating CSS..."

# ── xixi.css ──
cat > themes/xixi/static/css/xixi.css << 'CSS'
:root{--paper:#F7F3EE;--paper2:#EDE8E1;--ink:#1A1714;--ink2:#3D3833;--ink3:#6B6560;--ink4:#9E9992;--seal:#C8412A;--rule:rgba(26,23,20,0.12);}
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
html{scroll-behavior:smooth;}
body{background:var(--paper);color:var(--ink);font-family:'Cormorant',serif;font-size:18px;line-height:1.6;overflow-x:hidden;}
body::before{content:'';position:fixed;inset:0;pointer-events:none;z-index:1000;opacity:0.035;background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");background-size:200px 200px;}
nav{position:fixed;top:0;left:0;right:0;z-index:500;background:rgba(247,243,238,0.92);backdrop-filter:blur(16px);border-bottom:1px solid var(--rule);display:grid;grid-template-columns:1fr auto 1fr;align-items:center;padding:0 48px;height:68px;}
.nav-left{display:flex;gap:36px;}
.nav-left a,.nav-right a{font-family:'Cormorant SC',serif;font-size:0.72rem;letter-spacing:0.18em;color:var(--ink3);text-decoration:none;transition:color 0.2s;}
.nav-left a:hover,.nav-right a:hover{color:var(--seal);}
.nav-logo{text-align:center;font-family:'Playfair Display',serif;font-size:1.75rem;font-weight:900;letter-spacing:0.25em;color:var(--ink);text-decoration:none;line-height:1;}
.sd{color:var(--seal);font-size:0.4em;vertical-align:super;margin-left:2px;}
.nav-right{display:flex;gap:36px;justify-content:flex-end;}
.nav-sub{color:var(--paper)!important;background:var(--ink);padding:9px 22px;transition:background 0.2s!important;}
.nav-sub:hover{background:var(--seal)!important;}
.ticker{margin-top:68px;border-bottom:1px solid var(--rule);overflow:hidden;padding:11px 0;background:var(--paper2);}
.ticker-track{display:flex;gap:0;animation:scroll-left 40s linear infinite;width:max-content;}
.ticker-item{font-family:'Cormorant SC',serif;font-size:0.68rem;letter-spacing:0.22em;color:var(--ink3);white-space:nowrap;padding:0 40px;border-right:1px solid var(--rule);}
.ticker-item.accent{color:var(--seal);}
@keyframes scroll-left{from{transform:translateX(0);}to{transform:translateX(-50%);}}
.hero{display:grid;grid-template-columns:1fr 1fr;min-height:calc(100vh - 90px);border-bottom:1px solid var(--rule);}
.hero-left{padding:80px 64px 80px 48px;display:flex;flex-direction:column;justify-content:space-between;border-right:1px solid var(--rule);}
.hero-kicker{font-family:'Cormorant SC',serif;font-size:0.7rem;letter-spacing:0.28em;color:var(--ink4);display:flex;align-items:center;gap:14px;margin-bottom:32px;}
.hero-kicker::before{content:'';width:24px;height:1px;background:var(--seal);display:block;}
.hero-headline{flex:1;display:flex;align-items:center;}
.hero-headline h1{font-family:'Playfair Display',serif;font-size:clamp(3.2rem,5.5vw,6.4rem);font-weight:900;line-height:1.0;letter-spacing:-0.02em;}
.hero-headline h1 em{font-style:italic;color:var(--seal);}
.hero-desc{font-size:0.95rem;color:var(--ink3);font-weight:300;line-height:1.75;max-width:420px;margin-bottom:32px;}
.hero-actions{display:flex;gap:16px;align-items:center;}
.btn-primary{display:inline-block;background:var(--ink);color:var(--paper);font-family:'Cormorant SC',serif;font-size:0.72rem;letter-spacing:0.2em;padding:14px 32px;text-decoration:none;transition:background 0.2s;}
.btn-primary:hover{background:var(--seal);}
.btn-text{font-family:'Cormorant SC',serif;font-size:0.72rem;letter-spacing:0.18em;color:var(--ink3);text-decoration:none;border-bottom:1px solid var(--rule);padding-bottom:2px;transition:color 0.2s;}
.btn-text:hover{color:var(--seal);}
.hero-right{position:relative;overflow:hidden;}
.hero-cover{height:100%;display:flex;flex-direction:column;justify-content:flex-end;padding:52px 48px;text-decoration:none;color:inherit;position:relative;background:var(--ink);}
.cover-visual{position:absolute;inset:0;background:radial-gradient(ellipse at 40% 30%,rgba(200,65,42,0.18) 0%,transparent 60%),radial-gradient(ellipse at 80% 80%,rgba(184,149,90,0.12) 0%,transparent 50%),linear-gradient(180deg,var(--ink) 0%,#2a2320 100%);}
.seal-stamp{position:absolute;top:48px;right:48px;width:72px;height:72px;border:2px solid rgba(200,65,42,0.6);display:flex;align-items:center;justify-content:center;transform:rotate(8deg);}
.seal-stamp span{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:900;letter-spacing:0.1em;color:rgba(200,65,42,0.7);}
.cover-content{position:relative;z-index:2;}
.cover-tag{font-family:'Cormorant SC',serif;font-size:0.68rem;letter-spacing:0.25em;color:var(--seal);margin-bottom:16px;display:flex;align-items:center;gap:10px;}
.cover-tag::before{content:'';width:20px;height:1px;background:var(--seal);display:block;}
.cover-title{font-family:'Playfair Display',serif;font-size:clamp(1.5rem,2.4vw,2.6rem);font-weight:700;line-height:1.2;color:var(--paper);margin-bottom:20px;font-style:italic;}
.cover-meta{font-family:'Cormorant SC',serif;font-size:0.65rem;letter-spacing:0.15em;color:rgba(247,243,238,0.5);}
.verticals{display:grid;grid-template-columns:repeat(5,1fr);border-bottom:1px solid var(--rule);}
.vertical{padding:22px 28px;border-right:1px solid var(--rule);text-decoration:none;color:inherit;display:flex;flex-direction:column;gap:4px;transition:background 0.2s;}
.vertical:last-child{border-right:none;}
.vertical:hover{background:var(--paper2);}
.vertical:hover .v-name{color:var(--seal);}
.v-num{font-family:'Cormorant SC',serif;font-size:0.6rem;letter-spacing:0.2em;color:var(--ink4);}
.v-name{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:500;transition:color 0.2s;}
.section-head{display:flex;align-items:center;justify-content:space-between;padding:52px 48px 36px;}
.section-label{font-family:'Cormorant SC',serif;font-size:0.72rem;letter-spacing:0.28em;color:var(--ink4);display:flex;align-items:center;gap:14px;}
.section-label::before{content:'';width:24px;height:1px;background:var(--seal);display:block;}
.section-more{font-family:'Cormorant SC',serif;font-size:0.68rem;letter-spacing:0.18em;color:var(--ink3);text-decoration:none;display:flex;align-items:center;gap:8px;border-bottom:1px solid var(--rule);padding-bottom:2px;transition:color 0.2s;}
.section-more:hover{color:var(--seal);}
.section-more::after{content:'→';}
.grid-main{display:grid;grid-template-columns:5fr 3fr 3fr;border:1px solid var(--rule);margin:0 48px;background:var(--rule);gap:1px;}
.grid-secondary{display:grid;grid-template-columns:repeat(3,1fr);border:1px solid var(--rule);border-top:none;margin:0 48px;background:var(--rule);gap:1px;}
.a-card{background:var(--paper);padding:36px 32px;display:flex;flex-direction:column;gap:16px;text-decoration:none;color:inherit;transition:background 0.2s;min-height:260px;}
.a-card:hover{background:var(--paper2);}
.a-card:hover .a-title{color:var(--seal);}
.a-card.lead{min-height:520px;grid-row:span 2;}
.a-card.lead .a-title{font-size:clamp(1.4rem,2vw,2rem);}
.a-tag{font-family:'Cormorant SC',serif;font-size:0.62rem;letter-spacing:0.22em;color:var(--seal);}
.a-title{font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:500;line-height:1.3;transition:color 0.2s;flex:1;}
.a-excerpt{font-size:0.9rem;color:var(--ink3);font-weight:300;line-height:1.65;}
.a-meta{font-family:'Cormorant SC',serif;font-size:0.6rem;letter-spacing:0.12em;color:var(--ink4);display:flex;justify-content:space-between;align-items:center;margin-top:auto;padding-top:16px;border-top:1px solid var(--rule);}
.a-readtime{background:var(--paper2);padding:3px 8px;font-size:0.58rem;}
.divider{height:1px;background:var(--rule);margin:64px 48px 0;}
.nl-band{margin:64px 48px;display:grid;grid-template-columns:1fr 1fr;border:1px solid var(--ink);position:relative;overflow:hidden;}
.nl-band::before{content:'THE ASIA LETTER';position:absolute;font-family:'Playfair Display',serif;font-size:9rem;font-weight:900;color:rgba(26,23,20,0.04);white-space:nowrap;top:50%;right:-20px;transform:translateY(-50%);pointer-events:none;letter-spacing:-0.02em;}
.nl-left{padding:56px 52px;border-right:1px solid var(--ink);}
.nl-kicker{font-family:'Cormorant SC',serif;font-size:0.68rem;letter-spacing:0.28em;color:var(--seal);margin-bottom:20px;display:flex;align-items:center;gap:12px;}
.nl-kicker::before{content:'';width:20px;height:1px;background:var(--seal);display:block;}
.nl-title{font-family:'Playfair Display',serif;font-size:clamp(2.4rem,4vw,4rem);font-weight:900;line-height:1.0;margin-bottom:16px;letter-spacing:-0.01em;}
.nl-title em{font-style:italic;color:var(--seal);}
.nl-desc{font-size:1rem;color:var(--ink3);font-weight:300;line-height:1.7;max-width:380px;margin-bottom:32px;}
.nl-stats{display:flex;gap:40px;}
.nl-stat span:first-child{display:block;font-family:'Playfair Display',serif;font-size:2rem;font-weight:700;color:var(--ink);line-height:1;}
.nl-stat span:last-child{font-family:'Cormorant SC',serif;font-size:0.6rem;letter-spacing:0.18em;color:var(--ink4);}
.nl-right{padding:56px 52px;display:flex;flex-direction:column;justify-content:center;}
.nl-form{display:flex;flex-direction:column;gap:12px;}
.nl-input{background:transparent;border:none;border-bottom:1px solid var(--rule);color:var(--ink);padding:14px 0;font-family:'Cormorant',serif;font-size:1rem;outline:none;width:100%;transition:border-color 0.2s;}
.nl-input:focus{border-bottom-color:var(--seal);}
.nl-input::placeholder{color:var(--ink4);}
.nl-btn{background:var(--ink);color:var(--paper);border:none;padding:16px 28px;font-family:'Cormorant SC',serif;font-size:0.72rem;letter-spacing:0.2em;cursor:pointer;transition:background 0.2s;margin-top:8px;text-align:left;}
.nl-btn:hover{background:var(--seal);}
.nl-fine{font-family:'Cormorant SC',serif;font-size:0.6rem;letter-spacing:0.12em;color:var(--ink4);margin-top:8px;}
footer{border-top:1px solid var(--rule);padding:64px 48px 48px;display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:56px;}
.f-brand .f-logo{font-family:'Playfair Display',serif;font-size:1.8rem;font-weight:900;letter-spacing:0.2em;display:block;margin-bottom:16px;text-decoration:none;color:var(--ink);}
.f-brand p{font-size:0.9rem;color:var(--ink3);font-weight:300;line-height:1.7;max-width:260px;}
.f-col h4{font-family:'Cormorant SC',serif;font-size:0.65rem;letter-spacing:0.22em;color:var(--ink4);margin-bottom:20px;}
.f-col ul{list-style:none;}
.f-col ul li{margin-bottom:10px;}
.f-col ul a{font-size:0.95rem;color:var(--ink3);text-decoration:none;transition:color 0.2s;}
.f-col ul a:hover{color:var(--seal);}
.f-bottom{padding:24px 48px;border-top:1px solid var(--rule);display:flex;justify-content:space-between;align-items:center;}
.f-bottom p{font-family:'Cormorant SC',serif;font-size:0.62rem;letter-spacing:0.12em;color:var(--ink4);}
.f-social{display:flex;gap:24px;}
.f-social a{font-family:'Cormorant SC',serif;font-size:0.62rem;letter-spacing:0.15em;color:var(--ink4);text-decoration:none;transition:color 0.2s;}
.f-social a:hover{color:var(--seal);}
.page-head{margin-top:68px;padding:80px 48px 60px;border-bottom:1px solid var(--rule);display:grid;grid-template-columns:1fr 1fr;gap:64px;align-items:end;}
.page-head h1{font-family:'Playfair Display',serif;font-size:clamp(4rem,8vw,9rem);font-weight:900;line-height:0.9;letter-spacing:-0.02em;}
.page-head h1 em{font-style:italic;color:var(--seal);}
.page-head-right p{font-size:0.98rem;color:var(--ink3);font-weight:300;line-height:1.75;margin-bottom:20px;}
.story-count{font-family:'Cormorant SC',serif;font-size:0.65rem;letter-spacing:0.18em;color:var(--ink4);}
.filter-row{display:flex;gap:0;border-bottom:1px solid var(--rule);padding:0 48px;overflow-x:auto;}
.f-btn{font-family:'Cormorant SC',serif;font-size:0.68rem;letter-spacing:0.2em;color:var(--ink4);background:none;border:none;padding:18px 24px;cursor:pointer;border-bottom:2px solid transparent;transition:color 0.2s,border-color 0.2s;white-space:nowrap;}
.f-btn:hover{color:var(--ink);}
.f-btn.on{color:var(--seal);border-bottom-color:var(--seal);}
.list-wrap{padding:0 48px 100px;}
.a-row{display:grid;grid-template-columns:72px 1fr auto;gap:40px;align-items:start;padding:44px 0;border-bottom:1px solid var(--rule);text-decoration:none;color:inherit;}
.a-row:hover .a-row-title{color:var(--seal);}
.a-num{font-family:'Playfair Display',serif;font-size:3.5rem;font-weight:900;color:rgba(200,65,42,0.12);line-height:1;padding-top:4px;}
.a-row-title{font-family:'Playfair Display',serif;font-size:clamp(1.15rem,1.8vw,1.65rem);font-weight:500;line-height:1.25;margin-bottom:12px;transition:color 0.2s;font-style:italic;}
.a-excerpt{font-size:0.9rem;color:var(--ink3);font-weight:300;line-height:1.65;max-width:580px;}
.a-aside{text-align:right;flex-shrink:0;}
.a-author{font-family:'Cormorant SC',serif;font-size:0.6rem;letter-spacing:0.12em;color:var(--ink3);display:block;margin-bottom:4px;white-space:nowrap;}
.a-when{font-family:'Cormorant SC',serif;font-size:0.58rem;letter-spacing:0.1em;color:var(--ink4);display:block;margin-bottom:12px;}
.a-rt{background:var(--paper2);padding:4px 10px;font-family:'Cormorant SC',serif;font-size:0.58rem;letter-spacing:0.1em;color:var(--ink3);}
.a-row.gone{display:none!important;}
.article-wrap{max-width:760px;margin:0 auto;padding:120px 48px 100px;}
.article-meta-top{display:flex;align-items:center;gap:20px;margin-bottom:24px;}
.article-date{font-family:'Cormorant SC',serif;font-size:0.65rem;letter-spacing:0.18em;color:var(--ink4);}
.article-title{font-family:'Playfair Display',serif;font-size:clamp(2rem,4vw,3.5rem);font-weight:900;line-height:1.1;letter-spacing:-0.01em;margin-bottom:20px;font-style:italic;}
.article-excerpt{font-family:'Cormorant',serif;font-size:1.2rem;color:var(--ink3);font-weight:300;line-height:1.65;margin-bottom:28px;font-style:italic;}
.article-byline{display:flex;align-items:center;gap:20px;padding:20px 0;border-top:1px solid var(--rule);border-bottom:1px solid var(--rule);margin-bottom:48px;}
.article-author{font-family:'Cormorant SC',serif;font-size:0.68rem;letter-spacing:0.18em;color:var(--ink);}
.article-readtime{font-family:'Cormorant SC',serif;font-size:0.65rem;letter-spacing:0.15em;color:var(--ink4);}
.article-image{margin-bottom:48px;}
.article-image img{width:100%;height:auto;}
.article-body{font-size:1.05rem;line-height:1.85;font-weight:300;color:var(--ink2);}
.article-body h2{font-family:'Playfair Display',serif;font-size:1.6rem;font-weight:700;margin:40px 0 16px;color:var(--ink);}
.article-body h3{font-family:'Playfair Display',serif;font-size:1.2rem;font-weight:500;margin:32px 0 12px;color:var(--ink);}
.article-body p{margin-bottom:24px;}
.article-body strong{font-weight:500;color:var(--ink);}
.article-body em{font-style:italic;}
.article-body blockquote{border-left:3px solid var(--seal);padding-left:28px;margin:36px 0;font-family:'Playfair Display',serif;font-style:italic;font-size:1.3rem;color:var(--seal);}
.article-footer{margin-top:64px;padding-top:32px;border-top:1px solid var(--rule);}
.reveal{opacity:0;transform:translateY(28px);transition:opacity 0.8s ease,transform 0.8s ease;}
.reveal.in{opacity:1;transform:translateY(0);}
@media(max-width:900px){nav{padding:0 20px;grid-template-columns:1fr auto;}.nav-left,.nav-right{display:none;}.hero{grid-template-columns:1fr;}.hero-left{padding:48px 24px;border-right:none;border-bottom:1px solid var(--rule);}.hero-right{min-height:60vw;}.verticals{grid-template-columns:repeat(3,1fr);}.grid-main{grid-template-columns:1fr;margin:0 20px;}.grid-secondary{grid-template-columns:1fr;margin:0 20px;}.a-card.lead{grid-row:span 1;min-height:280px;}.section-head{padding:40px 20px 24px;}.nl-band{grid-template-columns:1fr;margin:40px 20px;}.nl-left{border-right:none;border-bottom:1px solid var(--ink);padding:40px 28px;}.nl-right{padding:40px 28px;}footer{grid-template-columns:1fr 1fr;padding:48px 20px;}.f-bottom{padding:20px;}.divider{margin:48px 20px 0;}.page-head{grid-template-columns:1fr;padding:60px 20px 40px;}.filter-row{padding:0 20px;}.list-wrap{padding:0 20px 64px;}.a-row{grid-template-columns:1fr;gap:12px;}.a-aside{text-align:left;}.article-wrap{padding:100px 24px 64px;}}
CSS

echo "CSS created. Now creating admin files..."

# ── admin/index.html ──
cat > static/admin/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>XIXI — Content Manager</title>
</head>
<body>
  <script src="https://unpkg.com/netlify-cms@^2.0.0/dist/netlify-cms.js"></script>
</body>
</html>
HTML

# ── admin/config.yml ──
cat > static/admin/config.yml << 'YAML'
backend:
  name: git-gateway
  branch: main

publish_mode: editorial_workflow

media_folder: "static/uploads"
public_folder: "/uploads"

collections:
  - name: "articles"
    label: "Articles"
    label_singular: "Article"
    folder: "content/articles"
    create: true
    slug: "{{slug}}"
    fields:
      - { label: "Title", name: "title", widget: "string" }
      - { label: "Publish Date", name: "date", widget: "datetime" }
      - label: "Vertical"
        name: "category"
        widget: "select"
        options:
          - { label: "Fashion", value: "fashion" }
          - { label: "Art", value: "art" }
          - { label: "Culture", value: "culture" }
          - { label: "Capital", value: "capital" }
          - { label: "Power", value: "power" }
      - { label: "Author", name: "author", widget: "string" }
      - { label: "Read Time (e.g. 9 min)", name: "read_time", widget: "string" }
      - { label: "Excerpt", name: "excerpt", widget: "text" }
      - { label: "Featured Image", name: "image", widget: "image", required: false }
      - { label: "Body", name: "body", widget: "markdown" }
      - { label: "Featured on Homepage", name: "featured", widget: "boolean", default: false, required: false }
YAML

# ── netlify.toml ──
cat > netlify.toml << 'TOML'
[build]
  command = "hugo --minify"
  publish = "public"

[build.environment]
  HUGO_VERSION = "0.160.0"

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "SAMEORIGIN"
TOML

# ── sample article ──
cat > content/articles/seoul-is-the-new-milan.md << 'MD'
---
title: "Seoul Is the New Milan: Inside the K-Fashion Takeover Reshaping Global Runways"
date: 2026-04-06T09:00:00.000Z
category: fashion
author: Ji-Yeon Park
read_time: 9 min
excerpt: From Gentle Monster to Ader Error, a new generation of Korean designers is doing what no one thought possible — making the West come to them.
featured: true
---

For decades, the global fashion calendar has been dictated by four cities: New York, London, Milan, Paris. The axis was fixed. The hierarchy was understood. Then Seoul happened.

What began as a cultural export — K-Pop, K-Beauty, K-Drama — has mutated into something more structural. Korean fashion is no longer a trend Western editors parachute into for a season. It is a gravitational force with its own orbit, its own logic, and increasingly, its own rules.

## The Brands Doing It

**Gentle Monster** started as an eyewear brand and became one of the most audacious retail experiences on the planet. Their stores — part gallery, part fever dream — draw queues in Shanghai, Beijing, Dubai, and New York. They didn't adapt to Western taste. Western taste adapted to them.

**Ader Error** built a universe. The Seoul-based collective makes clothing that reads as art project, community manifesto, and commercial product simultaneously. Their collaborations with Maison Margiela didn't feel like a concession — they felt like an annexation.

## Why Now

Three forces converged. First, the infrastructure caught up. Second, the audience changed — Gen Z consumers are deeply suspicious of Western taste arbitration. Third, visibility compounded through K-Pop's global reach.

The implication for Western luxury brands is uncomfortable: the audience they want most is increasingly indifferent to European heritage as a signal of status. What matters now is cultural precision.

Seoul is not asking permission anymore. It never really needed to.
MD

echo ""
echo "✓ All files created successfully!"
echo ""
echo "Next: run 'hugo server' to preview, then push to GitHub."
