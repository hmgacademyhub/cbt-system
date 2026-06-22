# Math/Scientific Keyboard Integration Guide

## Overview
The on-screen math keyboard lets students insert mathematical and scientific symbols into their answers. It appears for Short Answer, Essay, Cloze, Numeric, and Multi-Numeric question types.

## How to Integrate into student.html

### Add the Button
Insert this before `</body>`:
```html
<div id="math-keyboard-btn" class="no-print hidden" onclick="toggleMathKeyboard()"
     style="position:fixed;bottom:86px;right:86px;z-index:9000;cursor:pointer;
     background:var(--surface-2);border:1px solid var(--border);border-radius:50%;
     width:44px;height:44px;display:flex;align-items:center;justify-content:center;
     font-size:20px;box-shadow:0 4px 12px rgba(0,0,0,0.4);">∑</div>
```

### Add the Keyboard Panel
The keyboard has 8 tabs: Greek Letters, Operators, Sup/Sub, Calculus, Sets, Logic, Chemistry, Arrows — with 100+ symbols total.

### CSS Classes to Add
```css
.mk-tab{font-size:11px;font-weight:700;padding:5px 10px;border-radius:6px;width:auto;}
.mk-grid{display:grid;grid-template-columns:repeat(6,1fr);gap:4px;}
.mk-grid button{padding:8px 4px;background:#1a1a1a;color:#fff;border:1px solid #222;border-radius:6px;cursor:pointer;font-size:14px;font-weight:600;width:100%;}
.mk-grid button:hover{background:#2a2a2a;border-color:var(--primary);}
```

### JavaScript Functions
Add `toggleMathKeyboard()`, `switchMkTab(tab)`, and `insertSymbol(symbol)` functions.

### Auto-Show Logic
Call `showMathKeyboardBtn()` in `showQ()` to show the button only for typed question types.
