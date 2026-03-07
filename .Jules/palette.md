## 2025-05-15 - [Confirmation Dialog for Destructive Actions]
**Learning:** Destructive actions like task deletion should always require explicit user confirmation to prevent accidental data loss and improve user confidence.
**Action:** Implement `AlertDialog` with clear 'Cancel' and 'Delete' actions for any destructive operation. Always check if the dialog was confirmed before proceeding with the action.
