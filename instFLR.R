# instFLR.R - Installation script for FLR packages

# Copyright 2014 FLR Team. Distributed under the GPL 2.
# Author: Iago Mosqueira, JRC
# Maintainer: Iago Mosqueira, JRC

# NOTES:


# GET pkg DESCRIPTIONs
desc <- available.packages(contriburl = contrib.url("http://flr-project.org/R"))

# OFFER FLR pkgs
pkgs <- select.list(rownames(desc), multiple=TRUE, title="FLR Packages")

# ---- FLash CHECK platform OS and arch
arch <- .Platform

if("FLash" %in% pkgs & arch$OS.type == "windows" & arch$r_arch != "i386")
		stop("WARNING: FLash pkg requires 32 bit R in Windows!")

# SUBSET desc
desc <- desc[desc[, 'Package'] %in% pkgs,]

# CHECK dependencies
deps <- tools::package_dependencies(desc, check = FALSE)
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

