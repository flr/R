packages
========

CRAN-style repository for FLR packages, accesible via <http://flr-project.org/R>

The master branch can be synced automagiclly with gh-pages, the branch that gets pushed to <http://flr.github.io/packages>, by adding to the `.git/config` file the following two lines at the `[remote "origin"]` section

	push = +refs/heads/master:refs/heads/gh-pages
	push = +refs/heads/master:refs/heads/master

