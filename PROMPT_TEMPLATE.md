# HMG Academy CBT Pro — AI Question Bank Prompt Templates

Use this file when you want an AI writing assistant to generate **CSV question banks** that can be copied/downloaded and uploaded into **HMG Academy CBT Pro**.

Important: the platform itself does **not** use a paid AI API. These prompts are for manual use in any AI chat tool or by a human question setter. The output should be a CSV file/text that the teacher uploads manually.

---

## Prompt 1 — Standard 60-question CBT CSV bank, 11 core types

Copy, edit the placeholders, and give this to an AI assistant:

```text
You are an expert [CURRICULUM] [SUBJECT] teacher with strong assessment-design experience.

Generate a 60-question CSV question bank for HMG Academy CBT Pro.

Class: [CLASS]
Subject: [SUBJECT]
Topic: [TOPIC]
Subtopics: [SUBTOPIC 1] | [SUBTOPIC 2] | [SUBTOPIC 3] | [SUBTOPIC 4]
Curriculum: [CURRICULUM]

IMPORTANT:

- Output downloadable CSV only.
- No markdown table.
- No explanation outside the CSV.
- First line must be exactly:
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items
- Use UTF-8 characters correctly.
- Escape inner JSON double-quotes inside CSV cells as two double-quotes.
- Wrap every CSV field in double-quotes.
- Do not use paid API instructions. This is for manual copy/download only.

QUESTION TYPE DISTRIBUTION:

mcq=14, tf=6, mrq=6, short=6, numeric=6, matching=5, ordering=5, cloze=4, categorization=3, multi_numeric=3, essay=2

TYPE RULES:

mcq:
- Col2–5: four options
- Col6: A/B/C/D
- Col8: mcq

tf:
- Col2: True
- Col3: False
- Col4–5: blank
- Col6: A if true, B if false
- Col8: tf

mrq:
- Col2–5: options
- Col6: sorted comma list, e.g. A,C
- Col8: mrq
- Col12: false for partial credit or true for all-or-nothing

short:
- Col6: primary answer
- Col11: accepted alternates separated by |, e.g. H₂O|water|h2o
- Col8: short

numeric:
- Col6: number only
- Col9: tolerance, e.g. 0 or 0.05
- Col10: unit if needed
- Col8: numeric

matching:
- Col13: JSON array of pairs and distractors
- Format: [{"left":"Term","right":"Definition"},{"left":"DISTRACTOR","right":"Wrong option"}]
- In CSV, escape inner quotes as ""
- Col8: matching

ordering:
- Col14: JSON array of items in the correct order
- Example: ["First","Second","Third"]
- Col8: ordering

cloze:
- Question text must include blanks using ___
- Col14: JSON array of accepted answers for each blank in order
- Each blank may include alternatives separated by |
- Example: ["mass|m","acceleration|a"]
- Col8: cloze

essay:
- Long response, scored without AI by keywords and minimum word count
- Col11: keywords separated by |
- Col14: JSON object like {"min_words":30,"keywords":["honesty","fairness","trust"]}
- Col8: essay
- Explanation should say teacher review is recommended

categorization:
- Student assigns each item to the correct category
- Col14: JSON array like [{"item":"Sodium","category":"Metal"},{"item":"Oxygen","category":"Non-metal"}]
- Col8: categorization

multi_numeric:
- Student answers several numeric parts
- Col14: JSON array like [{"label":"x","answer":3,"tolerance":0},{"label":"y","answer":2,"tolerance":0}]
- Col8: multi_numeric

QUALITY RULES:

- Questions should assess understanding, not mere guessing.
- Distractors must reflect common student misconceptions.
- Explanations should teach the concept.
- Difficulty should be mixed: easy, medium, challenging.
- Avoid ambiguous answers.
- For calculations, include tolerances where decimals are expected.
- For essay questions, include keywords that can be objectively checked without AI.
- Ensure the total number of questions is exactly 60.

Now output the downloadable CSV.
```

---

## Prompt 2 — Full CBT v3 enterprise bank, all 17 question types

Use this when you want the newest CBT Pro question types included.

