# FPGA Projesinin Oluşturulması

Projeyi en baştan  oluşturmak için `fusesoc` kütüphanesi kullandım. FPGA projesinin fusesoc ile oluşturulabilmesi için aşağıdaki tool ve kütüphanelere ihtiyaç var:

- Vivado 2022.1
- pip
- make
- fusesoc

## Oluşturma Aşamaları

İlk olarak indirilen repo'nun `fpga` dosyası içerisinde terminal (Linux) veya cmd (Windows) açılır. Sonrasında Vivado source edilir (örnek Windows için verilmiştir). Vivado'nun source edilebilmesi için kurulum dizini içerisinde `settings64.bat` aranmalıdır.

```bash
D:\Xilinx\Vivado\2022.1\settings64.bat
```

Sonrasında aşağıdaki iki komut kullanılarak projeyi oluşturmak için kullanılacak make dosyaları oluşturulur.

```bash
fusesoc library add jtag_to_axi_master .
fusesoc run --target=synth --setup jtag_to_axi_master
```

`oluşturulan build` dosyasının içindeki dosyalara `cd` komutu ile gidilir ve `Makefile` dosyasının olduğu dizinde durulur. Aşağıdaki komut ile Vivado projesi GUI üzerinden açılır.

```bash
make build-gui
```

## Notlar

Windows'ta yaparken projenin oluştuğu dizinin uzunluğu önemli. Belli bir karakter sayısı açıldığında proje açılsa da doğru bir şekilde sentezlenmeyebilir. Böyle bir durumda oluşturulan proje daha kısa bir dizine kopyalanabilir.
