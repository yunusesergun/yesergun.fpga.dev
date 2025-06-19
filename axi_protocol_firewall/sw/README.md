# Vitis Projesinin Oluşturulması

Vitis Classic yerine yeni Vitis kullanılmıştır. Bu yüzden projenin oluşması için `.tcl` yerine `.py` kullanılmıştır.

Vivado projesi oluşturulup `.xsa` dosyası `design_1_wrapper.xsa` olarak export edildikten sonra bu `README.md` dosyasının olduğu dizine kopyalanır. Sonrasımda bu dizin içerisinde terminal veya cmd açılır. Vitis'in kurulu olduğu dizindeki `settings64.bat` (Windows için) veya `settings64.sh` (Linux için) dosyası bulunmalıdır.

```bash
D:\Xilinx\Vitis\2022.1\settings64.bat
```

Sonrasında aşağıdaki komut kullanılarak projenin ve `.elf` dosyasının oluşturulması sağlanır.

```bash
vitis -s script.py
```

Aynı komut satırında `vitis` komutu yazılarak Vitis uygulamasının açılması sağlanabilir. Sonrasında `Workspace` olarak `vitis_workspace` dizini gösterilmelidir. `elf` dosyası `vitis_workspace\app_ublaze\build` içerisinde bulunabilir.
