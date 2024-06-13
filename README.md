[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![GitHub Workflow Status](https://github.com/Ducasse/Infhub/actions/workflows/CI.yml/badge.svg)](https://github.com/Ducasse/Infhub/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/Ducasse/Infhub/badge.svg?branch=master)](https://coveralls.io/github/Ducasse/Infhub?branch=master)

# Table of Contents

- [Description](#description)
- [Usage](#usage)
- [Installation](#installation)
  - [Baseline String](#baseline-string)
- [Contribute](#contribute)
  - [Version management](#version-management)
- [License](#license)

# Description

Work in progress

# Usage

Work in progress

# Installation

```smalltalk
Metacello new   
   baseline: 'ICal';     
   repository: 'github://Ducasse/Infhub/src';      
   load.
```

## Baseline String 

If you want to add the InfHub to your Metacello Baselines or Configurations, copy and paste the following expression:

```smalltalk
        " ... "
        spec
                baseline: 'ICal' 
                with: [ spec repository: 'github://Ducasse/Infhub/src' ];
        " ... "
```

# Contribute

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

If you have discovered a bug or have a feature suggestion, feel free to create an issue on Github.

If you have any suggestions for how this package could be improved, please get in touch or suggest an improvement using the GitHub issues page.

If you'd like to make some changes yourself, see the following:    

  - Fork this repository to your own GitHub account and then clone it to your local device
  - Do some modifications
  - Test.
  - Add <your GitHub username> to add yourself as author below.
  - Finally, submit a pull request with your changes!
  - This project follows the [all-contributors specification](https://github.com/kentcdodds/all-contributors). Contributions of any kind are welcome!

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

