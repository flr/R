# deps.R - DESC
# deps.R

# Copyright 2003-2014 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# Soundtrack:
# Notes:


# GET pkg DESCRIPTIONs
info <- tools:::.build_repository_package_db("./src/contrib/", fields=NULL,
	type="source", verbose=FALSE, unpacked=FALSE)

# CREATE Package matrix for package.dependencies
desc <-  do.call(rbind, lapply(info, function(x) t(as.matrix(x))))

# Packages in repo
pkgs <- unlist(lapply(info, function(x) x['Package']))
names(pkgs) <- sub('.Package', '', names(pkgs))

# OFFER pkgs
pkgs <- select.list(pkgs, multiple=TRUE)

# SUBSET desc
desc <- desc[desc[, 'Package'] %in% pkgs,]

# ADD File
desc <- cbind(desc,  names(pkgs))
colnames(desc)[16]<-'File'

# ADD Repository
desc <- cbind(desc, "http://flr-project.org/R")
colnames(desc)[17] <- 'Repository'

# CHECK dependencies
deps <- tools::package.dependencies(desc, check = FALSE)
insp <- utils::installed.packages()
deps <- lapply(deps, function(x) tools:::getDepList(x, insp))

# FIND missing
miss <- unlist(lapply(deps, function(x) x$Depends[!x$Depends %in% x$Installed]))

if(length(miss) > 0) {

  	# MSG
	print("INSTALLING pkg dependencies from CRAN")

	# DROP FLR pkgs
	miss <- miss[!miss %in% pkgs]

	install.packages(miss, repos=getOption('repos'))

}

# INSTALL from FLR repo
print("INSTALLING FLR packages")

install.packages(pkgs, repos="http://flr-project.org/R")
