-- ═══════════════════════════════════════════════════════════════════
-- HMG ACADEMY CBT PRO v3.0 — COMPLETE DATABASE SETUP (CORRECTED)
-- ═══════════════════════════════════════════════════════════════════
-- Run ALL statements below in order inside:
-- Supabase Dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════════
-- This single file creates every table, enables security,
-- adds all policies, helper functions, and verification checks.
-- FIXED: Correct column alignment between table creation and usage.
-- FIXED: Proper foreign key references and consistent data types.
-- ═══════════════════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════════════════
-- STEP 1: CREATE THE EXAMS TABLE
-- ═══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS exams (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id    UUID        NOT NULL,
  code          TEXT        UNIQUE NOT NULL,
  subject       TEXT        NOT NULL,
  duration      INTEGER     NOT NULL DEFAULT 45,
  attempt_limit INTEGER     NOT NULL DEFAULT 1,
  select_count  INTEGER     NOT NULL DEFAULT 0,
  is_open       BOOLEAN     NOT NULL DEFAULT false,
  exam_mode     TEXT        NOT NULL DEFAULT 'open',
  negative_mark NUMERIC     DEFAULT 0,
  release_results BOOLEAN   DEFAULT true,
  instructions  TEXT        DEFAULT '',
  is_archived   BOOLEAN     DEFAULT false,
  cert_code     TEXT        DEFAULT '',
  start_at      TIMESTAMPTZ,
  close_at      TIMESTAMPTZ,
  csv_data      JSONB       NOT NULL DEFAULT '[]'::jsonb,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_exams_teacher_id ON exams(teacher_id);
CREATE INDEX IF NOT EXISTS idx_exams_code ON exams(code);
CREATE INDEX IF NOT EXISTS idx_exams_is_open ON exams(is_open);
CREATE INDEX IF NOT EXISTS idx_exams_created_at ON exams(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_exams_archived ON exams(is_archived);

-- ═══════════════════════════════════════════════════════════════════
-- STEP 2: CREATE THE RESULTS TABLE
-- ═══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS results (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id         UUID        NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
  student_name    TEXT        NOT NULL,
  student_class   TEXT        NOT NULL DEFAULT '',
  student_id_ref  TEXT        DEFAULT '',
  student_type    TEXT        DEFAULT 'open',
  score           INTEGER     NOT NULL DEFAULT 0,
  total           INTEGER     NOT NULL DEFAULT 0,
  correct_count   INTEGER     DEFAULT NULL,
  wrong_count     INTEGER     DEFAULT NULL,
  skipped_count   INTEGER     DEFAULT NULL,
  attempt_number  INTEGER     DEFAULT 1,
  time_taken      INTEGER     DEFAULT 0,
  answers_data    JSONB,
  violations      INTEGER     DEFAULT 0,
  violation_log   JSONB       DEFAULT '[]'::jsonb,
  proctor_data    JSONB,
  cert_code       TEXT        DEFAULT '',
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_results_exam_id ON results(exam_id);
CREATE INDEX IF NOT EXISTS idx_results_student_name ON results(student_name);
CREATE INDEX IF NOT EXISTS idx_results_created_at ON results(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_results_violations ON results(violations);

-- ═══════════════════════════════════════════════════════════════════
-- STEP 3: CREATE THE PROFILES TABLE
-- ═══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS profiles (
  id          UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email       TEXT        UNIQUE NOT NULL,
  full_name   TEXT        DEFAULT '',
  role        TEXT        NOT NULL DEFAULT 'teacher',
  is_admin    BOOLEAN     NOT NULL DEFAULT false,
  status      TEXT        NOT NULL DEFAULT 'pending',
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_profiles_status ON profiles(status);
CREATE INDEX IF NOT EXISTS idx_profiles_email ON profiles(email);
CREATE INDEX IF NOT EXISTS idx_profiles_is_admin ON profiles(is_admin);

-- ═══════════════════════════════════════════════════════════════════
-- STEP 4: CREATE THE STUDENTS TABLE
-- ═══════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS students (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id  UUID        NOT NULL,
  full_name   TEXT        NOT NULL,
  student_id  TEXT        NOT NULL,
  class       TEXT        NOT NULL DEFAULT '',
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(teacher_id, student_id)
);

CREATE INDEX IF NOT EXISTS idx_students_teacher_id ON students(teacher_id);
CREATE INDEX IF NOT EXISTS idx_students_student_id ON students(student_id);
CREATE INDEX IF NOT EXISTS idx_students_class ON students(class);

-- ═══════════════════════════════════════════════════════════════════
-- STEP 5: ADD MISSING COLUMNS (Safe for upgrades)
-- ═══════════════════════════════════════════════════════════════════

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='exam_mode') THEN
    ALTER TABLE exams ADD COLUMN exam_mode TEXT NOT NULL DEFAULT 'open';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='start_at') THEN
    ALTER TABLE exams ADD COLUMN start_at TIMESTAMPTZ;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='close_at') THEN
    ALTER TABLE exams ADD COLUMN close_at TIMESTAMPTZ;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='updated_at') THEN
    ALTER TABLE exams ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='negative_mark') THEN
    ALTER TABLE exams ADD COLUMN negative_mark NUMERIC DEFAULT 0;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='release_results') THEN
    ALTER TABLE exams ADD COLUMN release_results BOOLEAN DEFAULT true;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='instructions') THEN
    ALTER TABLE exams ADD COLUMN instructions TEXT DEFAULT '';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='is_archived') THEN
    ALTER TABLE exams ADD COLUMN is_archived BOOLEAN DEFAULT false;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='exams' AND column_name='cert_code') THEN
    ALTER TABLE exams ADD COLUMN cert_code TEXT DEFAULT '';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='student_id_ref') THEN
    ALTER TABLE results ADD COLUMN student_id_ref TEXT DEFAULT '';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='student_type') THEN
    ALTER TABLE results ADD COLUMN student_type TEXT DEFAULT 'open';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='answers_data') THEN
    ALTER TABLE results ADD COLUMN answers_data JSONB;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='time_taken') THEN
    ALTER TABLE results ADD COLUMN time_taken INTEGER DEFAULT 0;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='violations') THEN
    ALTER TABLE results ADD COLUMN violations INTEGER DEFAULT 0;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='violation_log') THEN
    ALTER TABLE results ADD COLUMN violation_log JSONB DEFAULT '[]'::jsonb;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='proctor_data') THEN
    ALTER TABLE results ADD COLUMN proctor_data JSONB;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='correct_count') THEN
    ALTER TABLE results ADD COLUMN correct_count INTEGER DEFAULT NULL;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='wrong_count') THEN
    ALTER TABLE results ADD COLUMN wrong_count INTEGER DEFAULT NULL;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='skipped_count') THEN
    ALTER TABLE results ADD COLUMN skipped_count INTEGER DEFAULT NULL;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='attempt_number') THEN
    ALTER TABLE results ADD COLUMN attempt_number INTEGER DEFAULT 1;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='cert_code') THEN
    ALTER TABLE results ADD COLUMN cert_code TEXT DEFAULT '';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='student_class') THEN
    ALTER TABLE results ADD COLUMN student_class TEXT NOT NULL DEFAULT '';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='profiles' AND column_name='role') THEN
    ALTER TABLE profiles ADD COLUMN role TEXT NOT NULL DEFAULT 'teacher';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='profiles' AND column_name='is_admin') THEN
    ALTER TABLE profiles ADD COLUMN is_admin BOOLEAN NOT NULL DEFAULT false;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='profiles' AND column_name='status') THEN
    ALTER TABLE profiles ADD COLUMN status TEXT NOT NULL DEFAULT 'pending';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='profiles' AND column_name='updated_at') THEN
    ALTER TABLE profiles ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='profiles' AND column_name='full_name') THEN
    ALTER TABLE profiles ADD COLUMN full_name TEXT DEFAULT '';
  END IF;
