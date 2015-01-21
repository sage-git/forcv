ForCV
=====

### What's this

Fortran wrapper of OpenCV

### History

Just beginning.

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

Add `use forcv_core` `use forcv_highgui` `use forcv_types` lines on in your source code. 

Then add OpenCV libraries (`pkg-config --libs opencv`) on linking.

Be careful not to use the same function/variable names.

### Examples

Some example programs are prepared in `build/example`.

- displayTest
   * Create a window and draw three sine curves
- fileIOTest
   * Read png image file and write jpg image file `output.jpg`
   * Please prepare some png file before run


---

### TODO

* Add more fucntions and parameters.
* Serve some wrapper subroutines that have fortran-friendly interfaces.
