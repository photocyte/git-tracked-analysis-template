# git-tracked-analysis-template
A bespoke template for spinning up a new folder that can be tracked with git and exported as a .zip to Zenodo

## Description of intended use
* `input_files` Actual or symlinked files for the tracked analysis 
  * Provenance tracking is implicit for "in-house" generated files, in the sense that the filename and/or checksum can be used to track down the original file on a given filesystem.
  * If using symlinks, they'd relatively link to files outside the templated folder (this is for convenience to quickly iterate on multiple analyses on a single filesystem w/ multiple analyses in separate folders) 
  * Ideally, everything in `input_files` should transition to `zenodo_items` once those upstream analyses that made the files are uploaded to Zenodo and assigned a DOI
* `derived_files` Modified forms or otherwise subsets of the `input_files`. Generated using code within the template, i.e. `run.sh`
* `zenodo_items` Actual files, within folders that are named with a manually modified form of a `doi:` URI, wherein the colon `:` and the internal slash `/` of the DOI identifier are replaced with double-dash `--` 
  * This is used to manually track provenance of files that were sourced from existing Zenodo items.
  * For the example folder `doi--10.5281--zenodo.10569208`, reversing the manually renaming produces `doi:10.5281/zenodo.10569208` , then `doi.org` can resolve it: https://doi.org/10.5281/zenodo.10569208 . The example file `EXAMPLE--KR_seqkit_replace_kv.2.0.tsv` is present in the .zip archive of [that linked Zenodo item](https://doi.org/10.5281/zenodo.10569208) (as `KR_seqkit_replace_kv.2.0.tsv`)
* `bin` A place to stage downloaded scripts from `setup_env.sh`, or a place to commit bespoke scripts
* `containers` A git untracked place to stage downloaded containers from `setup_env.sh`
* `sequenceserver` A folder intended to store (in the contained  `./run.sh`) the slightly finicky parameters for easy Docker or Singularity execution of [SequenceServer](https://sequenceserver.com)

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
* [https://handbook.datalad.org/en/latest/basics/101-127-yoda.html](https://handbook.datalad.org/en/latest/basics/101-127-yoda.html)
* [https://caltechlibrary.github.io/RDMworkbook/index.html#description](https://caltechlibrary.github.io/RDMworkbook/index.html#description)
* [https://jakefeala.substack.com/i/160652737/folder-structure](https://jakefeala.substack.com/i/160652737/folder-structure)

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
* Try not to keep any symlinks in this bare template. If working with cloud filesystems / object stores, they have divergent support and need to be paid attention to. But, feel free to use symlinks after the template has been initialized. They will be properly stored in `git` and in the `.zip` from `archive.sh`
* Check for symlinks with `find . -type l`
* The `zenodo_items` DOI renaming scheme, is admittedly a bit hackish. But, it is a lightweight way to track provenance of files copied from Zenodo items.
* The `setup_env.sh` defining of the conda environment on individual lines, is admittedly a bit hackish compared to using .yaml definitions of the environment.
