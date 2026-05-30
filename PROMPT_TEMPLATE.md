# HMG Academy CBT Pro — Question Bank Prompt Template

This template helps a teacher generate a CSV question bank manually with any writing assistant or by writing the rows directly. It does **not** require an AI API. If you use ChatGPT, Gemini, Claude, or any other assistant, use the web interface manually — do not connect the CBT system to a paid API.

---

## CSV Header

```csv
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items
```

---

## Recommended Distribution for 60 Questions

```text
mcq=14
tf=6
mrq=6
short=6
numeric=6
matching=5
ordering=5
cloze=4
categorization=3
multi_numeric=3
essay=2
Total=60
```

You may reduce or increase the counts depending on the level and topic.

---

## Master Prompt

Copy and edit the bracketed fields.

```text
You are an expert [CURRICULUM] [SUBJECT] teacher with strong assessment-design experience.
Generate a 60-question CSV question bank for HMG Academy CBT Pro.

Class: [CLASS]
Subject: [SUBJECT]
Topic: [TOPIC]
Subtopics: [SUBTOPIC 1] | [SUBTOPIC 2] | [SUBTOPIC 3] | [SUBTOPIC 4]
Curriculum: [CURRICULUM]

IMPORTANT:
- Output CSV only.
- No markdown table.
- No explanation outside the CSV.
- First line must be exactly:
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items
- Use UTF-8 characters correctly.
- Escape inner JSON double-quotes inside CSV cells as two double-quotes.
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

Now output the CSV.
```

---

## Quick Advanced-Type Examples

### Cloze

```csv
"Force = ___ × ___.","","","","","","Force equals mass times acceleration.","cloze","","","","","","[""mass|m"",""acceleration|a""]"
```

### Essay

```csv
"Explain two reasons why exam integrity matters.","","","","","","This is rule-based keyword scoring; teacher review recommended.","essay","","","honesty|fairness|trust|validity","","","{""min_words"":30,""keywords"":[""honesty"",""fairness"",""trust"",""validity""]}"
```

### Categorization

```csv
"Categorise each item as Metal, Non-metal, or Metalloid.","","","","","","Each item earns partial credit.","categorization","","","","","","[{""item"":""Sodium"",""category"":""Metal""},{""item"":""Oxygen"",""category"":""Non-metal""},{""item"":""Silicon"",""category"":""Metalloid""}]"
```

### Multi-Part Numeric

```csv
"Solve x + y = 5 and x - y = 1. Enter x and y.","","","","","","Adding equations gives x=3 and y=2.","multi_numeric","","","","","","[{""label"":""x"",""answer"":3,""tolerance"":0},{""label"":""y"",""answer"":2,""tolerance"":0}]"
```

---

## Final Verification Checklist

Before upload, confirm:

- The header is exactly correct.
- Every row has 14 columns.
- JSON cells are wrapped in double quotes.
- Inner JSON quotes are escaped as two double-quotes.
- MCQ/TF answers are valid letters.
- MRQ answers are comma-separated letters.
- Numeric answers contain numbers only.
- Essay uses keywords because no AI API is used.
- Categorization and multi_numeric JSON is valid.
