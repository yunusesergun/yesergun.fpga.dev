# Creating Vitis Project

A terminal or command prompt should be opened inside `sw` directory. Then, Vitis must be sourced using the following command. The `settings64.bat` file (for Windows) or `settings64.sh` file (for Linux) must be located in Vitis installation directory.

```bash
D:\Xilinx\Vitis\2022.1\settings64.bat
```

After that, the following command is used to create the project and generate `.elf` file:

```bash
xsct vitis_build.tcl
```

You can also launch Vitis application from the same terminal by typing `vitis` command. Then, `sw/hwicap_ws` directory should be selected as the `Workspace`.
