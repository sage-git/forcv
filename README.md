ForCV
=====

### What's this

Fortran wrapper of OpenCV

### History

2015/1/20 git init
2015/1/22 forcv module

### Requirements

OpenCV development libraries

### Install

```bash
git clone https://github.com/sage-git/forcv.git
cd forcv
mkdir build
cd build
cmake ..
make
sudo make install
```

After `sudo make install` with defaut cmake, fortran programs use OpenCV can be compiled with:

```bash
gfortran -I/usr/local/include -o test displayTest.f90 -L/usr/local/lib -lforcv_core -lforcv_highgui `pkg-config --libs opencv`
```

#### Use without Installation

Put all src/*.f90 files on your project directory.
These fortran codes can be treated a part of your project.

Add
```Fortran
use forcv_core
use forcv_highgui
use forcv_types
```
or
```Fortran
use forcv
```
lines on in your source code. 

Then add OpenCV libraries (`pkg-config --libs opencv`) on linking
(in this case linking libforcv_*.a is not required).

Be careful not to use the same function/variable names.

### Examples

Some example programs and binaries of them are prepared in `build/example`.

- displayTest
   * Create a window and draw three sine curves
- fileIOTest
   * Read png image file and write jpg image file `output.jpg`
   * Please prepare some png file before run
- forcvTest
   * Test for forcv module

**CAUTION**

I haven't tested the functions that do not appeare in these examples.

### Module contents

- forcv_types.mod
   * Fortran replacement for core/types_c.h 
   * link libforcv_types.a  when `use forcv_types` statement is used
- forcv_core.mod
   * Fortran replacement for core/core_c.h 
   * link libforcv_core.a  when `use forcv_core` statement is used
- forcv_highgui.mod
   * Fortran replacement for highgui/highgui_c.h 
   * link libforcv_highgui.a  when `use forcv_highgui` statement is used
- forcv.mod
   * Fortran-friendly subroutines and structs
   * link libforcv.a  when `use forcv` statement is used
   * This library contains all other libraries, so linking only this library is enough

---

### TODO

* Add more fucntions and parameters.
* Proper treatments for images that are not 8-bit depth and 3 channels
* CV_IMAGE_ELEM (types.f90) should be treat elemtype argument
* Change variable names to more appropriated ones
* Rearrange library structures if needed
