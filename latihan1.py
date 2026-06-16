import qiskit
from qiskit import QuantumCircuit
import qiskit.quantum_info as qi
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import IPython
from IPython.display import display, Latex



qc = QuantumCircuit(2) #artinya menginput 2 kubit (ada 2 kubit)
qc.h([0,1]) #artinya kubit ke 0 dikenai gerbang Hadamard

#menampilkan statenya (bagian kanan gerbang)
psi = qi.Statevector(qc)
display(psi.draw('Latex'))

# menampilkan gambar dari
#qc.draw('mpl').savefig('qc_picture.png')
#img = mpimg.imread('qc_picture.png')
#plt.imshow(img)
#plt.axis('off')  # Hide axes
#plt.show()
