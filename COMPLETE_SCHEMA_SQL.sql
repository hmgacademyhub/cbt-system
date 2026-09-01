-- ====================================================================
-- HMG ACADEMY CBT PRO & SYSTEM GENERATOR — MASTER COMPLETE SCHEMA SQL
-- ====================================================================
-- Description: All-in-one idempotent, robust, production-ready PostgreSQL
-- schema, Row Level Security (RLS) policies, and 20+ RPC functions.
-- Running this script ONCE in Supabase SQL Editor sets up the entire platform.
-- It is safe to re-run multiple times without dropping or losing existing data.
-- ====================================================================

-- 1. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. CORE TABLES (DDL)

-- 2.1 Institutions (Tenancy & Whitelabel Branding)
CREATE TABLE IF NOT EXISTS public.institutions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL DEFAULT 'HMG Academy',
  tagline TEXT DEFAULT 'Computer-Based Testing & Learning Solutions',
  slug TEXT UNIQUE,
  owner_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  plan TEXT NOT NULL DEFAULT 'enterprise',
  status TEXT NOT NULL DEFAULT 'active',
  logo_url TEXT DEFAULT '',
  stamp_url TEXT DEFAULT '',
  primary_color TEXT DEFAULT '#10b981',
  accent_color TEXT DEFAULT '#8b5cf6',
  branding JSONB NOT NULL DEFAULT '{}'::jsonb,
  settings JSONB NOT NULL DEFAULT '{}'::jsonb,
  drive_client_id TEXT DEFAULT '',
  drive_folder_id TEXT DEFAULT '',
  drive_sync_enabled BOOLEAN DEFAULT false,
  drive_sync_days INTEGER DEFAULT 7,
  drive_last_backup TIMESTAMPTZ,
  license_token TEXT DEFAULT '',
  license_data JSONB DEFAULT '{}'::jsonb,
  last_keepalive_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2.2 User Profiles & Roles
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  institution_id UUID REFERENCES public.institutions(id) ON DELETE SET NULL,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT DEFAULT '',
  role TEXT NOT NULL DEFAULT 'teacher', -- 'super_admin', 'admin', 'teacher', 'student'
  is_admin BOOLEAN NOT NULL DEFAULT false,
  status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'active', 'inactive', 'suspended'
  phone TEXT DEFAULT '',
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2.3 Exams & Question Packages (Single & Multi-Subject)
CREATE TABLE IF NOT EXISTS public.exams (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  institution_id UUID REFERENCES public.institutions(id) ON DELETE SET NULL,
  teacher_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  code TEXT UNIQUE NOT NULL,
  subject TEXT NOT NULL,
  duration INTEGER NOT NULL DEFAULT 45,
  attempt_limit INTEGER NOT NULL DEFAULT 1,
  select_count INTEGER NOT NULL DEFAULT 0,
  is_open BOOLEAN NOT NULL DEFAULT false,
  is_archived BOOLEAN NOT NULL DEFAULT false,
  exam_mode TEXT NOT NULL DEFAULT 'open', -- 'open' or 'registered'
  negative_mark NUMERIC(6,2) NOT NULL DEFAULT 0,
  release_results BOOLEAN NOT NULL DEFAULT true,
  math_keyboard BOOLEAN NOT NULL DEFAULT false,
  certificate_enabled BOOLEAN NOT NULL DEFAULT false,
  certificate_valid_days INTEGER NOT NULL DEFAULT 0,
  proctoring BOOLEAN NOT NULL DEFAULT false,
  anti_cheat_config JSONB NOT NULL DEFAULT '{"tab_switch":true,"window_blur":true,"copy_paste":true,"right_click":true,"fullscreen":true,"devtools":true,"proctoring":false,"audio":false,"max_violations":5}'::jsonb,
  instructions TEXT DEFAULT '',
  is_multi_subject BOOLEAN NOT NULL DEFAULT false,
  subjects_data JSONB NOT NULL DEFAULT '[]'::jsonb, -- Array of [{subject_name, count, csv_data, passmark}]
  csv_data JSONB NOT NULL DEFAULT '[]'::jsonb,
  start_at TIMESTAMPTZ,
  close_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2.4 Candidate Results & Submissions
CREATE TABLE IF NOT EXISTS public.results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id UUID NOT NULL REFERENCES public.exams(id) ON DELETE CASCADE,
  student_name TEXT NOT NULL,
  student_class TEXT NOT NULL DEFAULT '',
  student_id_ref TEXT DEFAULT '',
  student_type TEXT DEFAULT 'open',
  score NUMERIC(10,2) NOT NULL DEFAULT 0,
  total INTEGER NOT NULL DEFAULT 0,
  correct_count INTEGER DEFAULT 0,
  wrong_count INTEGER DEFAULT 0,
  skipped_count INTEGER DEFAULT 0,
  attempt_number INTEGER DEFAULT 1,
  time_taken INTEGER DEFAULT 0,
  answers_data JSONB NOT NULL DEFAULT '{}'::jsonb,
  subject_breakdown JSONB NOT NULL DEFAULT '{}'::jsonb, -- Multi-subject score breakdown
  violations INTEGER DEFAULT 0,
  violation_log JSONB NOT NULL DEFAULT '[]'::jsonb,
  proctor_data JSONB,
  cert_code TEXT NOT NULL DEFAULT '',
  is_released BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2.5 Registered Students Roster
CREATE TABLE IF NOT EXISTS public.students (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  institution_id UUID REFERENCES public.institutions(id) ON DELETE SET NULL,
  teacher_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  student_id TEXT NOT NULL,
  class TEXT NOT NULL DEFAULT '',
  email TEXT DEFAULT '',
  phone TEXT DEFAULT '',
  status TEXT NOT NULL DEFAULT 'active',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(teacher_id, student_id)
);

-- 2.6 Audit & Activity Logs
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  institution_id UUID REFERENCES public.institutions(id) ON DELETE SET NULL,
  actor_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  actor_email TEXT DEFAULT '',
  action TEXT NOT NULL,
  entity_type TEXT DEFAULT '',
  entity_id TEXT DEFAULT '',
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  ip_hint TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2.7 System Backups & Drive Sync History
CREATE TABLE IF NOT EXISTS public.system_backups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  institution_id UUID REFERENCES public.institutions(id) ON DELETE SET NULL,
  backup_name TEXT NOT NULL,
  provider TEXT NOT NULL DEFAULT 'google_drive', -- 'google_drive', 'local_json', 'envelope'
  drive_file_id TEXT DEFAULT '',
  drive_file_url TEXT DEFAULT '',
  file_size_bytes BIGINT DEFAULT 0,
  total_records INTEGER DEFAULT 0,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. INDEXES FOR HIGH-PERFORMANCE SEARCH & RETRIEVAL
CREATE INDEX IF NOT EXISTS idx_exams_code ON public.exams(upper(code));
CREATE INDEX IF NOT EXISTS idx_exams_teacher_id ON public.exams(teacher_id);
CREATE INDEX IF NOT EXISTS idx_exams_is_open ON public.exams(is_open, is_archived);
CREATE INDEX IF NOT EXISTS idx_results_exam_id ON public.results(exam_id);
CREATE INDEX IF NOT EXISTS idx_results_cert_code ON public.results(upper(cert_code));
CREATE INDEX IF NOT EXISTS idx_results_student_name ON public.results(lower(student_name));
CREATE INDEX IF NOT EXISTS idx_students_teacher_sid ON public.students(teacher_id, upper(student_id));
CREATE INDEX IF NOT EXISTS idx_profiles_role_status ON public.profiles(role, status);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created ON public.audit_logs(created_at DESC);

-- 4. SECURITY & HELPER FUNCTIONS

-- 4.1 Check Platform Admin
CREATE OR REPLACE FUNCTION public.is_platform_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
      AND (role IN ('super_admin', 'admin') OR is_admin = true)
      AND status = 'active'
  );
