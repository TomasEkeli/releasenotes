releasenotes
============

Goal: 
Make release-notes painless to merge and easy to read

Background:
Today we develop on branches and all update the same file on this branch with release-notes relevant to our particular branch. This leads to merge-conflicts in the release-notes on every merge to master. Furthermore if a feature is picked back out of master we often have to manually remove the relevant lines from the release-note.

To minimize merge-conflicts in normal coding we try to rely on the single-responsibility principle to keep our files small and focused. Thus two developers working on different stuff in the same general area should ideally not touch the same files (much). The files that are touched by both developers will be orchestration-type classes that call interfaces, and such conflicts are much easier to merge.

I propose we follow a similar approach for release-notes. Let us stop editing the same file in all our branches, and rather create a new file for each feature, fix and improvement. Further, let's treat release-notes as a deliverable and not deliver our raw files - rather we concatenate the existing specific release-notes into an aggregated release-note for the release when we build it.

Aside: when we develop something we start from a few points
	- We have a bug description, with a bug-number
	- We have some epic sub-task, often with a bug-number
	- We identify some issue in the code, very rarely do we have a bug-number

All of these result in some set of code-changes represented by commits in our VCS with attached commit-messages. 

I use a todo.txt to plan out my changes in short tasks and plans. Once the feature, fix or improvement is done this is the perfect starting-point for a release-note.

Demo:

/Project/Todo/FooBugfix/todo.txt

There's something wrong with the Foo. Probably a frazzled garm.
	- Fix foo
	
Later

/Project/Todo/FooBugfix/todo.txt

There's something wrong with the Foo. Probably a frazzled garm. Garms must be configurable.
	- Fix foo
	x make the foo testable
	x test null parameters on foo init
	x handle fooException
	- make the foo-connector configurable
	
Still later

/Project/Todo/FooBugfix/todo.txt

There's something wrong with the Foo. Probably a frazzled garm. Garms must be configurable.
	x Fix foo
	x make the foo testable
	x test null parameters on foo init
	x handle fooException
	x make the foo-connector configurable
	x update configuration-files with foo-configuration
	x document foo-configuration for dev/test/production
	
Everything is now done, and I think the foo bugfix is ready for master (I'm so proud). I copy the todo.txt into the Releasenotes folder in a subfolder with a pertinent name

/Project/Todo/FooBugfix/todo.txt (deleted)
/Project/Releasenotes/FooBugfix/releasenotes.txt

There's something wrong with the Foo. Probably a frazzled garm. Garms must be configurable.
	x Fix foo
	x make the foo testable
	x test null parameters on foo init
	x handle fooException
	x make the foo-connector configurable
	x update configuration-files with foo-configuration
	x document foo-configuration for dev/test/production

The reviewer may want to add her own todo when reviewing, something like

/Project/Todo/FooBugfix/review.txt 
Review FooBugfix
	- Code-review
	- Configuration review
	- Functional test
	
The review can result in a new todo.txt with issues the reviewer identifies, and I will fix those et cetera.

Finally the FooBugfix is merged into master, and deployed to the development servers. Pride and beer follows. Once we reach an agreed upon level of stability and improvements (or, more realistically the date of the release is reached) the build-master is tasked with creating a release from the current state of the master-branch. This branch must be accompanied by a release-note communicating what has changed and any dependencies the new release-package has.

Let us say the release-notes folder looks like this
/Project
	/ReleaseNotes
		/FooBugfix
			/releasenotes.txt
		/GurbFeature
			/releasenotes.txt
		/Superfun
			/releasenotes.xt
			
Part of the release-build is then to concatenate the specific releasenotes to one with all of them. This is done easily by running the following command in the releasenotes folder (windows)
"for /R %F in (releasenotes.txt) do @type %F >> full_releasenotes.txt & echo. >> full_releasenotes.txt"

on a unix system the following command should work 
"for f in */releasenotes.txt; do (cat "${f}"; echo) >> full_releasenotes.txt; done"

The end result is a file full_releasenotes.txt with the release-specific notes on top and the releasenotes for each bugfix, feature and improvement listed under it.

This will solve much of our merge problems.

In the future we should start using semantic release-notes to allow for generation of prettier release-notes that can order fixes, features, improvements and the like based on their tags. See http://www.semanticreleasenotes.org/
