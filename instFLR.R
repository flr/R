# deps.R - DESC
# deps.R

# Copyright 2003-2014 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# Soundtrack:
# Notes:

# GET pkg DESCRIPTIONs
desc <- available.packages(contriburl = contrib.url("http://flr-project.org/R"))

# OFFER pkgs
pkgs <- select.list(rownames(desc), multiple=TRUE, title="FLR Packages")

# SUBSET desc
desc <- desc[desc[, 'Package'] %in% pkgs,]

# CHECK dependencies
deps <- tools::package.dependencies(desc, check = FALSE)
insp <- utils::installed.packages()
deps <- lapply(deps, function(x) tools:::getDepList(x, insp))

# FIND missing
miss <- unique(unlist(lapply(deps, function(x) x$Depends[!x$Depends %in% x$Installed])))

if(length(miss) > 0) {

  	# MSG
	cat("INSTALLING pkg dependencies from CRAN \n")

	# DROP FLR pkgs
	miss <- miss[!miss %in% pkgs]

	install.packages(miss)

}

# INSTALL from FLR repo
cat("INSTALLING FLR packages \n")

install.packages(pkgs, repos="http://flr-project.org/R")

