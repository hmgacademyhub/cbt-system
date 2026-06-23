# Advanced Question Types Guide — HMG Academy CBT Pro v3 Package

This package increases the CBT question-type family while keeping the system static, free-tier friendly, and without AI APIs.

## Full question type list

1. **MCQ** (`mcq`) — one correct option.
2. **MRQ** (`mrq`) — multiple correct options with partial or all-or-nothing scoring.
3. **True/False** (`tf`) — two-option true/false statements.
4. **Short Answer** (`short`) — typed exact/accepted answers.
5. **Numeric** (`numeric`) — typed number with optional tolerance and unit.
6. **Matching** (`matching`) — pair left items with right items.
7. **Ordering** (`ordering`) — arrange items in correct sequence.
8. **Cloze/Multi-blank** (`cloze`) — fill multiple blanks.
9. **Essay/Keyword** (`essay`) — rule-based keyword/minimum-word marking, no AI.
10. **Categorization** (`categorization`) — classify items into categories.
11. **Multi-part Numeric** (`multi_numeric`) — answer multiple numeric sub-parts with partial credit.
12. **Assertion–Reason** (`assertion_reason`) — WAEC/JAMB/Cambridge-style assertion and reason logic.
13. **Case Study / Passage** (`case_study`) — read a passage/scenario, then answer a choice question.
14. **Image MCQ** (`image_mcq`) — display an image/diagram, then answer MCQ.
15. **Matrix/Grid** (`matrix`) — answer multiple rows using shared options such as True/False, Yes/No, A/B/C/D.
16. **Hot Text** (`hot_text`) — select correct words/phrases from text chunks.
17. **Code/Algorithm** (`code`) — typed code, pseudocode, SQL, or algorithm answer scored by configured keywords/tests and teacher review.

## CSV/XLSX advanced columns

The platform remains backward-compatible with the existing format:

```text
Question,A,B,C,D,CorrectAnswer,Explanation,Type,Tolerance,Unit,Accept,MRQ_AON,Pairs,Items,Difficulty,Tags,Section
```

For newer types, use:

- **Type** column: one of the new type names.
- **CorrectAnswer**: option letter or primary key.
- **Accept**: optional choices, keywords, image URL, or pipe-separated values.
- **Items**: JSON schema for advanced structured questions.

## Examples

### Assertion–Reason

```csv
"Assertion: Metals conduct electricity. Reason: Metals have free electrons.","Assertion text","Reason text","","","A","Free electrons explain conductivity.","assertion_reason","","","","","","[{""assertion"":""Metals conduct electricity."",""reason"":""Metals have free electrons.""}]"
```

If no option list is supplied, the student portal automatically shows the standard five Assertion–Reason options A–E.

### Case Study

```csv
"Based on the passage, what is the main cause of the result?","Evaporation","Condensation","Sublimation","Deposition","B","","case_study","","","","","","{""passage"":""A beaker of warm water was covered with a cold lid. Droplets formed on the underside of the lid.""}"
```

### Image MCQ

```csv
"Identify the labelled organ in the diagram.","Heart","Liver","Kidney","Lung","A","","image_mcq","","","data:image/png;base64,...","","",""
```

Use a data URI or a same-site image path. For offline/static preview, data URI is best.

### Matrix/Grid

```csv
"Classify each statement as True or False.","","","","","","","matrix","","","True|False","","","[{""statement"":""Water boils at 100°C at sea level."",""answer"":""True""},{""statement"":""CO₂ is oxygen gas."",""answer"":""False""}]"
```

### Hot Text

```csv
"Select the prime numbers.","","","","","","","hot_text","","","","","","[{""text"":""2"",""correct"":true},{""text"":""4"",""correct"":false},{""text"":""5"",""correct"":true}]"
```

### Code/Algorithm

```csv
"Write a JavaScript function that returns the larger of two numbers.","","","","","","","code","","JavaScript","function|return|if|Math.max","","","{""language"":""JavaScript"",""keywords"":[""function"",""return"",""Math.max""]}"
```

## Notes

- No AI grading is used.
- Essay/code marking is transparent rule-based scoring and should be teacher-reviewed for high-stakes exams.
- Math/Science keyboard is always available during exams, including old exams created before the feature existed.


## CBT v3 note

The Teacher Dashboard CSV reference and downloadable CSV template now include example rows for all 17 types. Use `PROMPT_TEMPLATE.md` to ask an AI assistant to generate compatible CSV manually; the platform itself still uses no AI API.
