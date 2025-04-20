# **Markdown Snippets in VS Code (Linux Guide)**  

This guide will help you create **custom Markdown snippets** in **VS Code** on **Linux**, allowing you to quickly insert templates (like your daily checklist) with a simple keyword.  

---

## **Step 1: Open VS Code Snippets Configuration**  
1. Launch **VS Code**.  
2. Open the **Command Palette**:  
   - **Shortcut**: `Ctrl + Shift + P`  
3. Search for:  
   ```
   Preferences: Configure User Snippets
   ```  
4. Select **`markdown.json`** (for Markdown-specific snippets).  
   - If it doesn’t exist, VS Code will create it.  

---

## **Step 2: Define Your Snippet**  
Replace the contents of `markdown.json` with:  
```json
{
  "Daily Checklist": {
    "prefix": "checklist",
    "body": [
      "# 📅 Daily Checklist",
      "## ⏰ Date: ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
      "1. [ ] Priority task #1",
      "2. [ ] Important task #2",
      "3. [ ] Optional task #3",
      "### ✅ Completed",
      "- ~~Example task~~",
      "### 📦 Postponed",
      "- [ ] Postponed task (reason: ...)",
      "### 💡 Notes",
      "- Space for comments."
    ],
    "description": "Template for a daily task checklist in Markdown"
  }
}
```

### **Key Components**  
| Field        | Purpose |  
|--------------|---------|  
| `"prefix"`   | The shortcut word (e.g., typing `checklist` + `Tab` will insert the snippet). |  
| `"body"`     | The actual template (supports multi-line text and placeholders like `${CURRENT_DATE}`). |  
| `"description"` | Help text shown in autocomplete. |  

---

## **Step 3: Use the Snippet**  
1. Open or create a **Markdown file** (`Ctrl + N` → save as `file.md`).  
2. Type the **prefix** (`checklist`).  
3. Press **`Tab`** to auto-insert the template.  

✅ **Expected Result**:  
```markdown
# 📅 Daily Checklist
## ⏰ Date: 2023-11-15
1. [ ] Priority task #1
2. [ ] Important task #2
3. [ ] Optional task #3
### ✅ Completed
- ~~Example task~~
### 📦 Postponed
- [ ] Postponed task (reason: ...)
### 💡 Notes
- Space for comments.
```

---

## **Step 4: Troubleshooting (Linux-Specific)**  
### **Issue: Snippet Not Triggering**  
- **Fix 1**: Ensure the file has a `.md` extension.  
- **Fix 2**: Reload VS Code (`Ctrl + Shift + P` → `Developer: Reload Window`).  
- **Fix 3**: Check JSON syntax (no trailing commas in `body` array).  

### **Issue: Date Not Updating**  
- If `${CURRENT_DATE}` doesn’t work, install the **"Text Power Tools"** extension for dynamic variables.  

---

## **Bonus: Advanced Snippets**  
### **1. Multiple Snippets in One File**  
Add more entries to `markdown.json`:  
```json
{
  "Daily Checklist": { ... },
  "Meeting Notes": {
    "prefix": "meeting",
    "body": [
      "# 📝 Meeting Notes",
      "## Date: ${CURRENT_DATE}",
      "### Attendees:",
      "- @person1",
      "- @person2",
      "### Action Items:",
      "- [ ] Task 1"
    ]
  }
}
```

### **2. Keyboard Shortcut (Linux)**  
1. Open `keybindings.json` (`Ctrl + Shift + P` → `Preferences: Open Keyboard Shortcuts (JSON)`).  
2. Add:  
```json
{
  "key": "ctrl+alt+c",
  "command": "editor.action.insertSnippet",
  "args": { "name": "Daily Checklist" }
}
```
Now, press `Ctrl + Alt + C` to insert your checklist instantly!  

---

## **Recommended Extensions**  
1. **Markdown All in One**: Enhanced snippets + shortcuts.  
2. **Text Power Tools**: Dynamic variables (e.g., `$CURRENT_TIME`).  

---

### **Final Notes**  
- Snippets save **hours of repetitive typing**.  
- Works across Linux, Windows, and macOS (VS Code is cross-platform).  
- Experiment with placeholders (e.g., `${1:placeholderText}` for tab stops).  