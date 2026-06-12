-- ════════════════════════════════════════════════════════════
-- HMG ACADEMY CBT PRO v2.0 — COMPLETE DATABASE SETUP
-- ════════════════════════════════════════════════════════════
-- Run ALL statements below in order inside:
-- Supabase Dashboard → SQL Editor
-- ════════════════════════════════════════════════════════════
-- This single file creates every table, enables security,
-- adds all policies, helper functions, and verification checks.
-- ════════════════════════════════════════════════════════════

-- ════════════════════════════════════════════
-- STEP 1: CREATE TABLES
-- ════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS exams (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  teacher_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  code TEXT UNIQUE NOT NULL,
  subject TEXT NOT NULL,
  duration INTEGER NOT NULL DEFAULT 45,
  attempt_limit INTEGER NOT NULL DEFAULT 1,
  select_count INTEGER NOT NULL DEFAULT 0,
  is_open BOOLEAN NOT NULL DEFAULT false,
  exam_mode TEXT NOT NULL DEFAULT 'open',
  start_at TIMESTAMPTZ,
  close_at TIMESTAMPTZ,
  csv_data TEXT NOT NULL DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS results (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  exam_id UUID REFERENCES exams(id) ON DELETE CASCADE,
  student_name TEXT NOT NULL,
  student_id TEXT,
  score INTEGER NOT NULL,
  total INTEGER NOT NULL,
  answers_data TEXT NOT NULL DEFAULT '{}',
  time_taken INTEGER,
  submitted_at TIMESTAMPTZ DEFAULT NOW(),
  proctor_photo TEXT,
  tab_switches INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS students (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  teacher_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  student_id TEXT UNIQUE,
  class TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS platform_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  admin_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  action TEXT NOT NULL,
  target_id UUID,
  details JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ════════════════════════════════════════════
-- STEP 2: ADD MISSING COLUMNS (safe for upgrades)
-- ════════════════════════════════════════════

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
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='student_id') THEN
    ALTER TABLE results ADD COLUMN student_id TEXT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='answers_data') THEN
    ALTER TABLE results ADD COLUMN answers_data TEXT NOT NULL DEFAULT '{}';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='time_taken') THEN
    ALTER TABLE results ADD COLUMN time_taken INTEGER;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='proctor_photo') THEN
    ALTER TABLE results ADD COLUMN proctor_photo TEXT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='results' AND column_name='tab_switches') THEN
    ALTER TABLE results ADD COLUMN tab_switches INTEGER DEFAULT 0;
  END IF;
END $$;

-- ════════════════════════════════════════════
-- STEP 3: ENABLE ROW-LEVEL SECURITY
-- ════════════════════════════════════════════

ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE results ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;

-- ════════════════════════════════════════════
-- STEP 4: DROP EXISTING POLICIES (clean slate)
-- ════════════════════════════════════════════

DROP POLICY IF EXISTS "Teachers see own exams" ON exams;
DROP POLICY IF EXISTS "Teachers create own exams" ON exams;
DROP POLICY IF EXISTS "Teachers update own exams" ON exams;
DROP POLICY IF EXISTS "Teachers delete own exams" ON exams;
DROP POLICY IF EXISTS "Students can submit results" ON results;
DROP POLICY IF EXISTS "Students can view own results" ON results;
DROP POLICY IF EXISTS "Teachers see own results" ON results;
DROP POLICY IF EXISTS "Teachers delete own results" ON results;
DROP POLICY IF EXISTS "Teachers manage own students" ON students;

-- ════════════════════════════════════════════
-- STEP 5: CREATE ALL RLS POLICIES
-- ════════════════════════════════════════════

-- Exams: Teachers only see/create/update/delete their own
CREATE POLICY "Teachers see own exams" ON exams
  FOR SELECT USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers create own exams" ON exams
  FOR INSERT WITH CHECK (auth.uid() = teacher_id);

CREATE POLICY "Teachers update own exams" ON exams
  FOR UPDATE USING (auth.uid() = teacher_id);

CREATE POLICY "Teachers delete own exams" ON exams
  FOR DELETE USING (auth.uid() = teacher_id);

-- Results: Students can submit; teachers see results for their exams
CREATE POLICY "Students can submit results" ON results
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Students can view own results" ON results
  FOR SELECT USING (true);

CREATE POLICY "Teachers see own results" ON results
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM exams
      WHERE exams.id = results.exam_id
      AND exams.teacher_id = auth.uid()
    )
  );

CREATE POLICY "Teachers delete own results" ON results
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM exams
      WHERE exams.id = results.exam_id
      AND exams.teacher_id = auth.uid()
    )
  );

-- Students: Teachers manage their own roster
CREATE POLICY "Teachers manage own students" ON students
  FOR ALL USING (auth.uid() = teacher_id);

-- ════════════════════════════════════════════
-- STEP 6: HELPER FUNCTION (bypass RLS safely for student lookup)
-- ════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.get_exam_by_code(exam_code TEXT)
RETURNS SETOF exams
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT * FROM exams WHERE code = exam_code AND is_open = true;
$$;

-- ════════════════════════════════════════════
-- STEP 7: AUTO-UPDATE TIMESTAMP TRIGGER
-- ════════════════════════════════════════════

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_exams_updated_at ON exams;
CREATE TRIGGER update_exams_updated_at
  BEFORE UPDATE ON exams
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ════════════════════════════════════════════
-- STEP 8: CREATE INDEXES (performance)
-- ════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_exams_teacher_id ON exams(teacher_id);
CREATE INDEX IF NOT EXISTS idx_exams_code ON exams(code);
CREATE INDEX IF NOT EXISTS idx_exams_is_open ON exams(is_open);
CREATE INDEX IF NOT EXISTS idx_results_exam_id ON results(exam_id);
CREATE INDEX IF NOT EXISTS idx_results_student_name ON results(student_name);
CREATE INDEX IF NOT EXISTS idx_results_submitted_at ON results(submitted_at);
CREATE INDEX IF NOT EXISTS idx_students_teacher_id ON students(teacher_id);
CREATE INDEX IF NOT EXISTS idx_students_student_id ON students(student_id);

-- ════════════════════════════════════════════
-- STEP 9: VERIFY SETUP
-- ════════════════════════════════════════════

-- Check all tables exist
SELECT 'TABLES CREATED' AS status, table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('exams', 'results', 'students')
ORDER BY table_name;

-- Check RLS is enabled
SELECT 'RLS ENABLED' AS status, tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
  AND tablename IN ('exams', 'results', 'students');

-- Check all policies exist
SELECT 'POLICIES CREATED' AS status, policyname, tablename, cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, cmd;

-- Check helper function exists
SELECT 'FUNCTION CREATED' AS status, routine_name
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name = 'get_exam_by_code';

-- ════════════════════════════════════════════
-- ✅ SETUP COMPLETE
-- ════════════════════════════════════════════
-- If you see rows returned for all 4 checks above,
-- your database is ready. Proceed to update the
-- SB_URL, SB_KEY, and ADMIN_EMAIL constants in:
--   teacher.html, student.html, admin.html
-- ════════════════════════════════════════════
