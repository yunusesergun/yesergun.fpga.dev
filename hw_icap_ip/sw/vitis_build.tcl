# Vitis çalışma alanını oluştur
set workspace "hwicap_ws"

# Eğer çalışma alanı zaten varsa, önce sil
if {[file exists $workspace]} {
    file delete -force $workspace
}
file mkdir $workspace

# Workspace'i set et
setws $workspace

# Platform oluştur
set platform_name "platform_ublaze"
set xsa_file "./design_1_wrapper.xsa"

platform create -name $platform_name -hw $xsa_file -proc microblaze_0 -os standalone
platform active $platform_name
platform generate

# Application oluştur
set app_name "app_ublaze"
app create -name $app_name -platform $platform_name -template "Empty Application" -proc microblaze

# Kaynak dosyaları import et
set src_dir "./src"
if {[file exists $src_dir]} {
    importsources -name $app_name -path $src_dir
}

# Uygulamayı build et
app build -name $app_name

# Hepsini tekrar build et
#bsp regenerate -name $app_name
platform generate
app build -name $app_name