END $$;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 6: ENABLE ROW-LEVEL SECURITY (RLS) ON ALL TABLES
-- ═══════════════════════════════════════════════════════════════════

ALTER TABLE exams    ENABLE ROW LEVEL SECURITY;
ALTER TABLE results  ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 7: DROP EXISTING POLICIES (Clean slate — idempotent)
-- ═══════════════════════════════════════════════════════════════════

DROP POLICY IF EXISTS "Teachers select own exams" ON exams;
DROP POLICY IF EXISTS "Teachers insert own exams" ON exams;
DROP POLICY IF EXISTS "Teachers update own exams" ON exams;
DROP POLICY IF EXISTS "Teachers delete own exams" ON exams;
DROP POLICY IF EXISTS "Teachers see own exams" ON exams;
DROP POLICY IF EXISTS "Students can read exams by code" ON exams;
DROP POLICY IF EXISTS "Teachers select own results" ON results;
DROP POLICY IF EXISTS "Students can submit results" ON results;
DROP POLICY IF EXISTS "Teachers update own results" ON results;
DROP POLICY IF EXISTS "Teachers delete own results" ON results;
DROP POLICY IF EXISTS "Teachers see own results" ON results;
DROP POLICY IF EXISTS "Users read own profile" ON profiles;
DROP POLICY IF EXISTS "Allow profile insert" ON profiles;
DROP POLICY IF EXISTS "Users update own profile" ON profiles;
DROP POLICY IF EXISTS "Teachers select own students" ON students;
DROP POLICY IF EXISTS "Teachers insert own students" ON students;
DROP POLICY IF EXISTS "Teachers update own students" ON students;
DROP POLICY IF EXISTS "Teachers delete own students" ON students;
DROP POLICY IF EXISTS "Teachers manage own students" ON students;
DROP POLICY IF EXISTS "Anyone can verify student ID" ON students;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 8: CREATE ALL RLS POLICIES
-- ═══════════════════════════════════════════════════════════════════