```text
You are an expert [CURRICULUM] [SUBJECT] teacher, examiner, and assessment designer.

Generate a 60-question CSV question bank for HMG Academy CBT Pro v3.

Class: [CLASS]
Subject: [SUBJECT]
Topic: [TOPIC]
Subtopics: [SUBTOPIC 1] | [SUBTOPIC 2] | [SUBTOPIC 3] | [SUBTOPIC 4]
Curriculum/Exam standard: [CURRICULUM OR EXAM BODY]
Learning level: [LOWER BASIC / UPPER BASIC / JUNIOR SECONDARY / SENIOR SECONDARY / UTME / IGCSE / ETC]

IMPORTANT OUTPUT RULES:

- Output CSV only.
- No markdown table.
- No commentary before or after the CSV.
- First line must be exactly:
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items
- Use UTF-8 characters correctly, including scientific symbols such as H₂O, CO₂, π, Ω, ≤, ≥, °C.
- Wrap every CSV field in double-quotes.
- Escape inner JSON double-quotes inside CSV cells as two double-quotes.
- Do not include paid API instructions.
- This is for manual copy/download into HMG Academy CBT Pro.

QUESTION TYPE DISTRIBUTION — EXACTLY 60 QUESTIONS:

mcq=10, tf=5, mrq=5, short=5, numeric=5, matching=4, ordering=4, cloze=4, categorization=3, multi_numeric=3, essay=2, assertion_reason=3, case_study=2, image_mcq=1, matrix=2, hot_text=1, code=1

SUPPORTED TYPES AND RULES:

mcq:
- Col2–5: four plausible options
- Col6: A/B/C/D
- Col8: mcq

tf:
- Col2: True
- Col3: False
- Col4–5: blank
- Col6: A if true, B if false
- Col8: tf

mrq:
- Col2–5: options
- Col6: sorted comma list, e.g. A,C
- Col8: mrq
- Col12: false for partial credit or true for all-or-nothing

short:
- Col6: primary answer
- Col11: accepted alternates separated by |, e.g. H₂O|water|h2o
- Col8: short

numeric:
- Col6: number only
- Col9: tolerance, e.g. 0, 0.05, 0.5
- Col10: unit if needed
- Col8: numeric

matching:
- Col13: JSON array of pairs and distractors
- Format: [{"left":"Term","right":"Definition"},{"left":"DISTRACTOR","right":"Wrong option"}]
- Col8: matching

ordering:
- Col14: JSON array of items in correct order
- Example: ["First","Second","Third"]
- Col8: ordering

cloze:
- Question text must include blanks using ___
- Col14: JSON array of accepted answers for each blank in order
- Each blank may include alternatives separated by |
- Example: ["mass|m","acceleration|a"]
- Col8: cloze

essay:
- Long response, scored without AI by keywords and minimum word count
- Col11: keywords separated by |
- Col14: JSON object like {"min_words":30,"keywords":["honesty","fairness","trust"]}
- Col8: essay
- Explanation should state that teacher review is recommended

categorization:
- Student assigns each item to the correct category
- Col14: JSON array like [{"item":"Sodium","category":"Metal"},{"item":"Oxygen","category":"Non-metal"}]
- Col8: categorization

multi_numeric:
- Student answers several numeric parts
- Col14: JSON array like [{"label":"x","answer":3,"tolerance":0},{"label":"y","answer":2,"tolerance":0}]
- Col8: multi_numeric

assertion_reason:
- Use for logic questions with an Assertion and Reason.
- Col1: question instruction or combined assertion/reason.
- Col2 may contain the assertion text.
- Col3 may contain the reason text.
- Col6: A/B/C/D/E.
- Col8: assertion_reason.
- Col14 may contain JSON like {"assertion":"...","reason":"..."}.
- If using standard options, interpret:
  A = Both Assertion and Reason are true, and Reason correctly explains Assertion.
  B = Both are true, but Reason does not correctly explain Assertion.
  C = Assertion is true, Reason is false.
  D = Assertion is false, Reason is true.
  E = Both are false.

case_study:
- Use for scenario/passage/data interpretation.
- Col1: the question asked after the passage.
- Col2–5: options.
- Col6: A/B/C/D.
- Col8: case_study.
- Col14: JSON object like {"passage":"Write the passage or scenario here."}.

image_mcq:
- Use for diagram/image-based questions.
- Col1: image-based question.
- Col2–5: options.
- Col6: A/B/C/D.
- Col8: image_mcq.
- Col11 may contain a same-site image path or data URI.
- Col14 may contain JSON like {"image":"assets/example-diagram.png"}.
- If no real image is available, describe the diagram clearly in Col1 and leave image path blank.

matrix:
- Student answers multiple rows using shared choices.
- Col11: shared choices separated by |, e.g. True|False or Yes|No.
- Col14: JSON array like [{"statement":"Water boils at 100°C at sea level.","answer":"True"},{"statement":"CO₂ is oxygen gas.","answer":"False"}]
- Col8: matrix.

hot_text:
- Student selects correct words/phrases.
- Col14: JSON array like [{"text":"2","correct":true},{"text":"4","correct":false},{"text":"5","correct":true}]
- Col8: hot_text.

code:
- Student writes code, pseudocode, SQL, formula steps, or algorithm.
- Col10: language or notation, e.g. Python, JavaScript, SQL, Pseudocode.
- Col11: objective keywords/tests separated by |.
- Col14: JSON object like {"language":"Python","keywords":["def","return","max"]}.
- Col8: code.
- Explanation should say teacher review is recommended for final code quality.

QUALITY RULES:

- Questions should assess understanding, application, and reasoning.
- Distractors must be plausible and based on common misconceptions.
- Explanations must teach the concept, not merely state the answer.
- Include easy, medium, and challenging questions.
- Avoid ambiguous or culturally biased wording.
- Calculations must include enough information to solve.
- Use tolerances for decimal numeric answers.
- Essay/code questions must include objective keywords because no AI marking is used.
- Use Nigerian/African classroom context where appropriate, but keep academic accuracy.
- Ensure the final CSV has exactly 60 data rows plus the header.

Now output the downloadable CSV only.
```

