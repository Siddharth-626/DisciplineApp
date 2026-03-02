## 2026-03-02 - [Enhancing Task Management UX & Accessibility]
**Learning:** Selection widgets like ChoiceChip must use meaningful labels and tooltips instead of empty placeholders to ensure accessibility. Implementing confirmation dialogs for destructive actions like task deletion is critical for preventing accidental data loss and improving user confidence.
**Action:** Always provide descriptive tooltips for all icon-only buttons and use meaningful labels for selection widgets. Use `context.mounted` instead of `mounted` when dealing with `BuildContext` across async gaps.
