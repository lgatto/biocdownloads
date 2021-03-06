context("Package versions")

test_that("Package versions", {
    def <- biocpkgversion("MSnbase")
    rel <- biocpkgversion("MSnbase", "release")
    dev <- biocpkgversion("MSnbase", "devel")
    expect_identical(def, rel)
    expect_false(is.null(names(dev)))

    library("Biobase")
    rel <- biocpkgversion("MSnbase", USE.NAMES = FALSE)
    dev <- biocpkgversion("MSnbase", "devel", USE.NAMES = FALSE)
    expect_true(is.null(names(dev)))
    rel <- new("Versioned", versions = list(MSnbase = rel))
    dev <- new("Versioned", versions = list(MSnbase = dev))
    expect_true(classVersion(rel) < classVersion(dev))
    gh <- githubpkgversion("lgatto/MSnbase", USE.NAMES = FALSE)
    gh <- new("Versioned", versions = list(MSnbase = gh))
    expect_true(classVersion(dev) <= classVersion(gh))

    expect_is(biocpkgversion("GO.db", type = "annotation"), "character")
    expect_is(biocpkgversion("pRolocdata", type = "experiment"), "character")

    ps <- c("MSnbase", "pRoloc")
    expect_identical(length(ps), length(biocpkgversion(ps)))
    expect_identical(length(ps),
                     length(githubpkgversion(paste0("lgatto/", ps))))

    v1 <- githubpkgversion("pRoloc", "lgatto")
    v2 <- githubpkgversion("lgatto/pRoloc")
    expect_identical(v1, v2)

    expect_is(cranpkgversion("sequences"), "character")
    expect_identical(length(cranpkgversion(c("sequences", "MALDIquant"))),
                     2L)

    expect_error(githubpkgversion("foo", "bar"))
})

test_that("Package versions", {
    nav <- biocpkgversion("foo")
    expect_true(is.na(nav))
    expect_warning(nav <- biocpkgversion("pRolocdata", type = "software"))
    expect_true(is.na(nav))
})

test_that("Bioconductor version numbers", {
    v <- biocVersions()
    ## update me for every new release
    v0 <- c("3.8", "3.9")
    names(v0) <- c("release", "devel")
    expect_identical(v, v0)
})
