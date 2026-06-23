# SEO, PWA Installability and Lead Generation Setup

Date: 2026-06-23

## Goal

Make HMG Academy CBT Pro discoverable by search engines, installable on phones/computers, and useful for sending interested schools, teachers, tutors and partners into the wider HMG Concepts ecosystem.

## SEO files added

- `robots.txt` — allows all major search engines to crawl the static platform and points them to the sitemap.
- `sitemap.xml` — lists the important public pages for indexing.
- `llms.txt` — gives AI/search assistants a clear summary of HMG Academy CBT Pro and the HMG ecosystem.
- `browserconfig.xml` — improves Windows tile/PWA metadata.

## SEO metadata added

`index.html` now includes:

- descriptive title;
- meta description;
- keywords;
- author;
- canonical URL;
- robots/googlebot/bingbot tags;
- Open Graph tags for WhatsApp/Facebook/LinkedIn sharing;
- Twitter card tags;
- structured JSON-LD data for Organization, EducationalOrganization, SoftwareApplication and WebSite.

Other key pages also include descriptions, robots tags and PWA metadata.

## Lead-generation improvements

The landing page now links clearly to:

- HMG Academy — `https://hmgacademy.pages.dev/`
- HMG Concepts — `https://hmgconcepts.pages.dev/`
- HMG Technologies/project enquiry by email;
- WhatsApp lead enquiry to `+234 810 086 6322`.

A new HMG ecosystem section explains how the CBT platform connects to HMG Academy, HMG Concepts and HMG Technologies.

## PWA/installability improvements

The platform already had a manifest and service worker. This update strengthens installability by adding:

- improved `manifest.webmanifest` metadata;
- app id, app category, language and display overrides;
- mobile-web-app and Apple web-app meta tags;
- service-worker caching for extra public support files;
- landing-page install CTA;
- device-specific install instructions for Android, iPhone/iPad, Windows, macOS and Chromebook.

## Important deployment notes

For search engines to discover the platform:

1. Deploy all files to the live root/repository path.
2. Confirm these URLs open publicly:
   - `/robots.txt`
   - `/sitemap.xml`
   - `/manifest.webmanifest`
   - `/index.html`
3. Submit the sitemap to Google Search Console and Bing Webmaster Tools:
   - `https://hmgacademyhub.github.io/cbtplatform/sitemap.xml`
4. Share the landing page link on HMG Academy, HMG Concepts, WhatsApp, LinkedIn and other public profiles.
5. Keep the page title and description focused on school CBT, online exams and HMG Concepts.

## PWA installation test

- Android Chrome: open the site → menu → Install app/Add to Home screen.
- iPhone Safari: open the site → Share → Add to Home Screen.
- Windows/Mac Chrome or Edge: install icon in address bar or browser menu → Install.

## No paid tools required

All SEO and PWA features use free static files and browser-native PWA standards. No paid SEO service, AI API or app store publication is required.