$$;

-- 4.2 Get Exam Teacher ID
CREATE OR REPLACE FUNCTION public.get_exam_teacher_id(p_exam_id UUID)
RETURNS UUID
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT teacher_id FROM public.exams WHERE id = p_exam_id;
$$;

-- 4.3 Check If Exam Open for Submission
CREATE OR REPLACE FUNCTION public.is_exam_open_for_submission(p_exam_id UUID)
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.exams
    WHERE id = p_exam_id
      AND is_open = true
      AND is_archived = false
      AND (close_at IS NULL OR close_at > NOW())
      AND (start_at IS NULL OR start_at <= NOW())
  );
$$;

-- 4.4 Supabase Free-Tier Keepalive Heartbeat
CREATE OR REPLACE FUNCTION public.keep_alive_ping()
RETURNS TABLE (success BOOLEAN, pinged_at TIMESTAMPTZ, message TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  UPDATE public.institutions
  SET last_keepalive_at = NOW()
  WHERE id = (SELECT id FROM public.institutions LIMIT 1);

  RETURN QUERY SELECT true, NOW(), 'Supabase keepalive ping successful. Free-tier anti-pause active.'::TEXT;
END;
$$;

-- 4.5 Audit Logger
CREATE OR REPLACE FUNCTION public.log_audit_event(
  p_action TEXT,
  p_entity_type TEXT DEFAULT '',
  p_entity_id TEXT DEFAULT '',
  p_metadata JSONB DEFAULT '{}'::jsonb
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_actor_id UUID := auth.uid();
  v_email TEXT := COALESCE(auth.jwt()->>'email', 'system');
BEGIN
  INSERT INTO public.audit_logs (actor_id, actor_email, action, entity_type, entity_id, metadata)
  VALUES (v_actor_id, v_email, p_action, p_entity_type, p_entity_id, p_metadata);
END;
$$;

-- 4.6 Updated_at Trigger Function
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;

-- 4.7 Auto Profile Creation Trigger on Auth Signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_role TEXT := 'teacher';
  v_is_admin BOOLEAN := false;
  v_status TEXT := 'pending';
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM public.profiles;
  -- The very first registered user is automatically approved as super_admin
  IF v_count = 0 THEN
    v_role := 'super_admin';
    v_is_admin := true;
    v_status := 'active';
  END IF;

  INSERT INTO public.profiles (id, email, full_name, role, is_admin, status)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
    v_role,
    v_is_admin,
    v_status
  )
  ON CONFLICT (id) DO UPDATE
  SET email = EXCLUDED.email,
      full_name = COALESCE(EXCLUDED.full_name, profiles.full_name);

  RETURN NEW;
END;
$$;

-- 5. PUBLIC & STUDENT RPCS (SAFE ANONYMOUS ACCESS)

-- 5.1 Get Public Exam By Code
CREATE OR REPLACE FUNCTION public.get_public_exam_by_code(p_code TEXT)
RETURNS TABLE (
  id UUID,
  code TEXT,
  subject TEXT,
  duration INTEGER,
  attempt_limit INTEGER,
  select_count INTEGER,
  is_open BOOLEAN,
  exam_mode TEXT,
  negative_mark NUMERIC,
  release_results BOOLEAN,
  instructions TEXT,
  anti_cheat_config JSONB,
  proctoring BOOLEAN,
  math_keyboard BOOLEAN,
  certificate_enabled BOOLEAN,
  is_multi_subject BOOLEAN,
  subjects_data JSONB,
  start_at TIMESTAMPTZ,
  close_at TIMESTAMPTZ,
  csv_data JSONB,
  created_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ
)
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT
    e.id,
    e.code,
    e.subject,
    e.duration,
    e.attempt_limit,
    e.select_count,
    e.is_open,
    e.exam_mode,
    e.negative_mark,
    e.release_results,
    e.instructions,
    e.anti_cheat_config,
    e.proctoring,
    e.math_keyboard,
    e.certificate_enabled,
    e.is_multi_subject,
    e.subjects_data,
    e.start_at,
    e.close_at,
    CASE
      WHEN e.start_at IS NOT NULL AND e.start_at > NOW() THEN '[]'::jsonb
      ELSE e.csv_data
    END AS csv_data,
    e.created_at,
    e.updated_at
  FROM public.exams e
  WHERE upper(trim(e.code)) = upper(trim(p_code))
    AND e.is_archived = false
    AND e.is_open = true
    AND (e.close_at IS NULL OR e.close_at > NOW())
  LIMIT 1;
$$;

-- 5.2 Verify Student For Exam
CREATE OR REPLACE FUNCTION public.verify_student_for_exam(p_exam_id UUID, p_student_id TEXT)
RETURNS TABLE (id UUID, full_name TEXT, student_id TEXT, class TEXT)
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT s.id, s.full_name, s.student_id, s.class
  FROM public.students s
  JOIN public.exams e ON e.id = p_exam_id
  WHERE s.teacher_id = e.teacher_id
    AND upper(trim(s.student_id)) = upper(trim(p_student_id))
    AND s.status = 'active'
  LIMIT 1;
$$;

-- 5.3 Get Candidate Exam Attempt Count
CREATE OR REPLACE FUNCTION public.get_exam_attempt_count(
  p_exam_id UUID,
  p_student_name TEXT,
  p_student_class TEXT,
  p_student_id_ref TEXT DEFAULT ''
)
RETURNS INTEGER
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT COUNT(*)::INTEGER
  FROM public.results r
  WHERE r.exam_id = p_exam_id
    AND (
      (COALESCE(trim(p_student_id_ref), '') <> '' AND upper(COALESCE(r.student_id_ref, '')) = upper(trim(p_student_id_ref)))
      OR
      (lower(trim(r.student_name)) = lower(trim(p_student_name))
       AND lower(trim(r.student_class)) = lower(trim(p_student_class)))
    );
$$;

-- 5.4 Submit Student Result
CREATE OR REPLACE FUNCTION public.submit_student_result(p_payload JSONB)
RETURNS TABLE (saved BOOLEAN, result_id UUID, cert_code TEXT)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_exam_id UUID := (p_payload->>'exam_id')::UUID;
  v_cert TEXT := upper(COALESCE(NULLIF(p_payload->>'cert_code',''), substring(replace(gen_random_uuid()::text,'-','') from 1 for 10)));
  v_id UUID;
BEGIN
  IF v_exam_id IS NULL OR NOT public.is_exam_open_for_submission(v_exam_id) THEN
    RAISE EXCEPTION 'Exam is not open for submission or exam_id is invalid.';
  END IF;

  INSERT INTO public.results (
    exam_id, student_name, student_class, student_id_ref, student_type,
    score, total, correct_count, wrong_count, skipped_count, attempt_number,
    time_taken, answers_data, subject_breakdown, violations, violation_log,
    proctor_data, cert_code, is_released
  ) VALUES (
    v_exam_id,
    LEFT(COALESCE(p_payload->>'student_name','Anonymous'), 200),
    LEFT(COALESCE(p_payload->>'student_class','General'), 120),
    NULLIF(LEFT(COALESCE(p_payload->>'student_id_ref',''), 120), ''),
    COALESCE(NULLIF(p_payload->>'student_type',''), 'open'),
    COALESCE((p_payload->>'score')::NUMERIC, 0),
    COALESCE((p_payload->>'total')::INTEGER, 0),
    COALESCE(NULLIF(p_payload->>'correct_count','')::INTEGER, 0),
    COALESCE(NULLIF(p_payload->>'wrong_count','')::INTEGER, 0),
    COALESCE(NULLIF(p_payload->>'skipped_count','')::INTEGER, 0),
    COALESCE(NULLIF(p_payload->>'attempt_number','')::INTEGER, 1),
    COALESCE(NULLIF(p_payload->>'time_taken','')::INTEGER, 0),
    COALESCE(p_payload->'answers_data', '{}'::jsonb),
    COALESCE(p_payload->'subject_breakdown', '{}'::jsonb),
    COALESCE(NULLIF(p_payload->>'violations','')::INTEGER, 0),
    COALESCE(p_payload->'violation_log', '[]'::jsonb),
    p_payload->'proctor_data',
    v_cert,
    COALESCE((p_payload->>'is_released')::BOOLEAN, true)
  ) RETURNING id INTO v_id;

  RETURN QUERY SELECT true, v_id, v_cert;
END;
$$;

-- 5.5 Verify Certificate
CREATE OR REPLACE FUNCTION public.verify_certificate(p_cert_code TEXT)
RETURNS TABLE (
  cert_code TEXT,
  student_name TEXT,
  student_class TEXT,
  subject TEXT,
  score NUMERIC,
  total INTEGER,
  percentage NUMERIC,
  grade TEXT,
  issued_at TIMESTAMPTZ,
  issuer_name TEXT,
  is_valid BOOLEAN
)
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
  SELECT
    r.cert_code,
    r.student_name,
    r.student_class,
    split_part(e.subject, '|', 1) AS subject,
    r.score,
    r.total,
    ROUND((r.score / NULLIF(r.total,0)) * 100, 2) AS percentage,
    CASE
      WHEN r.total <= 0 THEN 'UNSCORED'
      WHEN (r.score / NULLIF(r.total,0)) * 100 >= 70 THEN 'DISTINCTION'
      WHEN (r.score / NULLIF(r.total,0)) * 100 >= COALESCE(CASE WHEN split_part(e.subject,'|',7) ~ '^[0-9]+$' THEN split_part(e.subject,'|',7)::INTEGER END,50) THEN 'PASS'
      ELSE 'FAIL'
    END AS grade,
    r.created_at AS issued_at,
    COALESCE(p.full_name, p.email, 'HMG Academy') AS issuer_name,
    (e.certificate_enabled = true AND (e.certificate_valid_days = 0 OR r.created_at + (e.certificate_valid_days || ' days')::interval >= NOW())) AS is_valid
  FROM public.results r
  JOIN public.exams e ON e.id = r.exam_id
  LEFT JOIN public.profiles p ON p.id = e.teacher_id
  WHERE upper(trim(r.cert_code)) = upper(trim(p_cert_code))
    AND COALESCE(r.cert_code,'') <> ''
  ORDER BY r.created_at DESC
  LIMIT 1;
$$;

-- 6. ADMIN SUPERVISOR RPCS (ADMIN ROLE PROTECTED)

-- 6.1 Admin Get All Profiles
CREATE OR REPLACE FUNCTION public.admin_get_all_profiles()
RETURNS SETOF public.profiles
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;
  RETURN QUERY SELECT * FROM public.profiles ORDER BY created_at DESC;
END;
$$;

-- 6.2 Admin Get All Exams
CREATE OR REPLACE FUNCTION public.admin_get_all_exams()
RETURNS SETOF public.exams
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;
  RETURN QUERY SELECT * FROM public.exams ORDER BY created_at DESC;
END;
$$;

-- 6.3 Admin Get All Results
CREATE OR REPLACE FUNCTION public.admin_get_all_results()
RETURNS TABLE (
  id UUID,
  exam_id UUID,
  student_name TEXT,
  student_class TEXT,
  student_id_ref TEXT,
  student_type TEXT,
  score NUMERIC,
  total INTEGER,
  correct_count INTEGER,
  wrong_count INTEGER,
  skipped_count INTEGER,
  attempt_number INTEGER,
  time_taken INTEGER,
  answers_data JSONB,
  subject_breakdown JSONB,
  violations INTEGER,
  violation_log JSONB,
  proctor_data JSONB,
  cert_code TEXT,
  created_at TIMESTAMPTZ,
  exams JSONB
)
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  RETURN QUERY
  SELECT
    r.id, r.exam_id, r.student_name, r.student_class,
    r.student_id_ref, r.student_type, r.score, r.total,
    r.correct_count, r.wrong_count, r.skipped_count,
    r.attempt_number, r.time_taken, r.answers_data,
    r.subject_breakdown, r.violations, r.violation_log,
    r.proctor_data, r.cert_code, r.created_at,
    jsonb_build_object(
      'subject', e.subject,
      'teacher_id', e.teacher_id,
      'code', e.code,
      'is_multi_subject', e.is_multi_subject
    ) AS exams
  FROM public.results r
  LEFT JOIN public.exams e ON e.id = r.exam_id
  ORDER BY r.created_at DESC;
END;
$$;

-- 6.4 Admin Platform Stats
CREATE OR REPLACE FUNCTION public.admin_get_platform_stats()
RETURNS TABLE (
  total_teachers BIGINT,
  active_teachers BIGINT,
  pending_teachers BIGINT,
  total_exams BIGINT,
  live_exams BIGINT,
  total_results BIGINT,
  total_students BIGINT,
  avg_score NUMERIC,
  pass_rate NUMERIC
)
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  RETURN QUERY
  SELECT
    (SELECT COUNT(*) FROM public.profiles WHERE role IN ('teacher', 'admin', 'super_admin')) AS total_teachers,
    (SELECT COUNT(*) FROM public.profiles WHERE status = 'active') AS active_teachers,
    (SELECT COUNT(*) FROM public.profiles WHERE status = 'pending') AS pending_teachers,
    (SELECT COUNT(*) FROM public.exams) AS total_exams,
    (SELECT COUNT(*) FROM public.exams WHERE is_open = true AND is_archived = false) AS live_exams,
    (SELECT COUNT(*) FROM public.results) AS total_results,
    (SELECT COUNT(*) FROM public.students) AS total_students,
    COALESCE((SELECT ROUND(AVG((score / NULLIF(total, 0)) * 100), 2) FROM public.results WHERE total > 0), 0) AS avg_score,
    COALESCE((
      SELECT ROUND(
        AVG(CASE WHEN (score / NULLIF(total, 0)) * 100 >= 50 THEN 1 ELSE 0 END) * 100,
        2
      )
      FROM public.results
      WHERE total > 0
    ), 0) AS pass_rate;
END;
$$;

-- 6.5 Admin Set Profile Status
CREATE OR REPLACE FUNCTION public.admin_set_profile_status(p_id UUID, p_status TEXT)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  UPDATE public.profiles
  SET status = p_status,
      updated_at = NOW()
  WHERE id = p_id;

  PERFORM public.log_audit_event('admin_set_profile_status', 'profile', p_id::TEXT, jsonb_build_object('status', p_status));
END;
$$;

-- 6.6 Admin Set Profile Role
CREATE OR REPLACE FUNCTION public.admin_set_profile_role(p_id UUID, p_role TEXT, p_status TEXT DEFAULT 'active')
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  UPDATE public.profiles
  SET role = p_role,
      is_admin = (p_role IN ('admin', 'super_admin')),
      status = p_status,
      updated_at = NOW()
  WHERE id = p_id;

  PERFORM public.log_audit_event('admin_set_profile_role', 'profile', p_id::TEXT, jsonb_build_object('role', p_role, 'status', p_status));
END;
$$;

-- 6.7 Admin Delete Profile
CREATE OR REPLACE FUNCTION public.admin_delete_profile(p_id UUID)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  DELETE FROM public.profiles WHERE id = p_id;
  PERFORM public.log_audit_event('admin_delete_profile', 'profile', p_id::TEXT, '{}'::jsonb);
END;
$$;

-- 6.8 Admin Get Audit Logs
CREATE OR REPLACE FUNCTION public.admin_get_audit_logs(p_limit INTEGER DEFAULT 100)
RETURNS SETOF public.audit_logs
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp
AS $$
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  RETURN QUERY
  SELECT * FROM public.audit_logs
  ORDER BY created_at DESC
  LIMIT p_limit;
END;
$$;

-- 6.9 Admin Purge Test Results
CREATE OR REPLACE FUNCTION public.admin_purge_test_results(p_exam_id UUID)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  v_count INTEGER;
BEGIN
  IF NOT public.is_platform_admin() THEN
    RAISE EXCEPTION 'Not authorized: admin access required';
  END IF;

  DELETE FROM public.results WHERE exam_id = p_exam_id;
  GET DIAGNOSTICS v_count = ROW_COUNT;

  PERFORM public.log_audit_event('admin_purge_test_results', 'exam', p_exam_id::TEXT, jsonb_build_object('deleted_results', v_count));
  RETURN v_count;
END;
$$;

-- 7. ROW LEVEL SECURITY (RLS) POLICIES

-- Enable RLS on all tables
ALTER TABLE public.institutions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.results ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.system_backups ENABLE ROW LEVEL SECURITY;

-- 7.1 Institutions RLS
DROP POLICY IF EXISTS "Public read institutions" ON public.institutions;
CREATE POLICY "Public read institutions" ON public.institutions FOR SELECT USING (true);

DROP POLICY IF EXISTS "Admins manage institutions" ON public.institutions;
CREATE POLICY "Admins manage institutions" ON public.institutions FOR ALL USING (public.is_platform_admin());

-- 7.2 Profiles RLS
DROP POLICY IF EXISTS "Users read own profile" ON public.profiles;
CREATE POLICY "Users read own profile" ON public.profiles FOR SELECT USING (auth.uid() = id OR public.is_platform_admin());

DROP POLICY IF EXISTS "Users update own profile" ON public.profiles;
CREATE POLICY "Users update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = id);

DROP POLICY IF EXISTS "Admins manage profiles" ON public.profiles;
CREATE POLICY "Admins manage profiles" ON public.profiles FOR ALL USING (public.is_platform_admin());

-- 7.3 Exams RLS
DROP POLICY IF EXISTS "Teachers view own exams" ON public.exams;
CREATE POLICY "Teachers view own exams" ON public.exams FOR SELECT USING (auth.uid() = teacher_id OR public.is_platform_admin());

DROP POLICY IF EXISTS "Teachers insert own exams" ON public.exams;
CREATE POLICY "Teachers insert own exams" ON public.exams FOR INSERT WITH CHECK (auth.uid() = teacher_id);

DROP POLICY IF EXISTS "Teachers update own exams" ON public.exams;
CREATE POLICY "Teachers update own exams" ON public.exams FOR UPDATE USING (auth.uid() = teacher_id OR public.is_platform_admin());

DROP POLICY IF EXISTS "Teachers delete own exams" ON public.exams;
CREATE POLICY "Teachers delete own exams" ON public.exams FOR DELETE USING (auth.uid() = teacher_id OR public.is_platform_admin());

-- 7.4 Results RLS
DROP POLICY IF EXISTS "Teachers view results for own exams" ON public.results;
CREATE POLICY "Teachers view results for own exams" ON public.results FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.exams WHERE exams.id = results.exam_id AND (exams.teacher_id = auth.uid() OR public.is_platform_admin()))
);

