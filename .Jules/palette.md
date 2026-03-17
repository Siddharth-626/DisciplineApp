## 2025-05-14 - Destructive Action Confirmation Pattern
**Learning:** Destructive actions such as task deletion require a confirmation dialog to prevent accidental data loss. Using a Material `AlertDialog` with a clear "Delete" button styled with the theme's error color is an effective pattern for this app. Additionally, icon-only buttons need descriptive tooltips for both visual feedback and screen reader accessibility.
**Action:** When implementing destructive features, always wrap the action in a `showDialog` call and provide tooltips for any associated icon-only buttons.