-- Exams: Teachers only see/create/update/delete their own
CREATE POLICY "Teachers select own exams"
  ON exams FOR SELECT TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers insert own exams"
  ON exams FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = teacher_id);

CREATE POLICY "Teachers update own exams"
  ON exams FOR UPDATE TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers delete own exams"
  ON exams FOR DELETE TO authenticated
  USING (auth.uid() = teacher_id);

-- Students (anonymous) can read any exam by code
CREATE POLICY "Students can read exams by code"
  ON exams FOR SELECT TO anon
  USING (true);

-- Results: Teachers see results for their own exams only
-- Uses SECURITY DEFINER helper function to avoid RLS recursive deadlock
CREATE POLICY "Teachers select own results"
  ON results FOR SELECT TO authenticated
  USING (auth.uid() = get_exam_teacher_id(exam_id));

CREATE POLICY "Students can submit results"
  ON results FOR INSERT TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Teachers update own results"
  ON results FOR UPDATE TO authenticated
  USING (auth.uid() = get_exam_teacher_id(exam_id));

CREATE POLICY "Teachers delete own results"
  ON results FOR DELETE TO authenticated
  USING (auth.uid() = get_exam_teacher_id(exam_id));

-- Profiles: Teachers can only see/update their own
CREATE POLICY "Users read own profile"
  ON profiles FOR SELECT TO authenticated
  USING (auth.uid() = id);

CREATE POLICY "Allow profile insert"
  ON profiles FOR INSERT WITH CHECK (true);

CREATE POLICY "Users update own profile"
  ON profiles FOR UPDATE TO authenticated
  USING (auth.uid() = id);

-- Students: Teachers manage their own roster
CREATE POLICY "Teachers select own students"
  ON students FOR SELECT TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers insert own students"
  ON students FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = teacher_id);

CREATE POLICY "Teachers update own students"
  ON students FOR UPDATE TO authenticated
  USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers delete own students"
  ON students FOR DELETE TO authenticated
  USING (auth.uid() = teacher_id);

-- Anonymous users can verify student ID during exam entry
CREATE POLICY "Anyone can verify student ID"
  ON students FOR SELECT TO anon
  USING (true);

