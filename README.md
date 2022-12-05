# MeTA: ModErn Text Analysis

This fork of [MeTA](https://meta-toolkit.org) aims to simplify the maintenance of the project
for its use in CS 410 Text Information Systems at the [University of Illinois at Urbana-Champaign](https://cs.illinois.edu/).
Thus, a containerized version of MeTA is provided instead of the original installation instructions for each platform.
This container, based on [Ubuntu 22.04 LTS](https://hub.docker.com/_/ubuntu/), includes a pre-built version 
of MeTA with support for `amd64` and `arm64` architectures.

---

Please visit our [web page][meta-website] for information and tutorials
about MeTA!

# Outline
- [Intro](#intro)
    - [Documentation](#documentation)
    - [Tutorials](#tutorials)
    - [Citing](#citing)
- [Project Setup](#project-setup)
    - [Docker](#docker)

# Intro

MeTA is a modern C++ data sciences toolkit featuring

- text tokenization, including deep semantic features like parse trees
- inverted and forward indexes with compression and various caching strategies
- a collection of ranking functions for searching the indexes
- topic models
- classification algorithms
- graph algorithms
- language models
- CRF implementation (POS-tagging, shallow parsing)
- wrappers for liblinear and libsvm (including libsvm dataset parsers)
- UTF8 support for analysis on various languages
- multithreaded algorithms

## Documentation

Doxygen documentation can be found [here][doxygen].

## Tutorials

We have walkthroughs for a few different parts of MeTA on the
[MeTA homepage][meta-website].

## Citing

If you used MeTA in your research, we would greatly appreciate a citation for
our ACL demo paper:

```latex
@InProceedings{meta-toolkit,
  author    = {Massung, Sean and Geigle, Chase and Zhai, Cheng{X}iang},
  title     = {{MeTA: A Unified Toolkit for Text Retrieval and Analysis}},
  booktitle = {Proceedings of ACL-2016 System Demonstrations},
  month     = {August},
  year      = {2016},
  address   = {Berlin, Germany},
  publisher = {Association for Computational Linguistics},
  pages     = {91--96},
  url       = {http://anthology.aclweb.org/P16-4016}
}
```

# Project setup

## Docker
A Docker image with a pre-built version of MeTA is available on [GitHub Container Registry](https://github.com/illinois/meta/pkgs/container/meta/).

```bash
docker pull ghcr.io/illinois/meta:3.0.2
```

This docker image makes the MeTA binaries globally available, allowing you to run them from anywhere. For example, to perform [Basic Text Analysis](https://meta-toolkit.org/profile-tutorial.html) on a document, you can create a container from the image and run the following command:

```bash
docker run -it --rm --name meta --mount type=bind,source=$(pwd),target=/app --entrypoint bash ghcr.io/illinois/meta:3.0.2
profile /meta/config.toml doc.txt --stop
```

The docker command above will mount the current directory to the `/app` directory in the container.
This allows you to access the files in the current directory (e.g., `doc.txt`) from the container. Similarly,
a default `config.toml` file is provided in the `/meta` directory for easy access. However, you can still
provide your own `config.toml` file by placing it in the current directory of the host machine.

Additionally, a Dockerfile is provided in this repository for building the image locally.
The **Dockerfile** is based on [Ubuntu 22.04 LTS](https://hub.docker.com/_/ubuntu/) and supports
ARM (e.g., [Apple silicon](https://support.apple.com/en-us/HT211814)) and AMD64 architectures, among others.
To build the image locally, run the following command:

```bash
docker build -t meta:latest .
```

[homebrew]: http://brew.sh
[forum]: https://forum.meta-toolkit.org
[meta-website]: https://meta-toolkit.org
[doxygen]: https://meta-toolkit.org/doxygen/namespaces.html
