# VHDL + MATLAB: I/Q Signal Reader/Writer Testbench

This repository provides a practical testbench setup to simulate I/Q (In-phase and Quadrature) signal handling between VHDL and MATLAB. It includes:

- 📂 **VHDL**: File-based I/Q signal reader and writer with generic configurability.
- 📂 **Matlab**: Scripts to load and save I/Q data as complex arrays compatible with the VHDL format.

---

## 📁 Folder Structure

/VHDL
├── file_reader.vhd -- Reads I/Q from text (I0, Q0, I1, Q1...)  
├── file_writer.vhd -- Writes I/Q to text (one value per line)  
└── tb_reader_writer.vhd -- Testbench connecting reader & writer  
  
/Matlab  
├── read_complex_from_txt.m -- Load text file into complex array  
└── write_complex_to_txt.m -- Save complex array to text file  

---

## 🔄 Workflow Overview

1. **Write I/Q data in MATLAB** using `write_complex_to_txt.m`
2. **Read it in VHDL** with `file_reader.vhd`
3. **Process it** or loop it through your DUT
4. **Write back in VHDL** using `file_writer.vhd`
5. **Read results in MATLAB** using `read_complex_from_txt.m`

---

## ⚙️ Features

- Generic `DATA_WIDTH` and file paths in VHDL
- Fully synthesizable VHDL (suitable for simulation)
- **Interval-based** reading (e.g., read every N clock cycles)
- MATLAB-compatible text format (I followed by Q line-by-line)

---

## 📌 Example Format (text file)
```
100
-50
200
-25
```

→ Represents:
```matlab
[100 - 50i, 200 - 25i]  
```

## 📬 Contact  
Questions, improvements, or contributions are welcome! This setup is ideal for DSP testbenches, RF simulations, or I/Q streaming verification.

  
Let me know if you want to add:
- License
- Screenshots (e.g., waveform or MATLAB plots)
- A badge for simulator/tool support

This version keeps it simple but highly useful for engineers and students alike 🚀.
  
---

## 👤 Authors

- **Milad Mohammadi.B** – VHDL and MATLAB design, simulation setup  
- **ChatGPT (OpenAI)** – Assisted with code generation, explanation, and documentation  

