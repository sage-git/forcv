ForCV
=====

## What's this

Fortran wrapper of OpenCV

## History 

Just beginning.

## Requirements

OpenCV development libraries

#### Install

```bash
git clone somewhere
cd ForCV
mkdir build
cd build
cmake ..
make
sudo make install
```

Some example programs are prepared in `build/example`.

- displayTest
   - Create a window and draw three sine curves
- fileIOTest
   - Read png image file and write jpg image file `output.jpg`
   - Please prepare some png file before run


After `sudo make install` with defaut cmake, sample programs can be compiled with:

```bash
gfortran -I/usr/local/include -o test displayTest.f90 -L/usr/local/lib -lforcv_core -lforcv_highgui `pkg-config --libs opencv`
```

---

#### TODO

* Add more fucntions and parameters.
* Serve some wrapper subroutines that have fortran-friendly interfaces.
