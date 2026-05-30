# Security Policy — HMG Academy CBT Pro

## Supported Version

Only the current `main` branch / current deployment is actively maintained.

---

## Reporting a Vulnerability

Do **not** open a public GitHub issue for security problems.

Email:

```text
buildingmyictcareer@gmail.com
Subject: CBT Pro Security Report
```

Include:

- affected file
- steps to reproduce
- impact
- screenshots/video where useful
- suggested fix if available

Expected response: acknowledgement within 72 hours, practical follow-up as soon as possible.

---

## Security Model

### Supabase anon key

The Supabase anon key is visible in frontend HTML files by design. It is safe only because Supabase Row Level Security controls what that key can do.

The `service_role` key must **never** appear in any frontend file.

### Row Level Security

RLS must protect:

- `exams`
- `results`
- `students`
- `profiles`

Teachers should only access their own exams, students, and results. Students should only read exams by code and insert result rows.

### Teacher authentication

Teacher accounts use Supabase Auth. The dashboard checks profile status before giving access.

Possible statuses:

- `pending`
- `active`
- `inactive`

### Admin access

Admin control should rely on `profiles.is_admin === true`, not a loose client-side role string. Admin RPC functions must be protected server-side.

### Result integrity

The student browser writes:

- `score`
- `total`
- `correct_count`
- `wrong_count`
- `skipped_count`
- `answers_data`

The teacher dashboard reads these stored values. It should not replace them with re-scored values from an edited question bank.

### Question content and XSS

Question text, options, explanations, and JSON-based items must be escaped before rendering into HTML. Any contribution that inserts raw untrusted content into `innerHTML` must be reviewed carefully.

---

## Anti-Cheat and Proctoring Limits

The platform includes client-side integrity checks:

- tab switch detection
- fullscreen exit detection
- right-click/copy/paste blocking
- devtools warning
- optional webcam snapshots
- optional face checks
- optional audio spike detection

These are deterrents, not perfect security. Physical supervision and school policy remain important.

---

## Emergency Backup JSON

If Supabase saving fails, students can download a result backup JSON. This file may contain sensitive data such as answers, scores, violation logs, and proctoring data. Teachers must store it responsibly.

---

## Known Accepted Risks

| Risk | Mitigation |
|---|---|
| Open-mode students can use another name | Use registered-student mode for strict exams |
| Camera/microphone can be denied | Proctoring degrades gracefully; use physical supervision where needed |
| Client-side anti-cheat can be bypassed | Use it as evidence, not as the only control |
| Offline submission may fail | Emergency backup JSON exists |
| Essay scoring is keyword-based | Teacher review recommended; no paid AI API used |

---

## In Scope

- RLS bypass
- teacher data leakage
- admin privilege escalation
- XSS from question content
- unauthorized result modification
- leaked `service_role` key
- ability to read another teacher’s roster/results

## Out of Scope

- a student using a second device
- a student denying camera permission
- open-mode impersonation by using another name
- weak school passwords chosen by users
- physical exam-room cheating outside browser visibility

---

## Security Checklist Before Deployment

1. Confirm `service_role` key is not in any file.
2. Run all Supabase RLS SQL steps.
3. Run Teacher Dashboard → Settings → Diagnostic.
4. Test a teacher cannot query another teacher’s data.
5. Test anonymous users cannot read `results` directly.
6. Configure Supabase Auth redirect URLs.
7. Use HTTPS hosting only.
8. Keep backups of exported exam packages secure.