-- ═══════════════════════════════════════════════════════════════════
-- STEP 9: GRANT PERMISSIONS FOR TRIGGER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════

GRANT ALL ON public.profiles TO postgres;
GRANT ALL ON public.profiles TO service_role;
GRANT ALL ON public.students TO postgres;
GRANT ALL ON public.students TO service_role;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 10: CREATE SECURITY DEFINER HELPER FUNCTION
-- ═══════════════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.get_exam_teacher_id(p_exam_id UUID)
RETURNS UUID
LANGUAGE SQL
SECURITY DEFINER
STABLE
AS $$
  SELECT teacher_id FROM public.exams WHERE id = p_exam_id LIMIT 1;
$$;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 11: CREATE AUTO-SIGNUP TRIGGER
-- ═══════════════════════════════════════════════════════════════════

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP FUNCTION IF EXISTS public.handle_new_user();

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE PLPGSQL
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role, is_admin, status)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name',
             NEW.raw_user_meta_data->>'display_name',
             split_part(NEW.email, '@', 1)),
    'teacher',
    false,
    'pending'
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
EXCEPTION
  WHEN others THEN
    RAISE WARNING 'handle_new_user trigger failed: %', SQLERRM;
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- ═══════════════════════════════════════════════════════════════════
-- STEP 12: CREATE AUTO-UPDATE TIMESTAMP TRIGGERS
-- ═══════════════════════════════════════════════════════════════════

DROP TRIGGER IF EXISTS update_exams_updated_at ON exams;
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;

CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_exams_updated_at
  BEFORE UPDATE ON exams
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

-- ═══════════════════════════════════════════════════════════════════
-- STEP 13: ADMIN RPC FUNCTIONS (Required for admin panel)
-- ═══════════════════════════════════════════════════════════════════

DROP FUNCTION IF EXISTS public.admin_get_all_profiles() CASCADE;
DROP FUNCTION IF EXISTS public.admin_get_all_exams() CASCADE;
DROP FUNCTION IF EXISTS public.admin_get_all_results() CASCADE;
DROP FUNCTION IF EXISTS public.admin_set_profile_status(UUID, TEXT) CASCADE;
DROP FUNCTION IF EXISTS public.admin_set_profile_role(UUID, TEXT, TEXT) CASCADE;
DROP FUNCTION IF EXISTS public.admin_delete_profile(UUID) CASCADE;
DROP FUNCTION IF EXISTS public.admin_get_platform_stats() CASCADE;
DROP FUNCTION IF EXISTS public.admin_get_exam_results(UUID) CASCADE;

CREATE OR REPLACE FUNCTION public.admin_get_all_profiles()
RETURNS SETOF public.profiles
LANGUAGE SQL SECURITY DEFINER STABLE
AS $$ SELECT * FROM public.profiles ORDER BY created_at DESC; $$;

CREATE OR REPLACE FUNCTION public.admin_get_all_exams()
RETURNS SETOF public.exams
LANGUAGE SQL SECURITY DEFINER STABLE
AS $$ SELECT * FROM public.exams ORDER BY created_at DESC; $$;

CREATE OR REPLACE FUNCTION public.admin_get_all_results()
RETURNS TABLE (
  id              UUID,
  exam_id         UUID,
  student_name    TEXT,
  student_class   TEXT,
  student_id_ref  TEXT,
  student_type    TEXT,
  score           INTEGER,
  total           INTEGER,
  correct_count   INTEGER,
  wrong_count     INTEGER,
  skipped_count   INTEGER,
  attempt_number  INTEGER,
  time_taken      INTEGER,
  answers_data    JSONB,
  violations      INTEGER,
  violation_log   JSONB,
  proctor_data    JSONB,
  cert_code       TEXT,
  created_at      TIMESTAMPTZ,
  exams           JSONB
)
LANGUAGE SQL SECURITY DEFINER STABLE
AS $$
  SELECT
    r.id, r.exam_id, r.student_name, r.student_class,
    r.student_id_ref, r.student_type, r.score, r.total,
    r.correct_count, r.wrong_count, r.skipped_count,
    r.attempt_number, r.time_taken, r.answers_data,
    r.violations, r.violation_log, r.proctor_data,
    r.cert_code, r.created_at,
    jsonb_build_object(
      'subject',    e.subject,
      'teacher_id', e.teacher_id
    ) AS exams
  FROM public.results r
  LEFT JOIN public.exams e ON e.id = r.exam_id
  ORDER BY r.created_at DESC;
