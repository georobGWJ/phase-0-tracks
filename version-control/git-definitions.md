# Git Definitions

**Instructions: ** Define each of the following Git concepts.

* What is version control?  Why is it useful?

Version control includes tools and processes used to track and 
manage the state of codebases or other (usually text-based) 
files, the changes made to these files, means for creating 
branches of a codebase, means for comparing changes made in a
branch to the master (or another) branch, means for merging
branching codebases into each other, and finally, means to revert
to an earlier version of a codebase.

It is useful because it allows careful control of codebases and
provides means for review of changes so that there is a lesser
chance of 'breaking' the stable master branch. It also allows
multiple coders to work on different parts of the codebase
via branching and to have those branches independently merged
back into the master branch after coworkers or managers have
reviewed them.


* What is a branch and why would you use one?

A branch is an independent copy of a codebase that can be freely
modified without directly affecting the codebase that it was 
branched from. You would normally branch a codebase so that you
could add a new feature or work on debugging existing code. Once
you are finished, you would submit a pull request, have your code
reviewed and, provided it's good, have it merged back into the
main codebase (or a sub-branch.) 


* What is a commit? What makes a good commit message?

A commit is a save point for the codebase branch that you're in.
It saves the files that you have modified and told git that you
want to add into the branch.

A good commit message should be concise, consistent and provide
some brief indication of why a change was made if the change is
non-trivial or non-self explanatory. It should also be present
tense (i.e. 'Add foo method', not 'Added foo method'.)


* What is a merge conflict?

A merge conflict occurs when multiple branches of a codebase 
have modified the same method or file in different ways and git 
cannot merge these branches into the master (or sub-branch) because
the changes are mutually exclusive. For example, if both Sarah
and George have independently modified the logic of the foo 
method and the manager tries to merge Sarah's and George's code
into the master branch, a merge conflict will occur. Even if both
modifications are valid and improve the foo method in some way, 
only one can be the 'canonical' foo method. This is a reason that collaborators need to clearly communicate and understand the scope 
of what they should be working on; that will ideally prevent 
merge conflicts.
