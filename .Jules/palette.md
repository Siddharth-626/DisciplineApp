## 2025-05-15 - [Confirmation Dialogs & Tooltips]
**Learning:** Destructive actions like task deletion require both visual tooltips for icon-only buttons (accessibility) and explicit confirmation dialogs (safety). In Flutter, ensuring `context.mounted` check after async dialog completion is critical for stability.
**Action:** Always pair icon-only destructive buttons with a tooltip and a confirmation dialog.
