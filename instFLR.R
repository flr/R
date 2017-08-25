# instFLR.R - Installation script for FLR packages

# Copyright 2014 FLR Team. Distributed under the GPL 2.
# Author: Iago Mosqueira, JRC
# Maintainer: Iago Mosqueira, JRC

# NOTES:

# GET pkg DESCRIPTIONs
flr  <- available.packages(contriburl = contrib.url("http://flr-project.org/R"))

# OFFER FLR pkgs
pkgs <- select.list(rownames(flr), multiple=TRUE, title="FLR Packages")

# ---- FLash CHECK platform OS and arch
arch <- .Platform

if("FLash" %in% pkgs & arch$OS.type == "windows" & arch$r_arch != "i386")
		stop("WARNING: FLash pkg requires 32 bit R in Windows!")

if("FLasher" %in% pkgs & arch$OS.type == "windows" & arch$r_arch != "x64")
		stop("WARNING: FLasher pkg requires 64 bit R in Windows!")

# SUBSET desc
desc <- flr[flr[, 'Package'] %in% pkgs,,drop=FALSE]

# CHECK dependencies
deps <- gsub("[ \n]", "", gsub("\\(.*\\)", "", unlist(strsplit(paste(desc[, c("Depends", "Imports")]), ","))))

insp <- c("R", rownames(utils::installed.packages()))

# FIND missing
miss <- unique(unlist(lapply(deps, function(x) x[!x %in% insp])))

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