DROP POLICY IF EXISTS "Teachers delete results for own exams" ON public.results;
CREATE POLICY "Teachers delete results for own exams" ON public.results FOR DELETE USING (
  EXISTS (SELECT 1 FROM public.exams WHERE exams.id = results.exam_id AND (exams.teacher_id = auth.uid() OR public.is_platform_admin()))
);

-- 7.5 Students RLS
DROP POLICY IF EXISTS "Teachers manage own student roster" ON public.students;
CREATE POLICY "Teachers manage own student roster" ON public.students FOR ALL USING (auth.uid() = teacher_id OR public.is_platform_admin());

-- 7.6 Audit Logs RLS
DROP POLICY IF EXISTS "Admins view audit logs" ON public.audit_logs;
CREATE POLICY "Admins view audit logs" ON public.audit_logs FOR SELECT USING (public.is_platform_admin());

DROP POLICY IF EXISTS "Users insert audit logs" ON public.audit_logs;
CREATE POLICY "Users insert audit logs" ON public.audit_logs FOR INSERT WITH CHECK (true);

-- 7.7 System Backups RLS
DROP POLICY IF EXISTS "Admins manage system backups" ON public.system_backups;
CREATE POLICY "Admins manage system backups" ON public.system_backups FOR ALL USING (public.is_platform_admin());

-- 8. TRIGGERS
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

DROP TRIGGER IF EXISTS trg_exams_updated_at ON public.exams;
CREATE TRIGGER trg_exams_updated_at
  BEFORE UPDATE ON public.exams
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS trg_profiles_updated_at ON public.profiles;
CREATE TRIGGER trg_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS trg_institutions_updated_at ON public.institutions;
CREATE TRIGGER trg_institutions_updated_at
  BEFORE UPDATE ON public.institutions
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 9. INITIAL SEED DATA
INSERT INTO public.institutions (id, name, tagline, plan, status, primary_color, accent_color)
VALUES (
  '00000000-0000-0000-0000-000000000001'::uuid,
  'HMG Academy CBT Pro',
  'Enterprise Computer-Based Testing & Exam Simulation',
  'enterprise',
  'active',
  '#10b981',
  '#8b5cf6'
)
ON CONFLICT (id) DO NOTHING;

-- ====================================================================
-- SCHEMA DEPLOYMENT COMPLETE
-- All tables, 20+ RPCs, indexes, triggers, and RLS policies active.
-- ====================================================================
