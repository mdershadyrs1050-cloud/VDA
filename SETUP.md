# SKYNESS production deployment (GoDaddy hosting-type independent)

## Important: this is a configurable production integration, NOT live until setup completes
The site is static HTML/CSS/JS and can be served by cPanel hosting, GoDaddy Web Hosting, or any static-file hosting that allows custom HTML uploads. **GoDaddy Website Builder / Managed WordPress may require a different deployment method.**

## 1. Supabase
1. Create a Supabase project under your own account.
2. SQL Editor > run `schema.sql`. If rerunning after policies already exist, delete existing policies or run only once.
3. Authentication > Users > Add user (admin email and a strong password). Use the requested password only if you accept the risks; ideally use a new unique strong password and MFA. Never put it in config.js or public source.
4. Copy the user's UUID. SQL Editor: `insert into public.admin_users(user_id) values ('UUID_HERE');`
5. Project Settings > API: copy Project URL and **publishable/anon key** into `config.js`. **NEVER** copy a service_role/secret key into public files.
6. Test: submit VDA request in one browser; sign in at admin.html in another. Check it appears, and status updates. Test unauthorized user cannot see requests.

## 2. Email alerts (NOT configured by this package)
To send email on new enquiries, create a secure server-side notification using a Supabase Database Webhook or Edge Function and an email provider such as Resend, with secrets stored server-side. Do NOT put SMTP or email API secrets in JS. Until configured, admin panel shows submitted VDA requests but **no email is sent**.

## 3. Before public launch
- Add CAPTCHA or a server-side rate limit to public forms; otherwise spam can overwhelm your database.
- Review privacy notice, retention/deletion policy, and legal requirements for VDA services in India.
- Configure allowed Auth redirect URLs, enable HTTPS, and confirm database policies.
- Change old exposed demo passwords; do not use `skyness-demo` or client-side password checks.
- Back up current GoDaddy files before replacing. Do not upload ZIP into document root without extracting it correctly.

## 4. GoDaddy upload
If **cPanel**: open File Manager > public_html, back up current website, upload and extract all files from the ZIP into `public_html` (index.html must be directly inside public_html). Confirm SSL and domain routing.
If **Managed WordPress** or **Websites + Marketing**: do not overwrite WordPress or builder files with this ZIP. First determine the hosting product and use an appropriate separate static hosting or migration method.

## 5. What works when configured
- VDA form inserts into Supabase shared database.
- Admin signs in through Supabase Auth; access controlled by admin_users and row-level security.
- Admin can view enquiries from any device and update statuses.
- General contact form inserts into contact_enquiries (not displayed in current admin UI).

## Limitations
- Email alerts, CAPTCHA, compliance and live testing still need configuration.
- Supabase free plan limits and pricing may change.
- Do not claim production launch complete until a real end-to-end test passes.
