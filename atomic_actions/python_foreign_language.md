## Python foreign language
Using C extensions: Python supports C extensions, which are modules written in C that can be imported and used just like regular Python modules. This is how modules like NumPy and pandas achieve their performance: their computationally-intensive parts are implemented in C. Writing C extensions requires a good understanding of both C and Python's C API.

Using Cython: Cython is a programming language that is a superset of Python, but supports calling C functions and having static C data types in your Cython code. This allows you to write code that is closer to Python in syntax, but can be compiled to C for performance. You can then import and use your Cython modules in your Python code.

Using ctypes or cffi: These are two Python libraries that allow you to call C functions in dynamic link libraries/shared libraries, and to define C data types in Python using Python classes. These can be easier to use than writing a full C extension, especially for wrapping existing C libraries.

Using other languages that can interface with Python: There are other languages that can interface with Python and be used to write extensions, including Rust (with PyO3 or rust-cpython), Go (with go-python), C++ (with Boost.Python), and others.

Using FFI (Foreign Function Interface) libraries: Libraries like CFFI and ctypes allow Python to call C code directly, without the need to write a full extension module. This can be a simpler way to call into C code for performance-critical sections.