---

## Prompt 3 — Generate only advanced question types

Use this to create a smaller practice bank focused on advanced item types.

```text
You are an expert [SUBJECT] examiner.

Generate a 25-question CSV bank for HMG Academy CBT Pro using only these types:
assertion_reason, case_study, image_mcq, matrix, hot_text, code, matching, ordering, cloze, categorization, multi_numeric.

Class: [CLASS]
Subject: [SUBJECT]
Topic: [TOPIC]
Curriculum: [CURRICULUM]

Output CSV only. No markdown table. First line must be exactly:
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items

Use valid UTF-8. Escape inner JSON quotes as two double-quotes. Wrap all CSV cells in double-quotes.

Distribution:
assertion_reason=4, case_study=3, image_mcq=2, matrix=3, hot_text=2, code=2, matching=3, ordering=2, cloze=2, categorization=1, multi_numeric=1

Follow HMG Academy CBT Pro format rules:
- Col8 must contain the exact type.
- Col13 is for matching Pairs JSON.
- Col14 is for Items/schema JSON.
- Col11 is for accepted answers, shared options, keywords, or image path where relevant.
- No paid AI API instructions.
- Essay/code responses must be keyword/rule based and teacher-review friendly.

Now output the CSV only.
```

---

## Quick CSV escaping reminder

Inside a CSV cell, JSON like this:

```json
[{"item":"Sodium","category":"Metal"}]
```

must appear inside the CSV as:

```text
"[{""item"":""Sodium"",""category"":""Metal""}]"
```

This is very important for `matching`, `ordering`, `cloze`, `essay`, `categorization`, `multi_numeric`, `assertion_reason`, `case_study`, `image_mcq`, `matrix`, `hot_text`, and `code`.

---

## CBT v5 exam-type prompt placeholders

When generating a CSV bank, set `[EXAM TYPE]` to one of: Admission Screening, Scholarship Test, Common Entrance Exam, Recruitment / Aptitude Test, Certification Exam, STEM Exam, UTME / JAMB Practice, WAEC / NECO / BECE Practice, Post-UTME Screening, Placement Test, Training Assessment, IELTS / SAT Practice, Class Test, CA, Mid-Term, Terminal Exam, Mock, or Practice.

Add this line to any prompt when useful:

```text
Exam Type: [EXAM TYPE]
Assessment Purpose: [admission screening / scholarship selection / common entrance / recruitment shortlisting / certification / STEM mastery / standardised exam practice]
```

Ask the AI assistant to adapt difficulty, distractors, timing assumptions and explanations to the chosen exam type while still outputting CSV only.

