# QuanEstimation.jl
![GitHub release (latest by date)](https://img.shields.io/github/v/release/QuanEstimation/QuanEstimation.jl?label=version)
[![][docs-img]][docs-url]
[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![][action-img]][action-url]
[![][codecov-img]][codecov-url]
[![Downloads](https://img.shields.io/badge/dynamic/json?url=http%3A%2F%2Fjuliapkgstats.com%2Fapi%2Fv1%2Ftotal_downloads%2FQuanEstimation&query=total_requests&label=Downloads)](https://juliapkgstats.com/pkg/QuanEstimation)

[action-img]: https://github.com/QuanEstimation/QuanEstimation.jl/actions/workflows/CI_QuanEstimation.yml/badge.svg
[action-url]: https://github.com/QuanEstimation/QuanEstimation.jl/actions
[codecov-img]: https://codecov.io/gh/QuanEstimation/QuanEstimation.jl/graph/badge.svg
[codecov-url]: https://codecov.io/gh/QuanEstimation/QuanEstimation.jl
[docs-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-url]: https://quanestimation.github.io/QuanEstimation/

QuanEstimation.jl is an open-source toolkit for quantum parameter estimation, which can be used to perform general evaluations of many metrological 
tools and scheme designs in quantum parameter estimation. 

This package is also the Julia implementation of [QuanEstimation](https://github.com/QuanEstimation/QuanEstimation).

## Installation

Run the command in the julia REPL to install QuanEstimation:  

~~~
julia > using Pkg 

julia > Pkg.add("QuanEstimation")
~~~

## Citation
If you use QuanEstimation in your research, please cite the following papers:

[1] M. Zhang, H.-M. Yu, H. Yuan, X. Wang, R. Demkowicz-Dobrzański, and J. Liu, 
QuanEstimation: An open-source toolkit for quantum parameter estimation, 
[Phys. Rev. Res. **4**, 043057 (2022).](https://doi.org/10.1103/PhysRevResearch.4.043057)

[2] H.-M. Yu and J. Liu, QuanEstimation.jl: An open-source Julia framework for quantum parameter estimation, 
[Fundam. Res. (2025).](https://doi.org/10.1016/j.fmre.2025.02.020)
