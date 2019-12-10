# Contributing Guide

These guidelines build upon the dwyl contributing guidelines, which can be
found at https://github.com/dwyl/contributing

![screenshot-of-dwyl-contributing](https://user-images.githubusercontent.com/4185328/69333674-0db3e880-0c51-11ea-81db-1ae66d1bb3f3.png)

This document ***adds*** to this process, detailing what we have found useful
during the course of developing our own application and giving a broad overview
of changes for people _already familiar with dwyl's contributing process_.

In time, the whole process will be rewritten for clarity and now that our focus
has moved away from working with clients.

> The vast majority of the additions here sit in two key areas:
+ The use of the [Github Project](https://help.github.com/en/github/managing-your-work-on-github/about-project-boards)
as a kanban board (this is not yet in our main contributing guide)
+ New labels specific to this repo



## Github project


## Workflow

### Part 1: Describe your Question, Idea or User Story in an Issue


### Part 2: Validate the Need or Issue Exists
This section is where the work is performed by those who have write access to the
repo and is where the ***key changes to the workflow*** will take place.

#### :arrow_ right: Step 1: _Confirm_ the Need in the New Story/Issue
The Product Owner (PO) will confirm the _need_, but if the issue is confirmed,
the PO will also:

##### A) Confirm that there is a set of acceptance criteria listed in the issue
+ Acceptance Criteria should be in the form of a _checklist_ of items in the
  original post. This way it will appear in the issue list, giving an idea of
  how much of the acceptance criteria has been met when the issue is worked
  on
  ![checklist-in-issue-list-screenshot](https://user-images.githubusercontent.com/4185328/69977981-a422bc80-1523-11ea-9df2-8e892dd6f884.png)


+ If no acceptance criteria is present, the PO should either:
  + :label: Add the `needs-criteria` label to the issue to signal that this still
    needs to be added before work can proceed; OR
  + Add acceptance criteria to the original post if they are intimately familiar
    with what is required
    ![needs-criteria-label-screenshot](https://user-images.githubusercontent.com/4185328/69977426-b2240d80-1522-11ea-95f3-8de79ce516fb.png)

##### B) Confirm that there is a proposed User Interface *(UI)* for the issue

:label: Similar to `needs-criteria`, a `needs-ui` label should be applied to the issue
if no UI has been proposed and until a UI is agreed.

_Note:_ This does not have to be the _final, unchangeable_ UI. Every UI is a
starting point for testing with people using the app.

#### :arrow_ right: Step 2: Assign a Priority to the Issue
:warning: :label: A priority label should only be used for the issues expected to come up
in the next 2 sprints or so.

All other issues - should a rough priority for them be known at this stage - will
be put into the `To Do` column of the
[Github Project](https://github.com/dwyl/app/projects) in prioritised order.

_We are testing whether this is able to prevent the notion that `priority-4` and
`priority-5` labels are ["where issues go to die"](https://github.com/dwyl/app/issues/239#issuecomment-556105866)_.


## Part 3: Do the Work!
