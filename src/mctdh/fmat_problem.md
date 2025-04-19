# Problems with MCTDH and how to fix it

> Report by: Mendez Martin

## Problem
When using the program `fmat86`, we get the following error:

```bash
user@prompt:~$ fmat86 -O qho
    ********************************************************************************
    The psi-file   is : ~/full_path_directory/psi
    The oper-file  is : ~/full_path_directory/oper
    The output dir is : ~/full_path_directory
    The DVR-file   is : ~/full_path_directory/dvr
    program-version =  8.6. 5 (psi-file)      8.6. 5 (oper-file)
    ------------------------------------------------------------------------------
    Number of degrees of freedom:   3
    Number of combined modes    :   2
    Number of electronic states :   2

    mode dof  dim   DVR     modelabel
    1    1 1001   sin     R         
    2    2  301   sin     Q         

    mode: No. of spf's per state : modelabels
    1 :  5  5 :  R 
    2 :  5  5 :  Q 

    There are   301 data sets on the psi file.
    tinit =   0.00 fs,  t-final =    30.00 fs,  tpsi =    0.10 fs.

    Using the hermitian scalar product.
    Using correlated operator : qho ,  nham =  3
    At line 152 of file ~/mctdh_versions/mctdh86.5.1/source/analyse/fmat.F (unit = 44)
    Fortran runtime error: Cannot open file '': No such file or directory

    Error termination. Backtrace:
    #0  0x7fdcf4a23e59 in ???
    #1  0x7fdcf4a24a71 in ???
    #2  0x7fdcf4a256dc in ???
    #3  0x7fdcf4cb6e30 in ???
    #4  0x7fdcf4cb712f in ???
    #5  0x5a501831c637 in ???
    #6  0x5a50183147e2 in ???
    #7  0x7fdcf462a1c9 in __libc_start_call_main
            at ../sysdeps/nptl/libc_start_call_main.h:58
    #8  0x7fdcf462a28a in __libc_start_main_impl
            at ../csu/libc-start.c:360
    #9  0x5a5018314814 in ???
    #10  0xffffffffffffffff in ???
```

The system reports an error at line 152 in `fmat.F`. No further details are available in the log file `fmat.log`.

```bash
user@prompt:~$ cat fmat.log
    ------ Host: "host-name" ----------Sat Apr 19 07:26:44 2025
                    

    --------------------------------------------------------------------------------
    ****** Source code version ******

    Program Version :     8
    Release         :     6
    Revision        :     5
    Patch level     :     1

    Heidelberg SVN repository no.: 1505
    Checkin date: Wed, 12 Jul 2023, 12:09:36
    Compiled: Fri, 03 Nov 2023, 13:11:04 ; Host: host-name
    Program name: fmat86
    --------------------------------------------------------------------------------


    **** Reading OPER file ****
            photon-molecule interaction
    Created on:
    ------ Host: "host-name" ----------Tue Apr 15 11:07:43 2025

    ------ Host: "host-name" ----------Sat Apr 19 07:26:44 2025
                    
    Options : fmat86 -O qho 

    The psi-file   is : ~/full_path_directory/psi
    The oper-file  is : ~/full_path_directory/oper
    The output dir is : ~/full_path_directory
    The DVR-file   is : ~/full_path_directory/dvr

    klo =    1,  khi =  301,  step =  1

    Operator = qho
    nham =  3,  operator = qho  kzahl:   4 0  khzahl:  0  0
```

## Solution

The error is traced to line 152 in the source file `fmat.F`.

```bash
user@prompt:~$ cdm
user@prompt:~/mctdh86.5.1$ code source/analyse/fmat.F 
```

Line 152 contains the following:

```fortran
    open (unit=iwtt,file=buffer(1:ilbl),form='formatted')
```

This statement indicates that the program will create an output file extracted from the string buffer, with a length of `ilbl`. Let's note that:

+ buffer is a program-level construct for temporary data handling (not hardware cache).

+ It's used to improve efficiency, simplify parsing, or manage I/O operations in Fortran.

A solution would be to explicitly instruct the code not to create an output file from buffer, but instead generate one through conventional means. We would implement this as follows:

```fortran
    ! Original: file = buffer(1:ilbl)  ! Creates file from buffer substring
    ! Modified version using conventional file creation:
    file = "default_filename.dat"  ! Explicit standard filename
```

Here we explicitly specify that the output file will be named `fmat.out`.

To verify the solution, we run the `fmat86` program again and confirm that:

+ The output data was created correctly
+ No errors were generated