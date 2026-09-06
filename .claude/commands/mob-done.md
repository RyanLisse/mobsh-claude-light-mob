---
description: Finish mob.sh session (mob done); remind human to review, commit, and push.
---

# /mob-done

End the WIP session with **mob.sh**; humans still own the final commit/push.

## Steps (Claude)

1. Confirm the mob is ready to squash WIP onto the base branch index.
2. Run:

```bash
mob done
```

3. Remind the **human** to:
   - Review the staged diff carefully
   - Write the real commit message
   - Push themselves
   - Never push secrets; never skip review on protected branches / prod
4. Note: mob done carries Co-authored-by from WIP committers (GitLab shows co-authors when emails match).
5. Claude does not push to protected branches or production.
