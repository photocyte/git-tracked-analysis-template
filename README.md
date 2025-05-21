# git-tracked-analysis-template
A bespoke template for spinning up a new folder that can be tracked with git and exported as a .zip to Zenodo

* `input_files` Actual or symlinked files for the tracked analysis
* `derived_files` Modified forms or otherwise subsets of the `input_files`
* `bin` A place to stage downloaded scripts from `setup_env.sh`, or a place to commit bespoke scripts
* `containers` A git untracked place to stage downloaded containers from `setup_env.sh`

## Quick start
* `git clone` this repository
* Rename the folder from `git-tracked-analysis-template` to something clear and descriptive, optionally with a date timestamp. e.g. `2023-10-06_PKS_domain_to_module_conversion_script`
* Run `re-init.sh` to clean up and reinitialize the git tracking.
* Run `setup_env.sh` to create a Conda environment that pre-installs the bioinformatics tools I most commonly use, and the dependencies for `archive.sh`
* Iterate on your analysis code, figures, etc. Use git tracking along the way, and `git tag -a v1.1` of major and minor versions i.e. `v1.1` when significant stopping points for external sharing of the analysis are reached
* Use `archive.sh` to pack the most recent commit of the analysis into a .zip, for manual uploading to Zenodo. Be sure to set the Zenodo version of the uploaded item to the git tagged version, thereby allowing for clear provenance traceability between the live git-tracked analysis and the snapshot on Zenodo.  

## Other Research Data Management (RDM) resources 

### File and folder organizing strategies and schemas
* [https://www.projecttier.org/tier-protocol/protocol-4-0/](https://www.projecttier.org/tier-protocol/protocol-4-0/)
* [https://handbook.datalad.org/basics/101-127-yoda](https://handbook.datalad.org/basics/101-127-yoda)
* [https://caltechlibrary.github.io/RDMworkbook/index.html#description](https://caltechlibrary.github.io/RDMworkbook/index.html#description)

---

### Concepts
* TidyData [http://www.jstatsoft.org/v59/i10/](http://www.jstatsoft.org/v59/i10/)

---

### Courses
* [https://carpentries-incubator.github.io/managing-computational-projects/instructor/09-rdm.html#tidy-spreadsheets](https://carpentries-incubator.github.io/managing-computational-projects/instructor/09-rdm.html#tidy-spreadsheets)
* [https://psychoinformatics-de.github.io/rdm-course/](https://psychoinformatics-de.github.io/rdm-course/)
* [https://slides.djnavarro.net/project-structure/](https://slides.djnavarro.net/project-structure/)
* [http://www2.stat.duke.edu/~rcs46/lectures_2015/01-markdown-git/slides/naming-slides/naming-slides.pdf](http://www2.stat.duke.edu/~rcs46/lectures_2015/01-markdown-git/slides/naming-slides/naming-slides.pdf)

---

### Tooling
* [https://github.com/vsbuffalo/scidataflow/](https://github.com/vsbuffalo/scidataflow/)
* [https://handbook.datalad.org/en/latest/](https://handbook.datalad.org/en/latest/)

---

### Coding / programming
* [https://the-turing-way.netlify.app/reproducible-research/testing](https://the-turing-way.netlify.app/reproducible-research/testing)

---

### Data repositories
* [https://zenodo.org](https://zenodo.org)
* [https://journals.plos.org/plosone/s/recommended-repositories#loc-omics](https://journals.plos.org/plosone/s/recommended-repositories#loc-omics)

---
### Notes
* Try not to keep any symlinks in this template. If working with cloud filesystems / object stores, they have divergent support and need to be paid attention to. But, feel free to use symlinks after the template has been initialized. They will be properly stored in `git` and in the `.zip` from `archive.sh`
* Check for symlinks with `find . -type l`
