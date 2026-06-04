import json

# Create a new notebook with the original content plus the addition
nb = {
    "cells": [
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "import",
            "metadata": {},
            "outputs": [],
            "source": [
                "from qiskit import QuantumCircuit\n",
                "\n",
                "import qiskit.quantum_info as qi\n",
                "\n",
                "from IPython.display import display, Latex\n",
                "\n",
                "import sympy as sp"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "qc",
            "metadata": {},
            "outputs": [],
            "source": [
                "qc = QuantumCircuit(2) #default kubit di quantum circuit = 0\n",
                "\n",
                "qc.h([0, 1])\n",
                "\n",
                "qc.draw()\n",
                "\n",
                "qc.draw('mpl')"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "psi",
            "metadata": {},
            "outputs": [],
            "source": [
                "psi = qi.Statevector(qc)\n",
                "\n",
                "psi.draw('latex')"
            ]
        },
        {
            "cell_type": "markdown",
            "id": "comment1",
            "metadata": {},
            "source": [
                "#hasilnya merupakan tensor dari H|0|\n",
                "#gambar pakai bloch"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "bloch",
            "metadata": {},
            "outputs": [],
            "source": [
                "psi.draw('bloch') #awalnya kubit bernilai 0, dikenakan Hadamard jd state +\n",
                "#menghitung peluang\n",
                "\n",
                "probs = psi.probabilities()\n",
                "\n",
                "print(probs)"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "counts",
            "metadata": {},
            "outputs": [],
            "source": [
                "#mengukur psi sebanyak 1024 dan hasilnya bisa beda\" karena probabilistik\n",
                "\n",
                "counts = psi.sample_counts(shots=1024) \n",
                "\n",
                "print(counts)\n",
                "\n",
                "#artinya kubit 00 muncul sebanyak 251 kali dst\n",
                "from qiskit.visualization import plot_histogram\n",
                "\n",
                "plot_histogram(counts)"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "samples",
            "metadata": {},
            "outputs": [],
            "source": [
                "#algoritma counts itu bisa disimpan dengan\n",
                "\n",
                "samples = psi.sample_memory(shots=5)\n",
                "\n",
                "print(samples)"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "operator",
            "metadata": {},
            "outputs": [],
            "source": [
                "#mengukur nilai harap dari suatu operator\n",
                "\n",
                "#sparse pauli op digunakan utk membuat operator dlm kombinasi linier matriks pauli\n",
                "\n",
                "O = qi.SparsePauliOp(['ZZ', 'XX', 'II'], [0.1, -0.3, 0.5]) # O = a(ZZ)*tensor produk dari matriks identitas Z + bXX + cII\n",
                "\n",
                "O.to_operator()\n",
                "#untuk mengukur nilai harap ditentukan variabel\n",
                "\n",
                "O_h = psi.expectation_value(O)\n",
                "\n",
                "print(O_h)"
            ]
        },
        {
            "cell_type": "markdown",
            "id": "title",
            "metadata": {},
            "source": [
                "### Membuat Sirkuit Kuantum Beneran ###"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": None,
            "id": "bell",
            "metadata": {},
            "outputs": [],
            "source": [
                "# Membuat sirkuit Bell state sebagai contoh sirkuit kuantum beneran\n",
                "qc_bell = QuantumCircuit(2, 2)\n",
                "qc_bell.h(0)\n",
                "qc_bell.cx(0, 1)\n",
                "qc_bell.measure_all()\n",
                "\n",
                "# Menampilkan sirkuit\n",
                "display(qc_bell.draw('mpl'))\n",
                "\n",
                "# Menjalankan pada simulator\n",
                "from qiskit_aer import AerSimulator\n",
                "simulator = AerSimulator()\n",
                "job = simulator.run(qc_bell, shots=1024)\n",
                "result = job.result()\n",
                "counts_bell = result.get_counts(qc_bell)\n",
                "\n",
                "print(\"Hasil pengukuran Bell state:\")\n",
                "print(counts_bell)\n",
                "\n",
                "# Plot histogram\n",
                "plot_histogram(counts_bell)"
            ]
        }
    ],
    "metadata": {
        "kernelspec": {
            "display_name": "Python 3",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "name": "python",
            "version": "3.8.5"
        }
    },
    "nbformat": 4,
    "nbformat_minor": 5
}

# Save the notebook
with open('d:/KULIAH/VSCODE/MAGANG/latihan1.ipynb', 'w', encoding='utf-8') as f:
    json.dump(nb, f, indent=1)
