---
permalink: /
title: "About"
excerpt: "Krzysztof Zaremba — Assistant Professor of Economics at ITAM Business School. Research in health, network, and family economics."
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

<style>
  /* ---------- Home page layout ---------- */
  .kz-home { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Helvetica Neue", Arial, sans-serif; color: #1f2933; }
  .kz-home p { line-height: 1.6; }

  /* ---------- Hero ---------- */
  .kz-hero { padding: 0.2em 0 1.2em; border-bottom: 1px solid #ececec; margin-bottom: 1.6em; }
  .kz-hero h1 { font-size: 2.1em; margin: 0 0 0.15em; letter-spacing: -0.01em; font-weight: 600; }
  .kz-hero .kz-affil { font-size: 1.05em; color: #4a5568; margin: 0 0 0.9em; }
  .kz-hero .kz-affil .kz-sep { color: #cbd5e0; margin: 0 0.45em; }
  .kz-hero .kz-lede { font-size: 1.02em; color: #2d3748; max-width: 44em; }

  .kz-cta { margin-top: 1.1em; display: flex; flex-wrap: wrap; gap: 0.5em; }
  .kz-cta a {
    display: inline-flex; align-items: center; gap: 0.4em;
    padding: 0.5em 0.95em; border-radius: 6px;
    text-decoration: none; font-size: 0.92em; font-weight: 500;
    transition: all 0.15s ease;
  }
  .kz-cta a.kz-primary { background: #1a365d; color: #fff; }
  .kz-cta a.kz-primary:hover { background: #2c5282; }
  .kz-cta a.kz-ghost { background: #fff; color: #1a365d; border: 1px solid #cbd5e0; }
  .kz-cta a.kz-ghost:hover { border-color: #1a365d; color: #1a365d; background: #f7fafc; }

  /* ---------- Section heading ---------- */
  .kz-section-h {
    font-size: 0.78em; font-weight: 700; letter-spacing: 0.12em;
    text-transform: uppercase; color: #718096;
    margin: 2em 0 0.9em; padding-bottom: 0.4em;
    border-bottom: 1px solid #ececec;
  }

  /* ---------- Research areas ---------- */
  .kz-areas { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1em; }
  .kz-area {
    padding: 1em 1.1em; border: 1px solid #e2e8f0; border-radius: 8px;
    background: #fafbfc; transition: all 0.15s ease;
  }
  .kz-area:hover { border-color: #1a365d; background: #fff; box-shadow: 0 2px 8px rgba(26,54,93,0.06); }
  .kz-area .kz-area-title { font-weight: 600; color: #1a365d; margin-bottom: 0.35em; font-size: 0.98em; }
  .kz-area .kz-area-body { font-size: 0.88em; color: #4a5568; line-height: 1.5; }

  /* ---------- News ---------- */
  .kz-news { border-left: 3px solid #1a365d; padding-left: 1.1em; }
  .kz-news ul { list-style: none; padding: 0; margin: 0; }
  .kz-news li { display: flex; gap: 1em; padding: 0.5em 0; font-size: 0.94em; border-bottom: 1px dashed #edf2f7; }
  .kz-news li:last-child { border-bottom: none; }
  .kz-news .kz-date {
    flex: 0 0 5.5em; font-variant-numeric: tabular-nums;
    color: #718096; font-size: 0.85em; padding-top: 0.15em;
  }
  .kz-news .kz-news-body { color: #2d3748; }
  .kz-news .kz-news-body a { color: #1a365d; }

  /* ---------- Featured papers ---------- */
  .kz-featured { display: grid; gap: 1.2em; }
  .kz-paper {
    display: grid; grid-template-columns: 200px 1fr; gap: 1.4em;
    padding: 1.1em; border: 1px solid #e2e8f0; border-radius: 8px;
    background: #fff; transition: box-shadow 0.15s ease;
  }
  .kz-paper:hover { box-shadow: 0 4px 14px rgba(0,0,0,0.07); }
  .kz-paper .kz-thumb {
    background: #f7fafc; border-radius: 6px; overflow: hidden;
    display: flex; align-items: center; justify-content: center;
    aspect-ratio: 4/3;
  }
  .kz-paper .kz-thumb img { width: 100%; height: 100%; object-fit: cover; }
  .kz-paper .kz-meta { font-size: 0.78em; color: #718096; text-transform: uppercase; letter-spacing: 0.08em; font-weight: 600; margin-bottom: 0.3em; }
  .kz-paper h3 {
    margin: 0 0 0.4em; font-size: 1.08em; line-height: 1.35; font-weight: 600;
  }
  .kz-paper h3 a { color: #1a365d; text-decoration: none; }
  .kz-paper h3 a:hover { text-decoration: underline; }
  .kz-paper .kz-coauthors { font-size: 0.9em; color: #4a5568; margin: 0 0 0.5em; font-style: italic; }
  .kz-paper .kz-pitch { font-size: 0.92em; color: #2d3748; margin: 0.4em 0 0.6em; line-height: 1.5; }
  .kz-paper .kz-links { display: flex; flex-wrap: wrap; gap: 0.4em; }
  .kz-paper .kz-links a {
    font-size: 0.8em; padding: 0.25em 0.7em; border-radius: 4px;
    background: #edf2f7; color: #2d3748; text-decoration: none;
    transition: background 0.15s ease;
  }
  .kz-paper .kz-links a:hover { background: #1a365d; color: #fff; }

  /* badges */
  .kz-badge { display: inline-block; padding: 0.15em 0.55em; border-radius: 3px; font-size: 0.72em; font-weight: 600; letter-spacing: 0.04em; text-transform: uppercase; vertical-align: middle; margin-left: 0.4em; }
  .kz-badge.kz-pub { background: #c6f6d5; color: #22543d; }
  .kz-badge.kz-rr  { background: #feebc8; color: #7b341e; }
  .kz-badge.kz-wp  { background: #e2e8f0; color: #2d3748; }
  .kz-badge.kz-jmp { background: #1a365d; color: #fff; }

  /* Mobile */
  @media (max-width: 640px) {
    .kz-paper { grid-template-columns: 1fr; }
    .kz-paper .kz-thumb { aspect-ratio: 16/9; }
    .kz-news li { flex-direction: column; gap: 0.1em; }
    .kz-news .kz-date { flex: none; }
  }
</style>

<div class="kz-home">

<section class="kz-hero">
  <h1>Krzysztof Zaremba</h1>
  <p class="kz-affil">
    Assistant Professor of Economics
    <span class="kz-sep">·</span> ITAM Business School
    <span class="kz-sep">·</span> Mexico City
  </p>
  <p class="kz-lede">
    I am an applied microeconomist working at the intersection of <b>health</b>,
    <b>networks</b>, and <b>family economics</b>. My research uses large-scale
    administrative data and quasi-experimental methods to study how policies,
    social structures, and environmental shocks shape health and economic outcomes
    across generations. I received my Ph.D. in Economics from Columbia University.
  </p>
  <div class="kz-cta">
    <a class="kz-primary" href="/files/Krzysztof_Zaremba_A_CV.pdf" target="_blank">Curriculum Vitae</a>
    <a class="kz-ghost" href="/publications/">Research</a>
    <a class="kz-ghost" href="/teaching/">Teaching</a>
    <a class="kz-ghost" href="mailto:krzysztof.zaremba@itam.mx">Email</a>
  </div>
</section>

<h2 class="kz-section-h">Research Areas</h2>
<div class="kz-areas">
  <div class="kz-area">
    <div class="kz-area-title">Health Economics</div>
    <div class="kz-area-body">
      Pharmaceutical policy, infectious disease, environmental exposures,
      and the economics of public health interventions.
    </div>
  </div>
  <div class="kz-area">
    <div class="kz-area-title">Network Economics</div>
    <div class="kz-area-body">
      How social and spatial connectivity shape the diffusion of disease,
      behavior, and economic activity.
    </div>
  </div>
  <div class="kz-area">
    <div class="kz-area-title">Family Economics</div>
    <div class="kz-area-body">
      Household decision-making, intergenerational transmission of health,
      and gendered consequences of shocks.
    </div>
  </div>
</div>

<h2 class="kz-section-h">News</h2>
<div class="kz-news">
  <ul>
    <li>
      <span class="kz-date">2026</span>
      <span class="kz-news-body">
        Forthcoming in <i>Health Economics</i>:
        <a href="/files/budgets.pdf"><i>The Financial and Behavioral Effects of Free Prescription Drugs</i></a>
        (with Gosia Majewska).
      </span>
    </li>
    <li>
      <span class="kz-date">2026</span>
      <span class="kz-news-body">
        <i>The Role of Dating Markets in Shaping Maternal and Neonatal Health</i> received an
        R&amp;R at the <i>Journal of Public Economics</i>.
      </span>
    </li>
    <li>
      <span class="kz-date">2025</span>
      <span class="kz-news-body">
        New working paper with Xinming Du:
        <a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5214598"><i>Lead Effects Through Generations</i></a>.
      </span>
    </li>
    <li>
      <span class="kz-date">2024</span>
      <span class="kz-news-body">
        <i>School Closures and Respiratory Infections</i> published in the
        <i>American Journal of Epidemiology</i>.
      </span>
    </li>
  </ul>
</div>

<h2 class="kz-section-h">Featured Research</h2>
<div class="kz-featured">

  <article class="kz-paper">
    <div class="kz-thumb"><img src="/images/Prop_vis_ols_mother.png" alt=""></div>
    <div>
      <div class="kz-meta">Working Paper · R&amp;R, Journal of Public Economics</div>
      <h3>
        <a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5218496" target="_blank">
          The Role of Dating Markets in Shaping Maternal and Neonatal Health
        </a>
      </h3>
      <p class="kz-pitch">
        First causal evidence that women's bargaining position in the dating market
        affects maternal and infant health. A novel sex-ratio instrument shows that
        racial disparities in incarceration explain 5–10% of Black–White gaps in
        adverse birth outcomes.
      </p>
      <div class="kz-links">
        <a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5218496" target="_blank">SSRN</a>
        <a href="/publications/">More</a>
      </div>
    </div>
  </article>

  <article class="kz-paper">
    <div class="kz-thumb"><img src="/images/Mexico_City_Lead.png" alt=""></div>
    <div>
      <div class="kz-meta">Working Paper · with Xinming Du</div>
      <h3>
        <a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5214598" target="_blank">
          Lead Effects Through Generations
        </a>
      </h3>
      <p class="kz-pitch">
        Mexico's leaded-gasoline phase-out reduced fetal mortality and infant
        deaths — and second-generation effects persist only in marginalized
        municipalities, showing how disadvantage mediates intergenerational
        transmission of environmental shocks.
      </p>
      <div class="kz-links">
        <a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5214598" target="_blank">SSRN</a>
        <a href="/publications/">More</a>
      </div>
    </div>
  </article>

  <article class="kz-paper">
    <div class="kz-thumb"><img src="/images/raw_avg_price_trt.png" alt=""></div>
    <div>
      <div class="kz-meta">Working Paper · with Gosia Majewska</div>
      <h3>
        <a href="/files/Majewska_Zaremba.pdf" target="_blank">
          Universal Subsidies in Pharmaceutical Markets: Lessons from Poland's Drugs 75+ Policy
        </a>
      </h3>
      <p class="kz-pitch">
        Free prescriptions for seniors raised access — and shifted demand toward
        more expensive products, increasing payer cost per dose of treatment. A
        case study in how removing price signals reshapes consumption.
      </p>
      <div class="kz-links">
        <a href="/files/Majewska_Zaremba.pdf" target="_blank">PDF</a>
        <a href="/publications/">More</a>
      </div>
    </div>
  </article>

</div>

<p style="text-align:center; margin-top:1.4em;">
  <a href="/publications/" style="font-size:0.92em; color:#1a365d; font-weight:500;">See all research →</a>
</p>

<h2 class="kz-section-h">Selected Visualizations</h2>

<div class="figure-card" style="max-width:700px; margin:1.5em auto; padding:1em; border:1px solid #e2e8f0; border-radius:8px; text-align:center; font-size:0.88em; color:#4a5568;">
  <img src="/images/Centrality_animated_cc.gif" alt="Network centrality animation" style="max-width:100%; border-radius:6px; margin-bottom:0.5em;">
  <p style="margin:0;"><b>Commuting-network centrality and the spread of COVID-19.</b> From <i>Opening of Hotels and Ski Facilities</i> (Health Economics, 2023).</p>
</div>

<div class="figure-card" style="max-width:700px; margin:1.5em auto; padding:1em; border:1px solid #e2e8f0; border-radius:8px; text-align:center; font-size:0.88em; color:#4a5568;">
  <img src="/images/Mexico_LWB.png" alt="Map of Mexico LWB" style="max-width:100%; border-radius:6px; margin-bottom:0.5em;">
  <p style="margin:0;"><b>Geographic variation in low birthweight across Mexico.</b> Municipal-level rates from administrative birth records.</p>
</div>

</div>
