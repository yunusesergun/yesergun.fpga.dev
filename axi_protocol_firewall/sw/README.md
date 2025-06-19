# Vitis Project Creation

New Vitis is used instead of Vitis Classic, so project generation relies on `.py` rather than `.tcl`.

After Vivado project creation and export of `.xsa` file named `design_1_wrapper.xsa`, copy that file into folder containing `README.md`. Open terminal (Linux) or cmd (Windows) in that folder. Locate `settings64.bat` (Windows) or `settings64.sh`  (Linux) inside Vitis installation directory and source it.

```bash
D:\Xilinx\Vitis\2022.1\settings64.bat
```

Then, run following command to generate project and `.elf` file:

```bash
vitis -s script.py
```

In same terminal session, launch Vitis by running:

```bash
vitis
```

In Vitis GUI, set `workspace` to `vitis_workspace`. Generated `.elf` can be found under `vitis_workspace/app_ublaze/build`.
