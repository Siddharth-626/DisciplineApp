## 2025-05-14 - [Confirmation for Destructive Actions]
**Learning:** Destructive actions like task deletion should always have a confirmation dialog to prevent accidental data loss. This is especially important in mobile-friendly UIs where accidental taps are common.
**Action:** Always implement a confirmation dialog (e.g., AlertDialog) for any action that cannot be easily undone, and use tooltip on icon-only buttons for accessibility.
