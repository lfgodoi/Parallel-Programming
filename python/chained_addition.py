'''

TITLE: 
   Parallel Chained Addition

DESCRIPTION:
   Using event synchronization to perform chained additions, 
   in which there is interdependence between the results.
   
VERSION: 
   Author: Leonardo Godói (eng.leonardogodoi@gmail.com)
   Creation date: 18-September-2018

REVISION HISTORY:
   V1.0 | 18-September-2018 | Leonardo Godói | Creation

'''

# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------

# Importing package for parallel processing in Python
import pyopencl as cl 
 
# Importing package for scientific computing with Python
import numpy as np 
 
# Setting options to avoid being asked about plataform/device 
import os 
os.environ['PYOPENCL_COMPILER_OUTPUT'] = '1' 
os.environ['PYOPENCL_CTX'] = '1'
 
# Setting two decimal places for float type representation 
np.set_printoptions(formatter={'float': '{: 0.2f}'.format})
 
# Tolerance applied to the test 
TOL = 0.001 

# Arrays length 
N = 4096 
 
# Kernel: Vectors Addition
kernelsource = """ 
__kernel void addition(
    __global float* x,
	__global float* y,
	__global float* z,
	const unsigned int count)
{     
    int i = get_global_id(0);   
	if (i < count)       
        z[i] = x[i] + y[i]; 
} 
""" 
 
# Main Routine 
 
#Creating a context 
context = cl.create_some_context() 
 
# Creating a command queue 
queue = cl.CommandQueue(context) 
 
# Creating the kernel program 
program = cl.Program(context, kernelsource).build() 
 
# Creating random arrays as inputs (a, b, e, g) and empty arrays as outputs (c, d, f) 
a = np.random.rand(N).astype(np.float32) 
b = np.random.rand(N).astype(np.float32) 
c = np.empty(N).astype(np.float32) 
d = np.empty(N).astype(np.float32) 
e = np.random.rand(N).astype(np.float32) 
f = np.empty(N).astype(np.float32) 
g = np.random.rand(N).astype(np.float32) 

# Creating buffers for the inputs and outputs 
a_buf = cl.Buffer(context, cl.mem_flags.READ_ONLY | cl.mem_flags.COPY_HOST_PTR, hostbuf=a) 
b_buf = cl.Buffer(context, cl.mem_flags.READ_ONLY | cl.mem_flags.COPY_HOST_PTR, hostbuf=b) 
e_buf = cl.Buffer(context, cl.mem_flags.READ_ONLY | cl.mem_flags.COPY_HOST_PTR, hostbuf=e) 
g_buf = cl.Buffer(context, cl.mem_flags.READ_ONLY | cl.mem_flags.COPY_HOST_PTR, hostbuf=g) 
c_buf = cl.Buffer(context, cl.mem_flags.WRITE_ONLY, c.nbytes) 
d_buf = cl.Buffer(context, cl.mem_flags.WRITE_ONLY, d.nbytes) 
f_buf = cl.Buffer(context, cl.mem_flags.WRITE_ONLY, f.nbytes) 

# Setting the arguments format 
addition = program.addition addition.set_scalar_arg_dtypes([None, None, None, np.uint32]) 
 
# Queuinging the kernel for the first time with the values of the first addition (c = a + b) 
event1 = addition(queue, a.shape, None, a_buf, b_buf, c_buf, N) event1.wait() 
 
# Queuing the kernel for the second time with the values of the second addition (d = c + e) 
event2 = addition(queue, e.shape, None, e_buf, c_buf, d_buf, N) event2.wait() 
 
# Queuing the kernel for the third time with the values of the third addition (f = d + g) 
addition(queue, g.shape, None, g_buf, d_buf, f_buf, N) 
 
# Transferring the results from kernel to host 
cl.enqueue_copy(queue, f, f_buf) 
 
# Checking if the parallel results are similar to the sequential results
correct = 0; 
for a_t, b_t, e_t, f_t, g_t in zip(a, b, e, f, g):
    dev = a_t + b_t + e_t + g_t     
	# Computing deviation     
	dev -= f_t     
	# Applying correction if square deviation is less than square tolerance     
	if dev*dev < TOL*TOL:         
	    correct += 1     
	else:         
	    print ("tmp", dev, "a", a, "b", b, "e", e, "g", g, "f", f) 
 
# Printing the results 
print("Entradas" + '\n', "A = ", a, '\n', "B = ", b, '\n', "E = ", e, '\n', "G = ", g) 
print('\n' + "Saída" + '\n', "F = ", f) 
print('\n' + "Teste dos resultados de F:", correct, "de", N, "resultados corretos.")

# -------------------------------------------------------------
# -------------------------------------------------------------
# -------------------------------------------------------------