# Mystique

This repo contains the full set of patches for extending Chromium's V8 JavaScript engine with dynamic taint analysis capabilities. We implemented this as part of our original research work on Mystique, a framework for analyzing browser extensions regarding their privacy practices, e.g., whether they steal and leak their users' privacy-sensitive information. More information about Mystique can be found in our [CCS'18 paper](https://mystique.csc.ncsu.edu/p1687-chen.pdf). We also provide a [web frontend](https://mystique.csc.ncsu.edu) to Mystique's analysis engine, where browser extensions can be uploaded and analyzed, and get back the results (currently supports analyzing Chrome and Opera extensions).

## Build Instructions

To make life easy for you, we will be using Docker for the build process. But before that, make sure to have your own local copy of the Chromium source tree by following the instructions in the [official documentation](https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/linux/build_instructions.md).

* In a nutshell, what that boils down to is cloning Google's `depot_tools`, putting that in your `PATH`, and then fetching the Chromium source:

	* Cloning `depot_tools`: `git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git`
	* Updating `PATH`: `export PATH="$PATH:/path/to/depot_tools"`
	* Fetching Chromium source tree: `mkdir ~/chromium && cd ~/chromium && fetch --nohooks chromium` (`~/chromium` is where the fetched source will be, replace it with your desired location)

Next, the fun part. First you need to build the Docker image that we have prepared for you. This image will then do the actual build.

* Build the Docker image: `cd ~/mystique && docker build . -t chromium:dockerfile` (`~/mystique` is the path to this repo)

Once that is done, run the Docker image. This will check out the correct revision of Chromium against which Mystique was originally developed, patch the source tree, and then build.

* Run the Docker image and build Chromium:

	* Modify `run.sh` by replacing `CHROMIUM_SRC_DIR` at Line 3 to point to the path where your Chromium source tree is (i.e., `~/chromium` at the first step, _not_ `~/chromium/src`)
	* Run the Docker image and build: `cd ~/mystique && ./run.sh "su builder -c /do_build.sh"` (again, `~/mystique` is the path to this repo)

The build process takes about 2-3 hours on a desktop with 8 threads - your time might vary. If everything goes well, which it should, you will have a Chromium build with Mystique's taint analysis baked in!

## Citation

Now the obligatory citations part. Since this work was born out of academia, that is the bread and butter in our world. If you use Mystique in your research, please consider citing our work using this **Bibtex** entry:

```tex
@inproceedings{mystique_ccs18,
	author = {Chen, Quan and Kapravelos, Alexandros},
	title = {Mystique: Uncovering Information Leakage from Browser Extensions},
	booktitle = {Proceedings of the 2018 ACM SIGSAC Conference on Computer and Communications Security},
	series = {CCS '18},
	year = {2018},
	isbn = {978-1-4503-5693-0},
	location = {Toronto, Canada},
	pages = {1687--1700},
	numpages = {14},
	url = {http://doi.acm.org/10.1145/3243734.3243823},
	doi = {10.1145/3243734.3243823},
	acmid = {3243823},
	publisher = {ACM},
	keywords = {browser extensions, information flow, javascript, privacy, taint analysis},
}
```