$$;

CREATE OR REPLACE FUNCTION public.admin_set_profile_status(p_id UUID, p_status TEXT)
RETURNS VOID LANGUAGE SQL SECURITY DEFINER
AS $$
  UPDATE public.profiles
  SET status = p_status, updated_at = NOW()
  WHERE id = p_id;
$$;

CREATE OR REPLACE FUNCTION public.admin_set_profile_role(p_id UUID, p_role TEXT, p_status TEXT)
RETURNS VOID LANGUAGE SQL SECURITY DEFINER
AS $$
  UPDATE public.profiles
  SET is_admin = (p_role = 'admin'),
      role     = p_role,
      status   = p_status,
      updated_at = NOW()
  WHERE id = p_id;
$$;

CREATE OR REPLACE FUNCTION public.admin_delete_profile(p_id UUID)
RETURNS VOID LANGUAGE SQL SECURITY DEFINER
AS $$
  DELETE FROM public.profiles WHERE id = p_id;
$$;

CREATE OR REPLACE FUNCTION public.admin_get_platform_stats()
RETURNS TABLE (
  total_teachers   BIGINT,
  active_teachers  BIGINT,
  pending_teachers BIGINT,
  total_exams      BIGINT,
  live_exams       BIGINT,
  total_results    BIGINT,
  total_students   BIGINT,
  avg_score        NUMERIC,
  pass_rate        NUMERIC
)
LANGUAGE SQL SECURITY DEFINER STABLE
AS $$
  SELECT
    (SELECT COUNT(*) FROM public.profiles) AS total_teachers,
    (SELECT COUNT(*) FROM public.profiles WHERE status = 'active') AS active_teachers,
    (SELECT COUNT(*) FROM public.profiles WHERE status = 'pending') AS pending_teachers,
    (SELECT COUNT(*) FROM public.exams) AS total_exams,
    (SELECT COUNT(*) FROM public.exams WHERE is_open = true AND is_archived = false) AS live_exams,
    (SELECT COUNT(*) FROM public.results) AS total_results,
    (SELECT COUNT(*) FROM public.students) AS total_students,
    COALESCE((SELECT AVG((score::NUMERIC / NULLIF(total, 0)) * 100) FROM public.results WHERE total > 0), 0) AS avg_score,
    COALESCE((
      SELECT ROUND(
        (COUNT(*) FILTER (WHERE (score::NUMERIC / NULLIF(total, 0)) * 100 >= 50)::NUMERIC /
         NULLIF(COUNT(*), 0) * 100, 0)
      FROM public.results WHERE total > 0
    ), 0) AS pass_rate;
$$;

CREATE OR REPLACE FUNCTION public.admin_get_exam_results(p_exam_id UUID)
RETURNS TABLE (
  id              UUID,
  exam_id         UUID,
  student_name    TEXT,
  student_class   TEXT,
  student_id_ref  TEXT,
  student_type    TEXT,
  score           INTEGER,
  total           INTEGER,
  correct_count   INTEGER,
  wrong_count     INTEGER,
  skipped_count   INTEGER,
  attempt_number  INTEGER,
  time_taken      INTEGER,
  answers_data    JSONB,
  violations      INTEGER,
  violation_log   JSONB,
  created_at      TIMESTAMPTZ
)
LANGUAGE SQL SECURITY DEFINER STABLE
AS $$
  SELECT
    r.id, r.exam_id, r.student_name, r.student_class,
    r.student_id_ref, r.student_type, r.score, r.total,
    r.correct_count, r.wrong_count, r.skipped_count,
    r.attempt_number, r.time_taken, r.answers_data,
    r.violations, r.violation_log, r.created_at
  FROM public.results r
  WHERE r.exam_id = p_exam_id
  ORDER BY r.created_at DESC;
$$;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 14: MIGRATE EXISTING USERS (Only if platform is already live)
-- ═══════════════════════════════════════════════════════════════════
-- SKIP this step for brand-new setups.
-- IMPORTANT: Replace 'buildingmyictcareer@gmail.com' with your actual admin email.

INSERT INTO public.profiles (id, email, full_name, role, is_admin, status)
SELECT
  u.id,
  u.email,
  COALESCE(u.raw_user_meta_data->>'full_name',
           u.raw_user_meta_data->>'display_name',
           split_part(u.email, '@', 1)),
  CASE WHEN u.email = 'buildingmyictcareer@gmail.com' THEN 'admin' ELSE 'teacher' END,
  CASE WHEN u.email = 'buildingmyictcareer@gmail.com' THEN true ELSE false END,
  'active'
FROM auth.users u
WHERE NOT EXISTS (
  SELECT 1 FROM public.profiles p WHERE p.id = u.id
)
ON CONFLICT (id) DO NOTHING;

-- ═══════════════════════════════════════════════════════════════════
-- STEP 15: SET UP ADMIN ACCOUNT
-- ═══════════════════════════════════════════════════════════════════
-- Replace YOUR-UUID-HERE with your UUID from Supabase Auth → Users.
-- Replace the email with your actual admin email.

-- INSERT INTO public.profiles (id, email, full_name, role, is_admin, status)
-- VALUES (
--   'YOUR-UUID-HERE',
--   'buildingmyictcareer@gmail.com',
--   'Adewale Samson Adeagbo',
--   'admin',
--   true,
--   'active'
-- )
-- ON CONFLICT (id) DO UPDATE
--   SET is_admin = true,
--       role     = 'admin',
--       status   = 'active',
--       updated_at = NOW();

-- ═══════════════════════════════════════════════════════════════════
-- STEP 16: VERIFY SETUP
-- ═══════════════════════════════════════════════════════════════════

-- 1. Check all tables exist with RLS enabled
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('exams', 'results', 'profiles', 'students')
ORDER BY tablename;
-- Expected: 4 rows, all with rowsecurity = true

-- 2. Check all profiles
SELECT id, email, full_name, role, is_admin, status, created_at
FROM public.profiles
ORDER BY created_at DESC;

-- 3. Confirm the signup trigger is attached
SELECT trigger_name, event_object_table, action_timing
FROM information_schema.triggers
WHERE trigger_name = 'on_auth_user_created';
-- Expected: 1 row showing trigger on auth.users

-- 4. Confirm RPC functions exist
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name LIKE 'admin_%'
ORDER BY routine_name;
-- Expected: 8 rows

-- 5. Confirm helper function exists
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name = 'get_exam_teacher_id';
-- Expected: 1 row

-- 6. Confirm all policies exist
SELECT tablename, policyname, cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, cmd;
-- Expected: 14+ policies

-- ═══════════════════════════════════════════════════════════════════
-- ✅ SETUP COMPLETE
-- ═══════════════════════════════════════════════════════════════════
-- If all verification queries return expected results, your database
-- is ready for production use.
--
-- NEXT STEPS:
-- 1. Update SB_URL, SB_KEY, and ADMIN_EMAIL in teacher.html,
--    student.html, and admin.html
-- 2. Disable email confirmation: Auth → Providers → Email → OFF
-- 3. Deploy to Vercel, Netlify, or GitHub Pages
-- 4. Test: create exam → share code → student submits → view results
--
-- ═══════════════════════════════════════════════════════════════════
-- HMG Academy CBT Pro v3.0
-- Built by Adewale Samson Adeagbo — Founder, HMG Concepts
-- Data Scientist · STEM Educator · 15+ years in Nigerian Classrooms
-- Learning Deliberately. Teaching Authentically.
-- ═══════════════════════════════════════════════════════════════════
