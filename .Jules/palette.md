## 2025-05-15 - Standardizing Destructive Actions
**Learning:** Destructive actions like task deletion were immediate and lacked affordance for recovery or accidental clicks. The app also heavily uses icon-only buttons which are inaccessible to screen readers without tooltips.
**Action:** Implement a standard Material `AlertDialog` for all destructive actions with a clear 'Delete' action styled in the theme's error color. Always provide descriptive `tooltip` properties for `IconButton` and `FloatingActionButton` components.
