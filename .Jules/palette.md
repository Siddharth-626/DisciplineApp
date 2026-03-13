## 2025-05-14 - Confirmation for Destructive Actions
**Learning:** In a task-driven application, users often click buttons quickly. Destructive actions like task deletion require a friction point (confirmation dialog) to prevent accidental data loss and build user trust.
**Action:** Always implement a Material `AlertDialog` for delete operations, using a clear "Delete" button with the theme's error color.

## 2025-05-14 - Tooltips for Icon-Only Buttons
**Learning:** Icon-only buttons without labels are ambiguous for new users and inaccessible for screen readers. Tooltips provide immediate clarity on hover and improve the experience for power users who rely on muscle memory but occasionally need a hint.
**Action:** Ensure every `IconButton` or icon-based `FloatingActionButton` has a descriptive `tooltip` property.
