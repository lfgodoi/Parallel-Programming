# 
# Parallel Computing of Moving Average 
# 
# Computing the moving average along an array of length N. 
# 
# Leonardo Franco de Godói
# 
 
#------------------------------------------------------------------------------ 
 
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
 
# Setting input (random) and output values (initially null) 
values = np.random.randint(11, size=1024) 
values = values.astype(np.float32) 
average = np.zeros(1024, dtype=np.float32) 
 
# Creating a context 
ctx = cl.create_some_context() 
 
# Creating a message queue 
queue = cl.CommandQueue(ctx) 
 
# Allocating memory on device and transferring input data from the host to the device memory 
mf = cl.mem_flags 
values_buf = cl.Buffer(ctx, mf.READ_ONLY | mf.COPY_HOST_PTR, hostbuf=values) 
average_buf = cl.Buffer(ctx, mf.WRITE_ONLY, average.nbytes) 
 
# Creating the kernel 
program = cl.Program(ctx, """
        __kernel void moving_average(__global float *values, 
		__global float *average)
		{      
		    float sum = 0;
		    int i = 0, width = 3, gid = get_global_id(0);
			int initial = gid - width;
			if(initial < 0){
				initial = -1;
			}            
			for(i = gid; i > initial; i--){                
			    sum += values[i]; 
			}     
			average[gid] = sum/width;  
		}  
		""").build() 
 
# Implementing the kernel to run on device
program.moving_average(queue, average.shape, None, values_buf, average_buf) 
 
# Transferring the results from kernel to host
cl.enqueue_copy(queue, average, average_buf) 
 
# Printing the results 
print("Moving average") print('\n' + "Input: ", values) print('\n' + "Output: ", average) 
