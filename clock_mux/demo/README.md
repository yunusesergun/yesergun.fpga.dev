# FPGA Projesinin Oluşturulması

Projeyi en baştan  oluşturmak için `fusesoc` kütüphanesi kullandım. FPGA projesinin fusesoc ile oluşturulabilmesi için aşağıdaki tool ve kütüphanelere ihtiyaç var:

- Vivado 2024.1
- pip
- make
- fusesoc

## Oluşturma Aşamaları

İlk olarak indirilen repo'nun `demo` dosyası içerisinde terminal (Linux) veya cmd (Windows) açılır. Sonrasında Vivado source edilir (örnek Windows için verilmiştir). Vivado'nun source edilebilmesi için kurulum dizini içerisinde `settings64.bat` aranmalıdır.

```bash
D:\Xilinx\Vivado\2024.1\settings64.bat
```

Sonrasında aşağıdaki iki komut kullanılarak projeyi oluşturmak için kullanılacak make dosyaları oluşturulur.

```bash
fusesoc library add clock_mux .
fusesoc run --no-export --target project --setup f:yunus:clock_mux
```

Oluşturulan `build` dosyasının içindeki dosyalara `cd` komutu ile girilir ve `Makefile` dosyasının olduğu dizinde durulur. Aşağıdaki komut ile Vivado projesi GUI üzerinden açılır.

```bash
make build-gui
```

## Notlar

Windows'ta yaparken projenin oluştuğu dizinin uzunluğu önemli. Belli bir karakter sayısı aşıldığında proje açılsa da doğru bir şekilde sentezlenmeyebilir. Böyle bir durumda oluşturulan proje daha kısa bir dizine kopyalanabilir.
