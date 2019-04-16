---
title: "Verify git sign-off with TravisCI"
layout: post
tags:
- coding
--- 

I don't know how to explain my role as a contributor to the [mpiFileUtils](https://github.com/hpc/mpifileutils) project.
I joined because these tools are so incredibly useful and just plain cool!
I also wanted to represent HPC users and contribute documentation to get more people using them.
While I haven't touched the "core" code, I have [converted the build system to CMake](https://github.com/hpc/mpifileutils/pull/208), created distinct [user](https://mpifileutils.readthedocs.io/) and [developer](https://github.com/hpc/mpifileutils/wiki) documentation, and begun acting as [scrum master](https://en.wikipedia.org/wiki/Scrum_(software_development)) for the team's development process.

One thing I noticed recently is that our documented [contributing requirements](https://github.com/hpc/mpifileutils/blob/master/.github/CONTRIBUTING.md) did not match what we were doing in practice. 
Namely, our team had agreed to use 'signed-off' commits as part of our project (inspired by [OpenMPI](https://www.open-mpi.org/faq/?category=contributing#contribute-code)).
But, since we hadn't automated the check for it, the sign-off wasn't always happening.

So, today I set about remedying the situation.

## Verifying a git sign-off

We use a less strict form of git signatures, simply a "Signed-off-by" line in the commit message (rather than a full-blown gpg key signature).
This can/should be automatically added to a commit message with the `git commit -s` flag.
The check to see if the latest commit has the sign-off is simple: 

```shell
git show --summary HEAD | grep -q "Signed-off-by:"
```

## Integration with TravisCI

We already run some automated tests with [TravisCI](https://travis-CI.org).
Travis offers a `before_script` step which triggers before the build of our project.
This is the perfect place for the git-show + grep one liner!
Everything seemed to work... until I actually created the pull request for this change.
Strange.

Turns out, TravisCI not only checks that a branch passes the tests, but it also checks that a branch *merged with master* passes the tests.
Travis was doing a merge, thus changing the `HEAD`, before running the verify line.
So, the verify should only trigger for testing the branch.
Luckily, Travis provides an environment variable set to if the tests are running on a PR or not.

Thus, the one-liner becomes:

```shell
'if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then git show --summary HEAD | grep -q "Signed-off-by:"; fi'
```

With this small change it is now easy and automatic for our team to hold ourselves to the standards we've set.

## Caveats

The mpifileutils team has agreed that we won't enforce a sign-off on every commit, just the final commit of a pull request. 
Therefore, this check only looks at `HEAD`, the last commit that was made.