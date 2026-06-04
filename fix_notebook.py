import json

# Load the notebook
with open('d:/KULIAH/VSCODE/MAGANG/latihan1.ipynb', 'r', encoding='utf-8') as f:
    nb = json.load(f)

# Fix the last cell (markdown) to original
nb['cells'][-1]['source'] = ['### Membuat Sirkuit Kuantum Beneran ###']

# Add a new code cell
new_cell = {
    'cell_type': 'code',
    'execution_count': None,
    'id': 'new_cell',
    'metadata': {},
    'outputs': [],
    'source': [
        '# Membuat sirkuit Bell state sebagai contoh sirkuit kuantum beneran\n',
        'qc_bell = QuantumCircuit(2, 2)\n',
        'qc_bell.h(0)\n',
        'qc_bell.cx(0, 1)\n',
        'qc_bell.measure_all()\n',
        '\n',
        '# Menampilkan sirkuit\n',
        'display(qc_bell.draw(\'mpl\'))\n',
        '\n',
        '# Menjalankan pada simulator\n',
        'from qiskit_aer import AerSimulator\n',
        'simulator = AerSimulator()\n',
        'job = simulator.run(qc_bell, shots=1024)\n',
        'result = job.result()\n',
        'counts_bell = result.get_counts(qc_bell)\n',
        '\n',
        'print("Hasil pengukuran Bell state:")\n',
        'print(counts_bell)\n',
        '\n',
        '# Plot histogram\n',
        'plot_histogram(counts_bell)\n'
    ]
}
nb['cells'].append(new_cell)

# Save the notebook
with open('d:/KULIAH/VSCODE/MAGANG/latihan1.ipynb', 'w', encoding='utf-8') as f:
    json.dump(nb, f, indent=1)
